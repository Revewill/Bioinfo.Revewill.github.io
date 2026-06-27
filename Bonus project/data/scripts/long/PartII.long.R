suppressPackageStartupMessages({
    library(edgeR)
    library(EDASeq)
    library(data.table)
})

# 1. Read matrix
count <- fread(
    "/root/exSEEK/CountMatrix/long RNA-seq/count.matrix.long.txt",
    data.table = FALSE
)

meta <- fread(
    "/root/exSEEK/CountMatrix/long RNA-seq/metadata.long.txt",
    data.table = FALSE
)

# 2. Adjust format
colnames(count)[-1] <- gsub("-PKU", "", colnames(count)[-1])
meta <- meta[match(colnames(count)[-1], meta$sample_id), ]

rownames(count) <- count[,1]
count <- count[,-1]

# 3. Filter genes with low expression
y <- DGEList(counts = count)
group <- factor(meta$label)

keep <- filterByExpr(y, group = group)
y <- y[keep, , keep.lib.sizes = FALSE]

# 4. Normalization
y <- edgeR::calcNormFactors(y, method = "TMM")
cpm.matrix <- edgeR::cpm(y)
logcpm.matrix <- edgeR::cpm(y, log = TRUE)

pdf(
    "/root/exSEEK/result/P2/long/RLE.plot.pdf",
    width = 12,
    height = 8
)
plotRLE(cpm.matrix)
dev.off()

# 5. Eliminate batch effect
expr <- t(logcpm.matrix)
pca <- prcomp(expr)

library_factor <- as.factor(meta$library)
library_numeric <- as.numeric(library_factor)
pdf("/root/exSEEK/result/P2/long/PCA.before.correction.pdf", width=10, height=8)
plot(pca$x[,1:2], 
     col = library_numeric, 
     pch = 19,
     main = "PCA Before Batch Correction",
     xlab = paste0("PC1 (", round(summary(pca)$importance[2,1]*100, 2), "%)"),
     ylab = paste0("PC2 (", round(summary(pca)$importance[2,2]*100, 2), "%)"))
legend("topright", 
       legend = levels(library_factor), 
       col = 1:length(levels(library_factor)), 
       pch = 19)
dev.off()

# PCA plot before correction suggests that no correction is needed.

# 6. Data scaling
expr_scaled <- scale(expr, center = TRUE, scale = TRUE)

# 7. Save data
write.table(
    logcpm.matrix,
    "/root/exSEEK/result/P2/long/logcpm.matrix.txt",
    sep = "\t",
    quote = FALSE,
    row.names = TRUE
)

write.table(
    expr_scaled,
    "/root/exSEEK/result/P2/long/scaled.txt",
    sep = "\t",
    quote = FALSE,
    row.names = TRUE
)

write.table(
    meta,
    "/root/exSEEK/result/P2/long/metadata.txt",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)