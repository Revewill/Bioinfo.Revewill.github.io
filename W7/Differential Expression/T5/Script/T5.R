# Read from table
edgeR.raw.data <- read.table(
    "uvr8.light.vs.dark.all.edgeR.txt",
    header = TRUE, sep = "\t", row.names = 1)
raw.data <- read.table(
    "count_exon.txt",
    header = TRUE, sep = "\t", row.names =1)

# Select genes in edgeR with FDR < 0.05
edgeR.filtered.data <- edgeR.raw.data[
    edgeR.raw.data$FDR < 0.05,]
# Sort genes based on logFC
edgeR.sorted.data <- edgeR.filtered.data[
    order(
        edgeR.filtered.data$logFC,
        decreasing = TRUE
    ),]
num <- nrow(edgeR.sorted.data)
edgeR.selected.genes <- rownames(edgeR.sorted.data[
    c(1:10, (num - 9):num),])

# Calculate log10CPM and z-scores for raw.data
library(edgeR)
y <- DGEList(counts = raw.data)
CPM.matrix <- edgeR::cpm(y, log = F)
log10.CPM.matrix <- log10(CPM.matrix + 1)
z.scores.matrix <- (log10.CPM.matrix - rowMeans(log10.CPM.matrix))/apply(log10.CPM.matrix, 1, sd)

# Select previous genes
z.scores.matrix <- z.scores.matrix[
    rownames(z.scores.matrix) %in% edgeR.selected.genes,]

# Draw heatmap
suppressPackageStartupMessages(library(ComplexHeatmap))
suppressPackageStartupMessages(library(circlize))
# Annotations
ann <- HeatmapAnnotation(
    Groups = rep(c(
        "dark, WT", "light, WT", "dark, uvr8", "light, uvr8"
        ), each = 3),
    col = list(Groups = c(
        "dark, WT" = "#245219",
        "light, WT" = "#9deb9d", 
        "dark, uvr8" = "#542354",
        "light, uvr8" = "#ea86c7"
    )),
    annotation_legend_param = list(
        Groups = list(
            title = "Groups",
            labels = c(
                "dark, WT", 
                "light, WT", 
                expression(paste("dark,", italic("uvr8"))),
                expression(paste("light,", italic("uvr8")))
            ),
            at = c("dark, WT", "light, WT", "dark, uvr8", "light, uvr8")
        )
    )
)

# Create map
heatmap <- Heatmap(
    z.scores.matrix,
    name = "T5_result_heatmap",
    column_title = "T5_results_heatmap",
    top_annotation = ann,
    cluster_columns = FALSE,
    column_split = rep(1:4, each = 3),
    row_split = 2,
    show_row_names = TRUE,
    show_column_names = TRUE,
    col = colorRamp2(c(-2, 0, 2), c("#2166AC", "#F7F7F7", "#B2182B")),  # 颜色设置
    row_names_gp = gpar(fontsize = 6),
    column_names_gp = gpar(fontsize = 6),
    heatmap_legend_param = list(
        title = "z-score",
        at = c(-2, -1, 0, 1, 2),
        labels = c("<= -2", "-1", "0", "1", ">= 2")
    )
)

# Save as pdf
pdf("T5_results_heatmap.pdf", width = 10, height = 12)
draw(heatmap)
dev.off()