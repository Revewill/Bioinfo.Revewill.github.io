# GO
> An answer `md` file for Bioinformatics_Homework_Function_Analysis_GO

> Direct to [T1](#t1), [T2](#t2) quickly here.
---
### T1
> `GO` analysis on given data

* Acquire gene list via `R`
    * View [`R` script](./T1/GO.R)

    ```R
    table <- read.table("wt.light.vs.dark.all.txt",
        header = TRUE, sep = "\t")
    table <- table[!is.na(table$padj) &
        table$log2FoldChange > 1
        & table$padj < 0.05,]
    gennames <- rownames(table)
    write.table(gennames, col.names = FALSE,
        file = "gennames.txt",
        append = FALSE, sep = "\t", row.names = FALSE)
    ```
    * View [gene name list](./T1/gennames.txt)
        The list was processed by the following command to remove `"`

        ```bash
        $ sed -i 's/"//g' gennames.txt
        ```
* Run `GO` analysis and screen results
  * View initial [`GO` analysis report](./T1/GO.raw.analysis.txt)
  * The following are some of the most significant and conclusive results

| GO term | Reference | Input number | expected | Fold Enrichment | +/- | raw P value | FDR |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
positive regulation of flavonol biosynthetic process | 3 | 3 | 0.04 | 74.26 | + | 2.42E-06 | 2.72E-04 |
regulation of carbohydrate utilization | 2 | 2 | 0.03 | 74.26 | + | 1.81E-04 | 1.24E-02 |
2,4,6-trinitrotoluene catabolic process | 2 | 2 | 0.03 | 74.26 | + | 1.81E-04 | 1.19E-02 |
chloroplast elongation | 2 | 2 | 0.03 | 74.26 | + | 1.81E-04 | 1.16E-02 |
**cellular response to UV-A** | 4 | 3 | 0.05 | 55.69 | + | 9.59E-06 | 1.02E-03 |
monoterpenoid biosynthetic process | 3 | 2 | 0.04 | 49.50 | + | 5.38E-04 | 2.82E-02 |
photoreactive repair | 3 | 2 | 0.04 | 49.50 | + | 5.38E-04 | 2.74E-02 |
---
### T2
> `GO` parameters explained

* Fold enrichment
  * Create a table

    | Set | In this `GO` term | Not in this `GO` term
    | :---: | :---: | :---: |
    | Submitted | $a$ | $b$ |
    | Reference genome | $c$ | $d$ |
  * Formula

    $$
    \text{Fold Enrichment} = \frac{a/(a+b)}{c/(c+d)}
    $$

  * Explanation
    * Indicates the "density" of a `GO` term in the submitted gene set relative to reference
    * `> 1` stands for **over-represented**, enriched; `< 1` stands for **under-represented**, lacked
* P-value
  * Formula

    $$
    P = \sum_{k = a}^{\min(a+b, c)} 
    \frac{\binom{c}{k} \binom{d}{a+b - k}}
    {\binom{c+d}{a+b}}
    $$

  * Explanation
    * Indicates significance under `FISHER` test, the probability of the observed **Fold Enrichment** occurring by chance
    * The formula is based on **hypergeometric** distribution as is `FISHER` test
    * Lower `P-value` theoretically suggests greater reliability
* FDR
  > FDR, False Discovery Rate
  * Total number of `GO` terms affects false positives
    * *i.e.*, if total number of `GO` terms is $N$, P-value is $P$, $NP$ false positives would occur expectedly
  * `FDR` estimates **the expected proportion of false positives** in all significant results via `Benjamini-Hochberg` method
    * Formula
        > $m$ = total `GO` term count
        > $\alpha$ = significance threshold, like `0.05`
        * Sort all P-values

            $$
            p_{1} \le p_{2} \le ... \le p_{m}
            $$

        * Find $i_{max}$

            $$
            i_{max} \triangleq \max \{i \mid p_{i} \le \frac{i}{m} \times \alpha\}
            $$

        * Calculate FDR value

            $$
            q_{i} = p_{i} \times \frac{m}{i}, \forall i \le i_{max}
            $$

        * Monotonicity correction

            $$
            \text{modified FDR}_{i} = \min{(q_{i},q_{i+1})}
            $$
