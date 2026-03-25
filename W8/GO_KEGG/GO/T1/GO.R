table <- read.table("wt.light.vs.dark.all.txt", header = TRUE, sep = "\t")
table <- table[!is.na(table$padj) & table$log2FoldChange > 1 & table$padj < 0.05,]
gennames <- rownames(table)
write.table(gennames, col.names = FALSE, file = "gennames.txt", append = FALSE, sep = "\t", row.names = FALSE)