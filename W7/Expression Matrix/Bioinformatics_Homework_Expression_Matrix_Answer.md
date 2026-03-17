# Expression Matrix
### T3

```bash
$ /usr/local/bin/infer_experiment.py \
> -r GTF/Arabidopsis_thaliana.TAIR10.34.bed \
> -i bam/Shape02.bam
# Returns
Reading reference gene model GTF/Arabidopsis_thaliana.TAIR10.34.bed ... Done
Loading SAM/BAM file ...  Total 200000 usable reads were sampled


This is PairEnd Data
Fraction of reads failed to determine: 0.0315
Fraction of reads explained by "1++,1--,2+-,2-+": 0.4769
Fraction of reads explained by "1+-,1-+,2++,2--": 0.4916
```

```bash
$ /home/software/subread-2.0.3-source/bin/featureCounts \
> -s 0 -p \
> -t exon \
> -g gene_id \
> -a GTF/Arabidopsis_thaliana.TAIR10.34.gtf 
> -o result/Shape02.featurecounts.exon.txt \
> bam/Shape02.bam
# Returns

        ==========     _____ _    _ ____  _____  ______          _____
        =====         / ____| |  | |  _ \|  __ \|  ____|   /\   |  __ \
          =====      | (___ | |  | | |_) | |__) | |__     /  \  | |  | |
            ====      \___ \| |  | |  _ <|  _  /|  __|   / /\ \ | |  | |
              ====    ____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
        ==========   |_____/ \____/|____/|_|  \_\______/_/    \_\_____/
          v2.0.3

//========================== featureCounts setting ===========================\\
||                                                                            ||
||             Input files : 1 BAM file                                       ||
||                                                                            ||
||                           Shape02.bam                                      ||
||                                                                            ||
||             Output file : Shape02.featurecounts.exon.txt                   ||
||                 Summary : Shape02.featurecounts.exon.txt.summary           ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : Arabidopsis_thaliana.TAIR10.34.gtf (GTF)         ||
||      Dir for temp files : result                                           ||
||                                                                            ||
||                 Threads : 1                                                ||
||                   Level : meta-feature level                               ||
||      Multimapping reads : not counted                                      ||
|| Multi-overlapping reads : not counted                                      ||
||   Min overlapping bases : 1                                                ||
||                                                                            ||
\\============================================================================//

//================================= Running ==================================\\
||                                                                            ||
|| Load annotation file Arabidopsis_thaliana.TAIR10.34.gtf ...                ||
||    Features : 313952                                                       ||
||    Meta-features : 32833                                                   ||
||    Chromosomes/contigs : 7                                                 ||
||                                                                            ||
|| Process BAM file Shape02.bam...                                            ||
||    Paired-end reads are included.                                          ||
||    The reads are assigned on the single-end mode.                          ||
||    Total alignments : 2730443                                              ||
||    Successfully assigned alignments : 2559170 (93.7%)                      ||
||    Running time : 0.08 minutes                                             ||
||                                                                            ||
|| Write the final count table.                                               ||
|| Write the read assignment summary.                                         ||
||                                                                            ||
|| Summary of counting results can be found in file "result/Shape02.featurec  ||
|| ounts.exon.txt.summary"                                                    ||
||                                                                            ||
\\============================================================================//

```

```bash
awk '$1 == "AT1G09530"{print $0}' result/Shape02.featurecounts.exon.txt \
> | awk '{print $NF}'
# Returns
86
```

[result file](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Expression%20Matrix/T3/Shape02.featurecounts.exon.txt)

### T4

[download script](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Expression%20Matrix/T4/Script/T4_script.R) or [view script here](#)

check results in [`png`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Expression%20Matrix/T4/Results/T4_results_heatmap.png) or in [`pdf`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Expression%20Matrix/T4/Results/T4_results_heatmap.pdf)

```R
main_dir <- "tumor-transcriptome-demo"
sub_dir <- c("COAD", "ESCA", "READ")

# all_data and all_files are empty lists for data storage
all_data <- list()
all_files <- list()

# Import data and files
for (i in sub_dir) {
    all_files[[i]] <- list.files(
        path = file.path(main_dir, i),
        pattern = "\\.txt$",
        full.names = TRUE)
    all_data[[i]] <- lapply(all_files[[i]], read.table)
}

# Extract rownames and colnames for matrix
# Gene names
genname <- all_data[["COAD"]][[1]][-1,]$V1

# Sample
index <- 1
sample <- c()
for (i in 1:3) {
    for (j in 1:50) {

        # Extract each sample name
        name <- strsplit(as.vector(all_files[[i]][j]), "/")[[1]]
        name <- name[3]
        name <- strsplit(name, ".txt")

        # Write into vector sample
        sample[index] <- paste(sub_dir[i], name, sep = ": ")

        # Add index
        index <- index + 1
    }
}

# Extract counts
counts.matrix <- matrix(NA,
    nrow = length(genname),
    ncol = length(sample),
)
rownames(counts.matrix) <- genname
colnames(counts.matrix) <- sample

index <- 1
for (i in 1:3) {
    for (j in 1:50) {
        # Calculate index
        index <- (i-1)*50 + j

        # Write into counts
        counts.matrix[,index] <- as.numeric(all_data[[i]][[j]][-1,]$V7)

        # Add index
        index <- index + 1
    }
}

# Create logCPM matrix
library(edgeR)
y <- DGEList(counts = counts.matrix)
CPM.matrix <- edgeR::cpm(y, log = F)
log10.CPM.matrix <- log10(CPM.matrix + 1)

# Create z-score matrix
z.scores.matrix <- (log10.CPM.matrix - rowMeans(log10.CPM.matrix))/apply(log10.CPM.matrix, 1, sd)

# Visualize in pheatmap
library(pheatmap)

# Clip
z.scores.clipped <- z.scores.matrix
z.scores.clipped[z.scores.clipped > 2] <- 2
z.scores.clipped[z.scores.clipped < -2] <- -2

# Fliter
rows_without_na <- !apply(z.scores.clipped, 1, function(x) any(is.na(x)))
z.scores.clipped <- z.scores.clipped[rows_without_na,]

# Annotation on rows and cols
annotation_col <- data.frame(
    CancerType = factor(rep(c("COAD", "ESCA", "READ"), each = 50))
)
rownames(annotation_col) <- colnames(z.scores.clipped)

ann_colors <- list(
    CancerType = c("COAD" = "#E41A1C",
                   "ESCA" = "#377EB8",
                   "READ" = "#4DAF4A"))

# Create map
pheatmap(z.scores.clipped,
         main = "T4_results_heatmap",
         cluster_cols = TRUE,
         cluster_rows = FALSE,
         cutree_cols = 5,
         annotation_col = annotation_col,
         annotation_colors = ann_colors,
         show_rownames = FALSE,
         show_colnames = FALSE,
         color = colorRampPalette(c("#2166AC", "#F7F7F7", "#B2182B"))(100),
         fontsize = 8,
         fontsize_row = 6,
         fontsize_col = 6,
         legend = TRUE,
         legend_breaks = c(-2, -1, 0, 1, 2),
         legend_labels = c("<= -2", "-1", "0", "1", ">= 2"),
         filename = "T4_results_heatmap.pdf",
         width = 10,
         height = 12
)
```