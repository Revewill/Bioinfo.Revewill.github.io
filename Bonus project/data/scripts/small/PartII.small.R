suppressPackageStartupMessages({
    library(edgeR)
    library(EDASeq)
    library(data.table)
    library(RUVSeq)
    library(reshape2)
    library(ggplot2)
})

# 1. Read matrix
count <- fread(
    "/root/exSEEK/CountMatrix/small RNA-seq/count.matrix.short.txt",
    data.table = FALSE
)

meta <- fread(
    "/root/exSEEK/CountMatrix/small RNA-seq/metadata.short.txt",
    data.table = FALSE
)

# 2. Adjust format
meta <- meta[match(colnames(count)[-1], meta[,1]), ]
colnames(meta)[1] <- "sample_id"

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
    "/root/exSEEK/result/P2/small/RLE.plot.pdf",
    width = 12,
    height = 8
)
plotRLE(cpm.matrix)
dev.off()

# 5. Check batch effect
expr <- t(logcpm.matrix)
pca <- prcomp(expr)

batch_cols <- c("RNA Isolation batch", "library prepration day", "gel cut size selection")
batch_labels <- c("RNA Isolation batch", "Library Preparation Day", "Gel Cut Size Selection")

pdf("/root/exSEEK/result/P2/small/PCA.before.correction.pdf", width = 15, height = 5)
par(mfrow = c(1, 3))

for (i in seq_along(batch_cols)) {
    batch_factor <- as.factor(meta[[batch_cols[i]]])
    batch_numeric <- as.numeric(batch_factor)
    
    plot(pca$x[,1:2],
         col = batch_numeric,
         pch = 19,
         main = batch_labels[i],
         xlab = paste0("PC1 (", round(summary(pca)$importance[2,1]*100, 2), "%)"),
         ylab = paste0("PC2 (", round(summary(pca)$importance[2,2]*100, 2), "%)"))
    
    legend("topright",
           legend = levels(batch_factor),
           col = 1:length(levels(batch_factor)),
           pch = 19,
           cex = 0.6)
}

dev.off()

# PCA plots of "Library Preparation Day" and "RNA Isolation Batch" before correction suggests that correction is needed.

# 6. Eliminate batch effect with RUVg
logcpm.matrix.before <- logcpm.matrix
logcpm_matrix_ruvg <- as.matrix(logcpm.matrix)

cv.index <- apply(logcpm_matrix_ruvg, 1, function(x) { sd(x) / mean(x) })
cv.index.sorted <- sort(cv.index)
empirical.control <- head(names(cv.index.sorted), as.integer(length(cv.index.sorted) * 0.2))

res <- RUVg(logcpm_matrix_ruvg, empirical.control, k = 2, isLog = TRUE)
logcpm.matrix <- res$normalizedCounts
expr <- t(logcpm.matrix)

pca_corrected <- prcomp(expr)

pdf("/root/exSEEK/result/P2/small/PCA.after.correction.pdf", width = 15, height = 5)
par(mfrow = c(1, 3))

for (i in seq_along(batch_cols)) {
    batch_factor <- as.factor(meta[[batch_cols[i]]])
    batch_numeric <- as.numeric(batch_factor)
    
    plot(pca_corrected$x[,1:2],
         col = batch_numeric,
         pch = 19,
         main = paste("After RUVg -", batch_labels[i]),
         xlab = paste0("PC1 (", round(summary(pca_corrected)$importance[2,1]*100, 2), "%)"),
         ylab = paste0("PC2 (", round(summary(pca_corrected)$importance[2,2]*100, 2), "%)"))
    
    legend("topright",
           legend = levels(batch_factor),
           col = 1:length(levels(batch_factor)),
           pch = 19,
           cex = 0.6)
}
dev.off()

sum_logcpm_before <- colSums(logcpm.matrix.before)
sum_logcpm_after <- colSums(logcpm.matrix)

pdf("/root/exSEEK/result/P2/small/boxplot.batch.effect.pdf", width = 12, height = 12)
par(mfrow = c(2, 2))

# RNA Isolation Batch
boxplot(sum_logcpm_before ~ meta$`RNA Isolation batch`,
        main = "RNA Isolation Batch",
        xlab = "Batch",
        ylab = "Sum of logCPM",
        col = "#2E9FDF",
        las = 1)
boxplot(sum_logcpm_after ~ meta$`RNA Isolation batch`,
        main = "RNA Isolation Batch After RUVg",
        xlab = "Batch",
        ylab = "Sum of logCPM",
        col = "#E67E22",
        las = 1)

# Library Preparation Day
boxplot(sum_logcpm_before ~ meta$`library prepration day`,
        main = "Library Preparation Day",
        xlab = "Batch",
        ylab = "Sum of logCPM",
        col = "#2E9FDF",
        las = 1)
boxplot(sum_logcpm_after ~ meta$`library prepration day`,
        main = "Library Preparation Day After RUVg",
        xlab = "Batch",
        ylab = "Sum of logCPM",
        col = "#E67E22",
        las = 1)

dev.off()

# 7. Data scaling
expr_scaled <- scale(expr, center = TRUE, scale = TRUE)

# 8. Save data
write.table(
    logcpm.matrix,
    "/root/exSEEK/result/P2/small/logcpm.matrix.txt",
    sep = "\t",
    quote = FALSE,
    row.names = TRUE
)

write.table(
    expr_scaled,
    "/root/exSEEK/result/P2/small/scaled.txt",
    sep = "\t",
    quote = FALSE,
    row.names = TRUE
)

write.table(
    meta,
    "/root/exSEEK/result/P2/small/metadata.txt",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)