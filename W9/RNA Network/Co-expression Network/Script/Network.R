# Prep
library(WGCNA)
setwd("/root/RNA.network")

# Load data
load("/root/RNA.network/input/homework_FemaleLiver-01-dataInput.RData")

# Soft thresholding power
options(stringAsFactors = FALSE)
enableWGCNAThreads()
powers = c(c(1:10), seq(from = 12, to = 20, by = 2))
sft = pickSoftThreshold(datExpr, powerVector = powers, verbose = 5)

pdf(file = "/root/RNA.network/output/homewk_soft_thresholding.pdf", width = 9, height = 5)
par(mfrow = c(1,2))
cex1 = 0.9

plot(sft$fitIndices[,1],
    -sign(sft$fitIndices[,3]) * sft$fitIndices[,2],
    xlab = "Soft Threshold (power)",
    ylab = "Scale Free Topology Model Fit, signed R^2",
    type = "n",
    main = paste("Scale independence"));

text(sft$fitIndices[,1],
    -sign(sft$fitIndices[,3]) * sft$fitIndices[,2],
     labels = powers,
     cex = cex1,
     col = "red");

abline(h = 0.90, col = "red")

plot(sft$fitIndices[,1],
    sft$fitIndices[,5],
     xlab = "Soft Threshold (power)",
     ylab = "Mean Connectivity",
     type = "n",
     main = paste("Mean connectivity"))

text(sft$fitIndices[,1],
    sft$fitIndices[,5],
    labels = powers,
    cex = cex1,
    col = "red")

dev.off()

# Module detection
net = blockwiseModules(datExpr,
    power = sft$powerEstimate,
    maxBlockSize = 6000,
    TOMType = "unsigned", minModuleSize = 30,
    reassignThreshold = 0, mergeCutHeight = 0.25,
    numericLabels = TRUE, pamRespectsDendro = FALSE,
    saveTOMs = TRUE,
    saveTOMFileBase = "FPKM-TOM",
    verbose = 3)

# Module visualization
mergedColors = labels2colors(net$colors)

pdf(file = "/root/RNA.network/output/homewk_module_visualization.pdf", width = 9, height = 5)
plotDendroAndColors(net$dendrograms[[1]],
    mergedColors[net$blockGenes[[1]]],
    "Module colors",
    dendroLabels = FALSE, hang = 0.03,
    addGuide = TRUE, guideHang = 0.05)

dev.off()