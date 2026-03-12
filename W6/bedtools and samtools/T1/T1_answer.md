# Dstinguishing between single- and paired-end sequencing
> An answer `md` file for Bioinformatics_Homework_Mapping_bedtools_and_samtools_T1
---
* `samtools flagstat` reads and demonstrates `FLAG` data in `bam` files
  * `paired in sequencing`, `read1`, `read2`, etc. are all relevant with paired-end sequencing
* File `COAD.ACTB.bam` is a single-end sequencing file

    ```
    $ samtools flagstat COAD.ACTB.bam
    185650 + 0 in total (QC-passed reads + QC-failed reads)
    4923 + 0 secondary
    0 + 0 supplementary
    0 + 0 duplicates
    185650 + 0 mapped (100.00% : N/A)
    0 + 0 paired in sequencing
    0 + 0 read1
    0 + 0 read2
    0 + 0 properly paired (N/A : N/A)
    0 + 0 with itself and mate mapped
    0 + 0 singletons (N/A : N/A)
    0 + 0 with mate mapped to a different chr
    0 + 0 with mate mapped to a different chr (mapQ>=5)
    ```
  * Contains no paired-sequencing reads
  * Suggests it's single-ended
---