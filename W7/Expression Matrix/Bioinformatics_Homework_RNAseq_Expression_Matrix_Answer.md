# Expression Matrix
> An answer `md` file for Bioinformatics_Homework_RNAseq_Expression_Matrix

> Direct to [T1](#t1), [T2](#t2), [T3](#t3), [T4](#t4) quickly here.
---
### T1
> Basic methods on `RNA-seq` expression normalization

> Direct to [top](#expression-matrix) quickly here.
#### 1. General class of normalization methods
* **Between-sample** normalization
  * Same gene, different samples
  * Mainly adjusts sequencing **depth**
* **Within-sample** normalization
  * Same sample, different genes
  * Mainly adjusts sequencing **length**

| Method | Depth adjustment | Length adjustment | Class |
| :---: | :---: | :---: | :---: |
| [`CPM`](#21-cpm-counts-per-million) | √ | × | Between-sample |
| [`RPKM`](#22-rpkm-reads-per-kilobase-per-million-mapped-reads)/[`FPKM`](#23-fpkm-fragments-per-kilobase-per-million-mapped-reads) | √ | √ | Within-sample |
| [`TPM`](#24-tpm-transcripts-per-million) | √ | √ | Within- and between-sample | 
| [`DESeq2 median`](#25-deseq2-median-of-ratio) | √ | × | Between-sample |
| [`TMM`](#26-tmm-trimmed-mean-of-m-values) | √ | × | Between-sample |
#### 2. Several basic normalization methods
##### 2.1 `CPM`, Counts per million
* Applies to **between-sample** analysis, sensitive to library capacity and genes with high expression
* Formula

$$
\text{CPM} = \frac{\text{raw counts}}{\text{total mapped reads}} \times 10^6
$$
##### 2.2 `RPKM`, Reads per kilobase per million mapped reads
* Applies to **single-end** sequencing data, sensitive to library capacity and genes with high expression
* Formula

$$
\text{RPKM} = \frac{\text{raw counts}}{(\text{gene length in kb}) \times (\text{total mapped reads in millions})}
$$
##### 2.3 `FPKM`, Fragments per kilobase per million mapped reads
* Applies to **paired-end** sequencing data, sensitive to library capacity and genes with high expression
* Formula

$$
\text{FPKM} = \frac{\text{fragments}}{(\text{gene length in kb}) \times (\text{total mapped fragments in millions})}
$$
##### 2.4 `TPM`, Transcripts per million
* Applies best to **between-sample** analysis, stable (with identical mean value between samples)
* Formula

$$
\text{RPK}_i = \frac{(\text{raw counts})_i}{(\text{gene length in kb})_i}
$$

$$
\text{TPM}_i = \frac{\text{RPK}_i}{\sum_j \text{RPK}_j} \times 10^6
$$
##### 2.5 `DESeq2` Median of Ratio
* Applies to **between-sample** analysis, insensitive to genes with high expression
* Formula

$$
s_j = \operatorname{median}_{i} \frac{k_{ij}}{\left(\prod_{v=1}^{m} k_{iv}\right)^{1/m}}
$$

$$
(\text{normalized counts})_{ij} = \frac{k_{ij}}{s_j}
$$
##### 2.6 `TMM`, Trimmed mean of M-values
* Developed by `edgeR`, applies to **between-sample** analysis
* Formula

$$
\log_2 \left( \hat{c}_j^{\text{TMM}} \right) = \frac{\sum_{i \in G^*} w_{ij} M_{ij}^r}{\sum_{i \in G^*} w_{ij}}
$$

---
### T2
> Multiple choice based on given picture

> Direct to [top](#expression-matrix) quickly here.
* **Question**
    If the library preparation method is **Standard illumina**, the actual raw counts of the Gene G is ();
    If the library preparation method is **Ligation method**, the actual raw counts of the Gene G is ();
    If the library preparation method is **dUTPs method**, the actual raw counts of the Gene G is ().
    A. 4
    B. 6
    C. 7
    D. 9
    E. 13
* **Answer**
  
  | Library prep method | Answer | Explanation |
  | :---: | :---: | :--- |
  | **Standard illumina** | **E.** 13 | **Non-strand-specific** method, raw counts = all reads mapped onto Gene G and its complementary strand |
  | **Ligation method** | **D.** 9 | **Strand-specfic** with **sense** reads 1 method, raw counts = reads 1 mapped onto Gene G and reads 2 mapped onto its complementary strand |
  | **dUTPs method** | **A.** 4 | **Strand-specific** with **antisense** reads 1 method, raw counts = reads 2 mapped onto Gene G and reads 1 mapped onto its complementary strand |
---
### T3
> Calculating read count matrix for `shape02`

> Direct to [top](#expression-matrix) quickly here.
#### T3.1 Sequencing protocol of `Shape02`
* Data in `Shape02` is **strand nonspecific**
* Method for judgement is shown here
    
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
    * From these outputs, we can infer the data is **strand non-specific** based on that **`"1++,1--,2+-,2-+"` fraction** is approximately equal to **`"1+-,1-+,2++,2--"` fraction**
#### T3.2 Generating read count matrix for `Shape02` data
> Check output file for read count matrix [here](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Expression%20Matrix/T3/Shape02.featurecounts.exon.txt)
> Click [here](#t33-counts-on-gene-at1g09530-pif3) to skip the following code

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
#### T3.3 Counts on gene `AT1G09530` (`PIF3`)

```bash
awk '$1 == "AT1G09530"{print $0}' result/Shape02.featurecounts.exon.txt \
> | awk '{print $NF}'
# Returns
86
```
---
### T4
> Heatmap analysis on transcriptome in cancer

> Direct to [top](#expression-matrix) quickly here.
* For `R` script, [download](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Expression%20Matrix/T4/Script/T4_script.R) or [view script here](#Rcode)
* For heatmap, check result in [`png`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Expression%20Matrix/T4/Results/T4_results_heatmap.png) or in [`pdf`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Expression%20Matrix/T4/Results/T4_results_heatmap.pdf) format
* Based on heatmap visualization, **transcriptomes of COAD and READ are most similar** due to their numerous co-occurrences within the same lineage

    <a name="Rcode"></a>
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
---