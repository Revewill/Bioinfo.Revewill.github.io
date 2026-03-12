# 加载必要的包
library(stringr)
library(dplyr)

# ---------- 1. 读取原始 Markdown 文件 ----------
input_file <- "Rnotes.md"  # 你的原始文件名
lines <- readLines(input_file, warn = FALSE)

# ---------- 2. 初始化变量 ----------
new_lines <- c()                 # 构建新的行
in_code_block <- FALSE           # 是否在代码块内
code_block_content <- c()        # 暂存当前代码块内容
code_block_counter <- 0          # 代码块编号
block_indent <- ""               # 当前代码块的缩进（空格或制表符）
block_functions <- list()        # 存储每个代码块的函数列表

# 黑名单：这些词不会被当作函数处理
blacklist <- c("a", "M", "Returns", "t", "the", "uD", "v", "X")

# 辅助函数：提取代码块中的函数调用
extract_functions <- function(code_lines) {
  code <- paste(code_lines, collapse = "\n")
  if (trimws(code) == "") return(character(0))
  
  # 尝试解析
  parsed <- try(parse(text = code), silent = TRUE)
  if (inherits(parsed, "try-error")) {
    # 解析失败，使用简单正则匹配：字母数字点下划线后跟左括号，排除控制流关键字
    funcs <- str_extract_all(code, "\\b[[:alpha:].][[:alnum:]._]*\\s*\\(") %>%
      unlist() %>%
      str_trim() %>%
      str_replace("\\s*\\($", "")
    keywords <- c("if", "else", "for", "while", "repeat", "function", "switch", 
                  "try", "break", "next", "return", "TRUE", "FALSE", "NULL", 
                  "NA", "Inf", "NaN", "library", "require")
    funcs <- setdiff(unique(funcs), keywords)
    # 过滤掉空字符串
    funcs <- funcs[funcs != ""]
  } else {
    # 解析成功，获取函数调用
    parse_data <- getParseData(parsed)
    # 普通函数调用
    func_calls <- parse_data[parse_data$token == "SYMBOL_FUNCTION_CALL", "text"]
    # 命名空间调用
    ns_calls <- parse_data[parse_data$token == "NS_GET" | parse_data$token == "NS_GET_INT", ]
    if (nrow(ns_calls) > 0) {
      for (i in seq_len(nrow(ns_calls))) {
        row <- ns_calls[i, ]
        left <- parse_data[parse_data$id == row$id - 1, ]
        right <- parse_data[parse_data$id == row$id + 1, ]
        if (nrow(left) == 1 && nrow(right) == 1 &&
            left$token == "SYMBOL_PACKAGE" && right$token == "SYMBOL_FUNCTION_CALL") {
          func_calls <- c(func_calls, paste0(left$text, "::", right$text))
        }
      }
    }
    funcs <- unique(func_calls)
  }
  
  # 过滤黑名单
  funcs <- setdiff(funcs, blacklist)
  return(funcs)
}

# 辅助函数：生成安全的锚点ID（将 :: 替换为 -）
safe_anchor <- function(func_name) {
  gsub("::", "-", func_name)
}

# ---------- 3. 逐行处理 ----------
for (line in lines) {
  # 检测代码块开始：允许前面有任意数量的空格或制表符，后面紧跟 ```R 或 ```r
  if (!in_code_block && grepl("^([ \t]*)```[Rr]\\s*$", line, perl = TRUE)) {
    # 提取缩进
    block_indent <- str_match(line, "^([ \t]*)```[Rr]\\s*$")[1, 2]
    if (is.na(block_indent)) block_indent <- ""
    
    in_code_block <- TRUE
    code_block_counter <- code_block_counter + 1
    code_block_content <- c()
    
    # 添加锚点，保持相同缩进
    new_lines <- c(new_lines, paste0(block_indent, '<a name="code', code_block_counter, '"></a>'))
    new_lines <- c(new_lines, line)   # 添加原始代码块开始行
  } else if (in_code_block && grepl("^[ \t]*```\\s*$", line)) {
    # 结束代码块
    # 先添加结束标记行
    new_lines <- c(new_lines, line)
    
    # 解析函数
    funcs <- extract_functions(code_block_content)
    block_functions[[code_block_counter]] <- funcs
    
    # 生成脚注（仅当有函数时）
    if (length(funcs) > 0) {
      func_links <- sapply(funcs, function(f) {
        # 所有函数都添加指向注释部分的链接
        sprintf("[`%s`](#apx-%s)", f, safe_anchor(f))
      })
      footnote <- paste0(block_indent, "> <small>**Functions in this block:** ", 
                         paste(func_links, collapse = ", "), "</small>")
      new_lines <- c(new_lines, footnote)
    }
    
    in_code_block <- FALSE
  } else if (in_code_block) {
    # 代码块内容行
    new_lines <- c(new_lines, line)
    code_block_content <- c(code_block_content, line)
  } else {
    # 普通行
    new_lines <- c(new_lines, line)
  }
}

# ---------- 4. 生成注释部分 ----------
apx_lines <- c("\n# Apx. Cheatsheet\n")
# 收集所有出现的函数，并按字母顺序排序
all_funcs <- unique(unlist(block_functions))
func_order <- sort(all_funcs)

# 添加序号（按字母顺序）
for (i in seq_along(func_order)) {
  f <- func_order[i]
  anchor_id <- safe_anchor(f)
  
  # 找出所有出现位置
  occurrences <- which(sapply(block_functions[1:code_block_counter], function(x) f %in% x))
  # 生成内部序号 (1,2,3...)，链接指向对应的代码块锚点
  occ_links <- sapply(seq_along(occurrences), function(k) sprintf("[%d](#code%d)", k, occurrences[k]))
  occ_str <- paste(occ_links, collapse = " ")
  
  # 函数标题：四级标题 + 函数名 + 锚点 + 出现位置链接（内部序号）
  apx_lines <- c(apx_lines, sprintf("###### %d. <a name=\"apx-%s\"></a> `%s` : %s", i, anchor_id, f, occ_str))
  # 用 <small> 包裹详细内容，使字号略小
  apx_lines <- c(apx_lines, "<small>")
  apx_lines <- c(apx_lines, "</small>")
  apx_lines <- c(apx_lines, "")  # 空行分隔
}

# ---------- 5. 合并并输出 ----------
final_lines <- c(new_lines, apx_lines)
output_file <- "notes_annotated.md"
writeLines(final_lines, output_file)
cat("处理完成！结果已保存到", output_file, "\n")