# Genome Annotation
> An answer `md` file for Bioinformatics_Homework_Genome_Annotation

> Direct to [T1](#t1) or [T2](#t2) quickly here.
---
### T1
> The size and composition of human genome

#### 1. The size of human genome
##### 1.1 Overall size
* `3,099,734,149` bp, or roughly `3.1` Gb
  * Last updated on **2025.09**
  * According to genome assembly [**`GRCh38.p14`** on NCBI](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.40/)
##### 1.2 Other statistics
* Assembly unit lengths

    | Assembly type | Length | Demonstration |
    | :---: | :---: | :--- |
    | **Chromosomes** | **`3,088,269,830` bp, `3.09` Gb** | **All chromosomes** |
    | — Autosomes | `2,875,001,520` bp, `2.88` Gb | `22` autosomes |
    | — X chromosome | `156,040,895` bp, `156.04` Mb | - |
    | — Y chromosome | `57,227,415` bp, `57.23` Mb | - |
    | **Mitochondria** | **`16,569` bp, `16.57` kb** | **Mitochondrial genome** |
    | **Other** | **`177,115,660` bp, `177.12` Mb** | Including **unlocalized scaffold**, **unplaced scaffold**, **fix patch**, **novel patch**, **alt scaffold** |
    * Last updated on **2025.09**
    * According to **[assembly report](https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_assembly_report.txt)** of genome assembly [**`GRCh38.p14`**](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.40/)
* Data visualized via `R`
![visualized](./Appendix/size/human_genome_plot.png)
    * View [script](./Appendix/size/human_genome_plot.R) or [`png` file](./Appendix/size/human_genome_plot.png)

#### 2. The basic composition of human genome
* For comprehensive classification, please direct to [1.2](#12-other-statistics)
* Within chromosomal sequences, here is the basic composition
  > Data collected via `bash` script.
  > View [`bash` script](./Appendix/size/annotation.sh) or [output `csv` file](./Appendix/size/annotation.csv).
  * Genes

    | Gene type | Count | Length in bp |
    | :---: | :---: | :---: |
    Protein-coding genes | 19890 | 844688520
    Non-coding RNA genes | 21872 | 928860096
    Pseudogenes | 16950 | 719832600

    * **Protein-coding genes** encode mRNAs that translate into proteins
    * **Non-coding RNA genes** encode ncRNAs that carry a variety of functions
    * **Pseudogenes** are duplicates of protein-coding genes that are no longer effective

  * RNA transcripts
  
    | Transcript type | Count | Total length in bp |
    | :---: | :---: | :---: |
    | lncRNA transcripts | 30320 | 68737562 |
    miRNA transcripts | 2875 | 62187
    misc_RNA transcripts | 11863 | 42289816
    rRNA transcripts | 37 | 104213
    snRNA transcripts | 154 | 19413
    snoRNA transcripts | 1194 | 132662
    tRNA transcripts | 431 | 31882
    mRNA transcripts | 131239 | 577731139

  * Data visualized via `R`
![visualized](./Appendix/size/genome_annotation_stacked.png)
    * View [**script**]() or [**`png` file**](./Appendix/size/genome_annotation_stacked.png)


* Last updated on **2025.09**
* According to **[annotation report](https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40-RS_2025_08_annotation_report.xml)** of genome assembly [**`GRCh38.p14`**](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.40/)
---
### T2
#### 1. Lastest classification of ncRNAs
* Latest annotation on ncRNA genes
  * Count: `21872`; Length: `928860096` bp, or roughly `0.93` Gb
* Classification system
  ```mermaid
  mindmap
    root((ncRNA))
      ((lncRNA
      > 200 nt))
        (lincRNA
        intergenic)
          Intergenic regions between protein-coding genes
        (Antisense lncRNA)
          Overlaps a protein-coding gene on the antisense strand
        (Intronic lncRNA)
          Derived from introns
        (Bidirectional lncRNA)
          Shares promoter with adjacent protein-coding gene but transcribed oppositely
        (eRNA
        enhanced)
          Transcribed from enhancers
      ((Small ncRNA
      < 200 nt))
        (miRNA
        micro, ~ 22 nt)
          Regulates gene expression
        (siRNA
        interfering, ~ 21 nt)
          Mediates RNA interference
        (piRNA
        piwi-interacting, ~ 30 nt)
          Silences transposons in germline cells
        (snRNA
        nuclear, 100 ~ 300 nt)
          Spliceosome
        (snoRNA
        nucleolar, 60 ~ 300 nt)
          rRNA chemical modifications
        (tRNA
        transfer, 70 ~ 90 nt)
          Protein synthesis
        
        
      3
        3.1
        3.2
          3.2.1
  ```
  * Last updated on **2025.09**
  * According to **[basic annotation report](https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_49/gencode.v49.basic.annotation.gtf.gz)** of genome assembly [**`GRCh38.p14`**](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.40/)

#### 2. Annotation on main ncRNAs

---

