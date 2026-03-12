# Secondary alignment
> An answer `md` file for Bioinformatics_Homework_Mapping_bedtools_and_samtools_T1
---
> Go to [Concept of Secondary Alignment](#1-concept-of-secondary-alignment) or [Analysis on Provided `bam` File](#2-analysis-on-provided-bam-file)
### 1. Concept of **Secondary Alignment**
#### 1.1 Definition
* **Additional** mapping locations of a *read*
  * Sometimes a *read* can align to **multiple** locations (primarily due to repetitive regions or homology)
  * **Secondary Alignment** reports those additional locations except the *primary one* reported by **Primary Alignment**
* Comparison with **Primary Alignment**

  | Primary Alignment | Secondary Alignment |
  | :---: | :---: |
  | Primary alignment location | Additional alignment locations |
* Identified by `FLAG` in `bam` files
  * `FLAG`: a binary string `0x100`
#### 1.2 Differences between **Secondary** and **Supplementary** alignment

| Type | `FLAG` | Type | Meaning |
| :---: | :---: | :---: | :--- |
| **Secondary** alignment | `0x100` (dec.`256`) | **Multi**-mapping | A **whole** read mapped to different locations in refrence |
 **Supplementary** alignment | `0x800` (dec.`2048`) | **Chimeric** alignment | **Different parts** of a read mapped to different locations in reference |
#### 1.3 Practical Applications
* Reflects genuine biological features such as genomic repeats, paralogous regions, and gene families
#### 1.4 References
1. [Li, H., et al. (2009). The Sequence Alignment/Map format and SAMtools. *Bioinformatics*, **25**(16), 2078-2079.](https://doi.org/10.1093/bioinformatics/btp352)
2. [Li, H. (2013). Aligning sequence reads, clone sequences and assembly contigs with BWA-MEM. *arXiv preprint* arXiv:1303.3997.](https://arxiv.org/abs/1303.3997)
3. [Official SAM Specification.](https://samtools.github.io/hts-specs/SAMv1.pdf)
---
### 2. Analysis on Provided `bam` File
#### 2.1 Created a `bash` script
> Click to [download](https://revewill.github.io/Bioinfo.Revewill.github.io/W6/bedtools%20%and%20%samtools/T2/sec_align_bam.sh) `sec_align_bam.sh`.

```bash
#!/bin/bash
echo -e 'This script greps all secondary alignment records in COAD.ACTB.bam\nAnalyze now ...'
total=$(samtools view /home/test/mapping/bedtools_samtools/homework/COAD.ACTB.bam | wc -l)
sec=$(samtools view -f 256 /home/test/mapping/bedtools_samtools/homework/COAD.ACTB.bam | wc -l)
prop=$((100 * $sec / $total)).$(( (10000 * $sec / $total) % 100 ))
echo -e "The total record count is $total.\nThere are $sec secondary alignment records in the file, taking $prop% in all records.\nTask done."
```

#### 2.2 Run script

```
$ bash sec_align_bam.sh
This script greps all secondary alignment records in COAD.ACTB.bam
Analyze now ...
The total record count is 185650.
There are 4923 secondary alignment records in the file, taking 2.65% in all records.
Task done.
```

#### 2.3 Results
* File contains **`4923`** secondary alignment records
* Proportion to total read count is **`2.65%`**
---