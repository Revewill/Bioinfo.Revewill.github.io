# Differential Expression
> An answer `md` file for Bioinformatics_Homework_RNAseq_Differential_Expression

> Direct to [T1](#t1), [T2](#t2), [T3](#t3), [T4](#t4), [T5](#t5) quickly here.
---
### T1
> Multiple test correction

> Direct to [top](#differential-expression) quickly here.
#### 1. Multiple test correction
* Definition
  * A statistical **adjustment** when conducting **multiple hypothesis tests simultaneously**
  * Addresses inflated error rates (**false positives**) due to **repeated** testing
* Example
  * Testing `1000` genes with a `p-value` threshold of `0.05` yields about `50` false positives *by chance*
  * Bengamini-Hochberg (`FDR` control) is a common method for multiple test correction
#### 2. Differences between `p-` and `q-value`
##### 2.1 `p-value`
* Is the **probability** of observing data **as actual results** under the assumption that **null hypothesis is true**
* Controls **per-comparison** error rate
  * If null is true, there's a `5%` chance of seeing this result.
##### 2.2 `q-value`, `FDR`
> `FDR`, False Discovery Rate
* Is the **expected proportion of false positives** among **all** rejected hypotheses
* Controls false discovery rate across **multiple tests**
  * There's an expected `5%` of significant yields that are false positives.
* Formula

$$
q_{(i)} = \min_{k \geq i} \left( \frac{m \times p_{(k)}}{k} \right)
$$
##### 2.3 Key differences

| Value | Scope | Interpretation |
| :---: | :---: | :--- |
| `p-value` | Single test | This result has a `5%` chance to occur assuming null is true. |
| `q-value`| Multiple test | This set of significant results contains about `5%` expected false positives. |
---
### T2
> Normalization methods in [`edgeR`](#1-normalization-in-edger-tmm) and [`DESeq2`](#2-normalization-in-deseq2-rle)

> Direct to [top](#differential-expression) quickly here.
#### 1. Normalization in `edgeR`: `TMM`
> `TMM`, Trimmed Mean of `M-values`

* Basic assumption
  * Most genes are **not differentially expressed** genes
  * **Normalization factor** could be calculated from weighted average of `M-values` to counterbalance deviations brought by **sequencing depth**
* Calculation method
  * 1. **Select a reference sample**
    * Select the sample of which the **`75%` quantile** of all gene expression levels is the **closest to average**
    * This sample is **reference sample**, marked as **$r$**
  * 2. **Calculate $M_g$ and $A_g$ values for each gene $g$**
    > $K_{gj}$ = raw count of gene $g$ in sample $j$
    > $D_{j}$ = all raw counts in sample $j$

    * `M-value` indicates **fold change** of gene $g$ in sample $j$ relative to $r$

        $$
        M_{g} \left(j,r \right) = \log_{2} \frac{K_{gj}/D_{j}}{K_{gr}/D_{r}}
        $$

    * `A-value` indicates the expression of gene $g$ in sample $j$ relative to $r$

        $$
        A_{g} \left(j,r \right) = \frac{1}{2} \log_{2} \left( {\frac{K_{gj}}{D_{j}}} \times{\frac{K_{gr}}{D_{r}}} \right)
        $$
  * 3. **Select a representative gene set**
    * Ensures a reliable gene set for calculating **normalization factor** by excluding potential **differentially expressed** genes
    * Trim `M-value` by `30%` and trim `A-value` by `5%`
    * The representative gene set after trimming is marked as $G$
  * 4. **Calculate weight for each gene in $G$**
    * Bestow higher weight upon genes with higher counts and higher stability

        $$
        w_{g} \left(j,r \right) = \left(\frac{D_{j} - K_{gj}}{D_{j} \times K_{gj}} + \frac{D_{r} - K_{gr}}{D_{r} \times K_{gr}} \right)^{-1}
        $$
  * 5. **Calculate `TMM` value for sample $j$**
    * `TMM` value is practically a weighted average of $M_g$

        $$
        \text{TMM} \left(j,r \right) = \frac{\sum_{g \in G} w_{g} \left(j,r \right) \times M_{g} \left(j,r \right)}{\sum_{g \in G} w_{g} \left(j,r \right)}
        $$

    * It represents the **deviation** of sample $j$ from $r$
  * 6. **Apply ultimate normalization factor**
    * Calculate **normalization factor $C_j$**

        $$
        C_{j} = 2 ^ {\text{TMM} \left(j,r \right)}
        $$

    * Apply $C_j$ to **normalize** counts

        $$
        \left(\text{Normalized count} \right)_{gj} = \frac{K_{gj}}{C_{j}}
        $$

#### 2. Normalization in `DESeq2`: `RLE`
> `RLE`, Relative Log Expression
* Basic assumption
  * Create a **virtual reference** sample using geometric mean
  * Calculate the **size factor** of each sample relative to this reference sample
* Calculation method
  * 1. **Create virtual reference**
    > $N$ = total sample count
    > $K_{gj}$ = raw count of gene $g$ in sample $j$
    * Calculate geometric mean for each gene $g$

        $$
        \mu_{g} = \sqrt[N]{\prod_{j=1}^{N} K_{gj}}
        $$
  * 2. **Calculate initial ratio matrix**
    * Calculate ratio

        $$
        \text{Ratio}_{gj} = \frac{K_{gj}}{\mu_{g}}
        $$

    * If $\text{Ratio}_{gj} > 1$, the expression of gene $g$ in sample $j$ is higher than average and *vice versa*
  * 3. **Calculate size factor for each sample**
    * **Median** of ratios represents the deviation of sample $j$ from $r$

        $$
        s_{j} = \text{median}_{g} \text{Ratio}_{gj}
        $$

    * **Median** is better than **mean** because **mean** is greatly affected by **extreme values**
  * 4. **Normalize counts with size factors**

    $$
    \left(\text{Normalized count} \right)_{gj} = \frac{K_{gj}}{s_{j}}
    $$

---
### T3
> Finding differentially expressed genes in *uvr8* using `DESeq2` and `edgeR`

> Direct to [top](#differential-expression) quickly here.
#### 1. `R` Script
* You may download `R` script for both [`DESeq2`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Differential%20Expression/T3/Script/T3.DESeq2.R) and [`edgeR`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Differential%20Expression/T3/Script/T3.edgeR.R) here
* The scripts are also shown here (direct to [`DESeq2`](#T3DESeq2code) or [`edgeR`](#T3edgeRcode))
  > Click [here](#2-txt-results) to skip the following codes
    
    [Script for `DESeq2`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Differential%20Expression/T3/Script/T3.DESeq2.R)
    <a name="T3DESeq2code"></a>
    ```R
    # Read from table and filter uvr8 counts
    raw.counts <- read.table(
        "count_exon.txt",
        sep='\t',
        header = TRUE,
        row.names = 1)

    uvr8.raw.counts <- raw.counts[,c(
        "UD1_1", "UD1_2", "UD1_3",
        "UD0_1", "UD0_2", "UD0_3")]

    uvr8.filtered.counts <- uvr8.raw.counts[rowMeans(
        uvr8.raw.counts) > 5, ]

    # Generate condition and colData for DESeq2
    uvr8.conditions <- factor(
        c(rep("Control", 3), rep("Treatment", 3)),
        levels = c("Control","Treatment"))

    uvr8.colData <- data.frame(
        row.names = colnames(uvr8.filtered.counts),
        conditions=uvr8.conditions)

    # Use DESeq2 to analyze data
    suppressPackageStartupMessages(library(DESeq2))
    # Create dataset
    uvr8.dataset <- DESeqDataSetFromMatrix(
        uvr8.filtered.counts,
        uvr8.colData,
        design = ~ conditions)
    # Analyze
    uvr8.dataset <- DESeq(uvr8.dataset)
    uvr8.result <- results(uvr8.dataset)

    # Output as .txt file
    write.table(
        uvr8.result,
        "uvr8.light.vs.dark.all.DESeq2.txt",
        sep='\t',
        row.names = TRUE,
        quote = FALSE)
    ```

    [Script for `edgeR`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Differential%20Expression/T3/Script/T3.edgeR.R)
    <a name="T3edgeRcode"></a>
    ```R
    # Read from table and filter uvr8 counts
    raw.counts <- read.table(
        "count_exon.txt",
        sep='\t',
        header = TRUE,
        row.names = 1)

    uvr8.raw.counts <- raw.counts[,c(
        "UD1_1", "UD1_2", "UD1_3",
        "UD0_1", "UD0_2", "UD0_3")]

    uvr8.filtered.counts <- uvr8.raw.counts[rowMeans(
        uvr8.raw.counts) > 5,]

    # Generate condition and design for DESeq2
    uvr8.conditions <- factor(
        c(rep("Control", 3), rep("Treatment", 3)),
        levels = c("Control","Treatment"))

    uvr8.design <- model.matrix(~ uvr8.conditions)

    # Use edgeR to analyze data
    library(edgeR)
    uvr8.result <- DGEList(counts = uvr8.filtered.counts)
    # Generate TMM matrix
    uvr8.result <- calcNormFactors(uvr8.result, method = "TMM")
    # Esimate dispersion
    uvr8.result <- estimateDisp(uvr8.result, design = uvr8.design)
    fit <- glmFit(uvr8.result, design = uvr8.design)
    # Likelihood ratio test (lrt)
    lrt <- glmLRT(fit, coef = 2) 

    # Output as .txt file
    uvr8.result <- topTags(lrt, n = nrow(uvr8.result))$table
    write.table(
        uvr8.result,
        "uvr8.light.vs.dark.all.edgeR.txt",
        sep='\t',
        row.names = TRUE,
        col.names = TRUE,
        quote = FALSE)
    ```
#### 2. `txt` Results
* You may download `txt` result files for both [`DESeq2`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Differential%20Expression/T3/Results/uvr8.light.vs.dark.all.DESeq2.txt) and [`edgeR`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Differential%20Expression/T3/Results/uvr8.light.vs.dark.all.edgeR.txt) here
---
### T4
> *Venn* diagram for comparison between `DESeq2` and `edgeR` results

> Direct to [top](#differential-expression) quickly here.
* For `R` script, [download](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Differential%20Expression/T4/Script/T4.R) or [view script here](#T4Rcode)
    > Click [here](#T4Rcodeend) to skip the following code

    <a name="T4Rcode"></a>
    ```R
    # Read from table
    DESeq2.raw.data <- read.table(
        "uvr8.light.vs.dark.all.DESeq2.txt",
        header = TRUE, sep = "\t", row.names = 1)
    edgeR.raw.data <- read.table(
        "uvr8.light.vs.dark.all.edgeR.txt",
        header = TRUE, sep = "\t", row.names = 1)

    # Select genes with significant expression changes
    DESeq2.filtered.data <- DESeq2.raw.data[
        !is.na(DESeq2.raw.data$padj) &
        abs(DESeq2.raw.data$log2FoldChange) > 1 &
        DESeq2.raw.data$padj < 0.05,]
    edgeR.filtered.data <- edgeR.raw.data[
        abs(edgeR.raw.data$logFC) > 1 &
        edgeR.raw.data$FDR < 0.05,]

    # Determine intersection number
    DESeq2.genes <- rownames(DESeq2.filtered.data)
    edgeR.genes <- rownames(edgeR.filtered.data)

    intersect <- length(intersect(DESeq2.genes, edgeR.genes))
    DESeq2.only <- length(setdiff(DESeq2.genes, edgeR.genes))
    edgeR.only <- length(setdiff(edgeR.genes, DESeq2.genes))

    # Create Venn diagram
    library(VennDiagram)
    grid.newpage()
    venn.plot <- draw.pairwise.venn(
        area1 = DESeq2.only + intersect,
        area2 = edgeR.only + intersect,
        cross.area = intersect,
        category = c("DESeq2", "edgeR"),
        fill = c("lightblue", "lightgreen"),
        alpha = 0.5,
        lty = "blank",
        cex = 1.5,
        cat.cex = 1.5,
        cat.pos = c(0, 0),
        cat.dist = 0.05
    )

    # Output as png
    png("T4_results_venndiagram.png", width = 800, height = 600, res = 120)
    grid.draw(venn.plot)
    dev.off()
    ```

<a name="T4Rcodeend"></a>
* For *venn* diagram, download [here](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Differential%20Expression/T4/Results/T4_results_venndiagram.png)
![venndiagram](./T4/Results/T4_results_venndiagram.png)
---
### T5
> Selecting appointed genes and creating heatmap

> Direct to [top](#differential-expression) quickly here.
* For `R` script, [download](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Differential%20Expression/T5/Script/T5.R) or [view script here](#T5Rcode)
    > Click [here](#T5Rcodeend) to skip the following code

    <a name="T5Rcode"></a>
    ```R
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
    ```
    <a name="T5Rcodeend">
* For heatmap, download in [`png`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Differential%20Expression/T5/Results/T5_results_heamap.png) or [`pdf`](https://revewill.github.io/Bioinfo.Revewill.github.io/W7/Differential%20Expression/T5/Results/T5_results_heamap.pdf)
![heatmap](./T5/Results/T5_results_heatmap.png)