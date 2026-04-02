library(xtail)
library(org.At.tair.db)
library(ggplot2)
library(ggrepel)

# Extract raw data
ribo <- read.table('Ribo_count_2.txt',
    header = TRUE, quote = '', sep = '\t', row.names = 1, stringsAsFactors = FALSE)
mrna <- read.table('RNA_count.txt',
    header = TRUE, quote = '', sep = '\t', row.names = 1, stringsAsFactors = FALSE)

# Filter
ribo <- ribo[,c("uvr8no1", "uvr8no2", "uvr8no3", "uvr8uvb1", "uvr8uvb2", "uvr8uvb3")]
mrna <- mrna[,c("CD1_1", "CD1_2", "CD1_3", "CD0_1", "CD0_2", "CD0_3")]
mrna <- mrna[rownames(ribo), ]

# Run xtail analysis
condition <- c("control", "control", "control", "treat", "treat", "treat")
res <- xtail(mrna, ribo,
    condition,
    minMeanCount = 1, bins = 10000)

# Save as txt
res <- resultsTable(res,
    sort.by = "pvalue.adjust", log2FCs = TRUE, log2Rs = TRUE)
write.table(res, "TE.res.txt", quote = FALSE, sep = "\t")

# Add -log10(p-value)
res$log10p <- -log10(res$pvalue_final)

# Define significance thresholds
res$significance <- "Not significant"
res$significance[res$pvalue.adjust < 0.05 & res$log2FC_TE_final > 0] <- "Upregulated"
res$significance[res$pvalue.adjust < 0.05 & res$log2FC_TE_final < 0] <- "Downregulated"

# Calculate combined score: -log10(p) * |log2FC|
res$score <- res$log10p * abs(res$log2FC_TE_final)

# Map AT IDs to gene symbols
gene_ids <- rownames(res)
gene_ids_clean <- sub("\\..*$", "", gene_ids)
gene_symbols <- mapIds(org.At.tair.db,
                       keys = gene_ids_clean,
                       keytype = "TAIR",
                       column = "SYMBOL",
                       multiVals = "first")

# Use original ID as label, replace with symbol if available
res$gene_label <- rownames(res)
res$gene_label[!is.na(gene_symbols)] <- gene_symbols[!is.na(gene_symbols)]

# Select only significant genes
sig_genes <- res[res$pvalue.adjust < 0.05, ]

# Select top 3 upregulated from significant genes
up_genes <- sig_genes[sig_genes$log2FC_TE_final > 0, ]
if(nrow(up_genes) > 0) {
    up_genes <- up_genes[order(up_genes$score, decreasing = TRUE), ][1:min(3, nrow(up_genes)), ]
}

# Select top 3 downregulated from significant genes
down_genes <- sig_genes[sig_genes$log2FC_TE_final < 0, ]
if(nrow(down_genes) > 0) {
    down_genes <- down_genes[order(down_genes$score, decreasing = TRUE), ][1:min(3, nrow(down_genes)), ]
}

# Combine top genes
top_genes <- rbind(up_genes, down_genes)

# Add label (gene_label already has fallback to original ID)
top_genes$label <- top_genes$gene_label

# Add a column to mark if point is labeled
res$is_labeled <- rownames(res) %in% rownames(top_genes)

# Create a custom color column
res$point_color <- "grey"
res$point_color[res$significance == "Upregulated" & !res$is_labeled] <- "#FF86A4"
res$point_color[res$significance == "Downregulated" & !res$is_labeled] <- "#6FD4FF"
res$point_color[res$significance == "Upregulated" & res$is_labeled] <- "red"
res$point_color[res$significance == "Downregulated" & res$is_labeled] <- "blue"

# Volcano plot with labels
ggplot(res, aes(x = log2FC_TE_final, y = log10p)) +
  geom_point(aes(color = point_color), alpha = 0.8, size = 1.5) +
  scale_color_identity() +
  geom_vline(xintercept = 0, linetype = "dashed", color = "black") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "black") +
  geom_text_repel(data = top_genes,
                  aes(x = log2FC_TE_final, y = log10p, label = label),
                  size = 4,
                  box.padding = 0.5,
                  point.padding = 0.3,
                  max.overlaps = 10) +
  labs(x = "log2 Fold Change (TE)", 
       y = "-log10(p)",
       title = "Volcano Plot for TE") +
  theme_bw() +
  theme(legend.position = "none")

ggsave("TE.volcano_plot.png", width = 10, height = 7, dpi = 300)