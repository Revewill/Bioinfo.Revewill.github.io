# Explanation on `BLAST` (T2) results
> [Click here](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/BLAST/T2/BLAST_T2_Results.txt) for *final results*;
> [Click here](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/BLAST/T2/BLAST_T2_Script.sh) for *original script*;
> [Click here](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/BLAST/T2/BLAST_T2_Shuffled_Sequences.fasta) for *shuffled sequence data* in `FASTA` format.

## 1. Format for [final results](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/BLAST/T2/BLAST_T2_Results.txt)
* *Abbr.* meanings: (in `-outfmt 6` format)

| Col. | *Abbr.*         | Meanings           |
| :---: | :-----------: |:-------------:|
| **1** | **`qseqid`**    | **Query sequence ID** |
| **2** | **`sseqid`**     | **Subject sequence ID**      |
| **3** | **`pident`** | **Percentage of identical matches (*sequence identity*)**      |
| 4 | `length` | Length of the alignment (*number of amino acids*)      |
| 5 | `mismatch` | Number of mismatched amino acids      |
| 6 | `gapopen` | Number of gap openings      |
| 7 | `qstart` | **Start** of the alignment in the **query** sequence      |
| 8 | `qend` | **End** of the alignment in the **query** sequence      |
| 9 | `sstart` | **Start** of the alignment in the **subject** sequence      |
| 10 | `send` | **End** of the alignment in the **subject** sequence      |
| **11** | **`evalue`** | **Expectation value (`E-value`)**      |
| **12** | **`bitscore`** | **Bit score (*higher indicates a better match*)**      |

* The end of [final results](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/BLAST/T2/BLAST_T2_Results.txt) includes [the ten shuffled sequences in `FASTA` format](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/BLAST/T2/BLAST_T2_Shuffled_Sequences.fasta) for easy reference.

## 2. General Interpretation of [Result Data](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/BLAST/T2/BLAST_T2_Results.txt)
* **Alignment Coverage**
    * The lengths of alignments are **significantly shorter** than the full length of the sequences.
        > Average alignment length `12.02` *amino acids*;
        > Shuffled sequence length `70.00` *amino acids*.
    * Indicates that shuffled sequences share little homology (**demonstrates randomness**).
* **Identity**
    * Most alignments show identity between `40%` and `80%`.
        > Some reach `100%` identity (*e.g.*, a `4` *amino acids* segment between `shuffled_seq_1` and `shuffled_seq_10`)
    * Short alignment lengths indicates that high identity is likely just a **random coincidence**.

* **`E-value` Distribution**
    * Scattered distribution.
        > Some `E-values` are less than `0.05` (*e.g.*, `shuffled_seq_2` & `shuffled_seq_7` with `E=0.18`, `shuffled_seq_6` & `shuffled_seq_10` with `E=0.10`).

        > Most `E-values` fall between `1` and `100`, or are even larger (*e.g.*, `E=575`).

* **Symmetry**
    * The results are not symmetrical.
        > *e.g.*, alignment parameters of `shuffled_seq_1` & `shuffled_seq_7` **differ slightly** from `shuffled_seq_7` & `shuffled_seq_1`.
    * `BLAST` performs **local** alignments; aligning in one direction versus the reverse might identify **different optimal matching regions**.

## 3. Disscusion
* **False positives**
    * Short, Random Similarities
        * Two randomly shuffled sequences might **locally** contain an identical short segment by chance
            > *e.g.*, `4` *amino acids*
            
            * In this context, `BLAST` might assign a relatively significant `E-value`.
        * However, due to the extremely short **alignment length**, such a match has virtually **no biological meaning**.

* **Conclusion**
    * No true homologues relationships between shuffled sequences.
    * `BLAST`'s Performance on Random Data
        * This experiment demonstrates that `BLAST` will still produce significant alignments when searching against random sequences.
            > Specifically, with some `E-values` even below conventional significance thresholds
        * In real research, conclusions should never be based on `E-values` alone.
            > **Other information**, such as **alignment length**, **functional annotation**, and **species of origin**, must be considered as well.

### 4. Appendix
* **[Final results (BLAST_T2_Results.txt)](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/BLAST/T2/BLAST_T2_Results.txt)**

| **`qseqid`** | **`sseqid`** | **`pident`** | `length` | `mismatch` | `gapopen` | `qstart` | `qend` | `sstart` | `send` | **`evalue`** | **`bitscore`** |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **`shuffled_seq_1`** | **`shuffled_seq_7`** | **`61.538`** | 13 | 3 | 1 | 56 | 68 | 12 | 22 | **`1.2`** | **`14.2`** |
| **`shuffled_seq_1`** | **`shuffled_seq_2`** | **`87.500`** | 8 | 1 | 0 | 7 | 14 | 28 | 35 | **`2.2`** | **`13.5`** |
| **`shuffled_seq_1`** | **`shuffled_seq_6`** | **`57.143`** | 7 | 3 | 0 | 4 | 10 | 10 | 16 | **`3.4`** | **`13.1`** |
| **`shuffled_seq_1`** | **`shuffled_seq_9`** | **`47.619`** | 21 | 11 | 0 | 26 | 46 | 21 | 41 | **`3.5`** | **`13.1`** |
| **`shuffled_seq_1`** | **`shuffled_seq_5`** | **`71.429`** | 7 | 2 | 0 | 5 | 11 | 62 | 68 | **`6.5`** | **`12.3`** |
| **`shuffled_seq_1`** | **`shuffled_seq_8`** | **`71.429`** | 7 | 2 | 0 | 2 | 8 | 40 | 46 | **`7.5`** | **`12.3`** |
| **`shuffled_seq_1`** | **`shuffled_seq_3`** | **`60.000`** | 10 | 4 | 0 | 18 | 27 | 34 | 43 | **`8.1`** | **`11.9`** |
| **`shuffled_seq_1`** | **`shuffled_seq_10`** | **`100.000`** | 4 | 0 | 0 | 8 | 11 | 58 | 61 | **`11`** | **`11.5`** |
| **`shuffled_seq_1`** | **`shuffled_seq_4`** | **`44.444`** | 27 | 14 | 1 | 4 | 30 | 10 | 35 | **`70`** | **`9.6`** |

| **`qseqid`** | **`sseqid`** | **`pident`** | `length` | `mismatch` | `gapopen` | `qstart` | `qend` | `sstart` | `send` | **`evalue`** | **`bitscore`** |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **`shuffled_seq_2`** | **`shuffled_seq_7`** | **`64.286`** | 14 | 5 | 0 | 23 | 36 | 46 | 59 | **`0.18`** | **`16.5`** |
| **`shuffled_seq_2`** | **`shuffled_seq_10`** | **`40.000`** | 25 | 15 | 0 | 27 | 51 | 37 | 61 | **`0.25`** | **`16.2`** |
| **`shuffled_seq_2`** | **`shuffled_seq_8`** | **`77.778`** | 9 | 2 | 0 | 33 | 41 | 2 | 10 | **`0.85`** | **`14.6`** |
| **`shuffled_seq_2`** | **`shuffled_seq_4`** | **`50.000`** | 18 | 9 | 0 | 20 | 37 | 9 | 26 | **`1.5`** | **`14.2`** |
| **`shuffled_seq_2`** | **`shuffled_seq_1`** | **`53.333`** | 15 | 7 | 0 | 8 | 22 | 52 | 66 | **`4.1`** | **`12.7`** |
| **`shuffled_seq_2`** | **`shuffled_seq_5`** | **`75.000`** | 8 | 2 | 0 | 29 | 36 | 20 | 27 | **`4.8`** | **`12.7`** |
| **`shuffled_seq_2`** | **`shuffled_seq_3`** | **`37.143`** | 35 | 22 | 0 | 6 | 40 | 17 | 51 | **`6.3`** | **`12.3`** |
| **`shuffled_seq_2`** | **`shuffled_seq_6`** | **`66.667`** | 9 | 3 | 0 | 5 | 13 | 36 | 44 | **`9.3`** | **`11.9`** |
| **`shuffled_seq_2`** | **`shuffled_seq_9`** | **`100.000`** | 2 | 0 | 0 | 56 | 57 | 23 | 24 | **`278`** | **`7.7`** |

| **`qseqid`** | **`sseqid`** | **`pident`** | `length` | `mismatch` | `gapopen` | `qstart` | `qend` | `sstart` | `send` | **`evalue`** | **`bitscore`** |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **`shuffled_seq_3`** | **`shuffled_seq_6`** | **`36.842`** | 19 | 12 | 0 | 39 | 57 | 2 | 20 | **`3.1`** | **`13.1`** |
| **`shuffled_seq_3`** | **`shuffled_seq_4`** | **`71.429`** | 7 | 2 | 0 | 63 | 69 | 2 | 8 | **`5.4`** | **`12.7`** |
| **`shuffled_seq_3`** | **`shuffled_seq_5`** | **`45.833`** | 24 | 13 | 0 | 18 | 41 | 10 | 33 | **`6.9`** | **`12.3`** |
| **`shuffled_seq_3`** | **`shuffled_seq_2`** | **`83.333`** | 6 | 1 | 0 | 4 | 9 | 43 | 48 | **`8.1`** | **`11.9`** |
| **`shuffled_seq_3`** | **`shuffled_seq_8`** | **`54.545`** | 11 | 5 | 0 | 11 | 21 | 54 | 64 | **`28`** | **`10.8`** |
| **`shuffled_seq_3`** | **`shuffled_seq_10`** | **`66.667`** | 6 | 2 | 0 | 45 | 50 | 6 | 11 | **`32`** | **`10.4`** |
| **`shuffled_seq_3`** | **`shuffled_seq_9`** | **`38.889`** | 18 | 11 | 0 | 4 | 21 | 10 | 27 | **`57`** | **`9.6`** |
| **`shuffled_seq_3`** | **`shuffled_seq_7`** | **`42.857`** | 21 | 7 | 1 | 49 | 64 | 45 | 65 | **`68`** | **`9.6`** |
| **`shuffled_seq_3`** | **`shuffled_seq_1`** | **`55.556`** | 9 | 4 | 0 | 13 | 21 | 27 | 35 | **`101`** | **`9.2`** |

| **`qseqid`** | **`sseqid`** | **`pident`** | `length` | `mismatch` | `gapopen` | `qstart` | `qend` | `sstart` | `send` | **`evalue`** | **`bitscore`** |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **`shuffled_seq_4`** | **`shuffled_seq_2`** | **`61.538`** | 13 | 5 | 0 | 51 | 63 | 32 | 44 | **`0.43`** | **`15.4`** |
| **`shuffled_seq_4`** | **`shuffled_seq_9`** | **`47.059`** | 17 | 9 | 0 | 15 | 31 | 17 | 33 | **`1.3`** | **`14.2`** |
| **`shuffled_seq_4`** | **`shuffled_seq_5`** | **`100.000`** | 5 | 0 | 0 | 4 | 8 | 18 | 22 | **`6.9`** | **`12.3`** |
| **`shuffled_seq_4`** | **`shuffled_seq_3`** | **`66.667`** | 6 | 2 | 0 | 42 | 47 | 31 | 36 | **`17`** | **`11.2`** |
| **`shuffled_seq_4`** | **`shuffled_seq_6`** | **`50.000`** | 24 | 11 | 1 | 44 | 66 | 21 | 44 | **`19`** | **`11.2`** |
| **`shuffled_seq_4`** | **`shuffled_seq_7`** | **`53.333`** | 15 | 7 | 0 | 9 | 23 | 43 | 57 | **`19`** | **`11.2`** |
| **`shuffled_seq_4`** | **`shuffled_seq_8`** | **`55.556`** | 9 | 4 | 0 | 4 | 12 | 62 | 70 | **`28`** | **`10.8`** |
| **`shuffled_seq_4`** | **`shuffled_seq_10`** | **`57.143`** | 7 | 3 | 0 | 27 | 33 | 8 | 14 | **`33`** | **`10.4`** |
| **`shuffled_seq_4`** | **`shuffled_seq_1`** | **`80.000`** | 5 | 1 | 0 | 1 | 5 | 57 | 61 | **`57`** | **`9.6`** |

| **`qseqid`** | **`sseqid`** | **`pident`** | `length` | `mismatch` | `gapopen` | `qstart` | `qend` | `sstart` | `send` | **`evalue`** | **`bitscore`** |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **`shuffled_seq_5`** | **`shuffled_seq_6`** | **`46.429`** | 28 | 13 | 1 | 30 | 57 | 15 | 40 | **`0.78`** | **`14.6`** |
| **`shuffled_seq_5`** | **`shuffled_seq_3`** | **`100.000`** | 5 | 0 | 0 | 51 | 55 | 47 | 51 | **`1.9`** | **`13.9`** |
| **`shuffled_seq_5`** | **`shuffled_seq_2`** | **`75.000`** | 8 | 2 | 0 | 20 | 27 | 29 | 36 | **`4.0`** | **`13.1`** |
| **`shuffled_seq_5`** | **`shuffled_seq_4`** | **`66.667`** | 9 | 3 | 0 | 35 | 43 | 43 | 51 | **`4.3`** | **`12.7`** |
| **`shuffled_seq_5`** | **`shuffled_seq_8`** | **`58.333`** | 12 | 5 | 0 | 29 | 40 | 37 | 48 | **`5.5`** | **`12.7`** |
| **`shuffled_seq_5`** | **`shuffled_seq_1`** | **`71.429`** | 7 | 2 | 0 | 62 | 68 | 5 | 11 | **`9.8`** | **`11.9`** |
| **`shuffled_seq_5`** | **`shuffled_seq_10`** | **`75.000`** | 4 | 1 | 0 | 28 | 31 | 57 | 60 | **`40`** | **`10.0`** |
| **`shuffled_seq_5`** | **`shuffled_seq_9`** | **`50.000`** | 12 | 6 | 0 | 57 | 68 | 14 | 25 | **`41`** | **`10.0`** |
| **`shuffled_seq_5`** | **`shuffled_seq_7`** | **`36.364`** | 11 | 7 | 0 | 32 | 42 | 58 | 68 | **`73`** | **`9.6`** |

| **`qseqid`** | **`sseqid`** | **`pident`** | `length` | `mismatch` | `gapopen` | `qstart` | `qend` | `sstart` | `send` | **`evalue`** | **`bitscore`** |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **`shuffled_seq_6`** | **`shuffled_seq_10`** | **`70.000`** | 10 | 3 | 0 | 57 | 66 | 38 | 47 | **`0.100`** | **`17.3`** |
| **`shuffled_seq_6`** | **`shuffled_seq_3`** | **`47.619`** | 21 | 11 | 0 | 23 | 43 | 1 | 21 | **`1.6`** | **`13.9`** |
| **`shuffled_seq_6`** | **`shuffled_seq_7`** | **`63.636`** | 11 | 4 | 0 | 45 | 55 | 48 | 58 | **`2.6`** | **`13.5`** |
| **`shuffled_seq_6`** | **`shuffled_seq_1`** | **`46.667`** | 15 | 8 | 0 | 30 | 44 | 43 | 57 | **`4.3`** | **`12.7`** |
| **`shuffled_seq_6`** | **`shuffled_seq_8`** | **`63.636`** | 11 | 4 | 0 | 15 | 25 | 38 | 48 | **`4.7`** | **`12.7`** |
| **`shuffled_seq_6`** | **`shuffled_seq_9`** | **`50.000`** | 8 | 4 | 0 | 54 | 61 | 18 | 25 | **`17`** | **`11.2`** |
| **`shuffled_seq_6`** | **`shuffled_seq_5`** | **`66.667`** | 6 | 2 | 0 | 8 | 13 | 59 | 64 | **`18`** | **`11.2`** |
| **`shuffled_seq_6`** | **`shuffled_seq_4`** | **`53.846`** | 13 | 6 | 0 | 50 | 62 | 9 | 21 | **`23`** | **`10.8`** |
| **`shuffled_seq_6`** | **`shuffled_seq_2`** | **`60.000`** | 5 | 2 | 0 | 62 | 66 | 50 | 54 | **`53`** | **`10.0`** |

| **`qseqid`** | **`sseqid`** | **`pident`** | `length` | `mismatch` | `gapopen` | `qstart` | `qend` | `sstart` | `send` | **`evalue`** | **`bitscore`** |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **`shuffled_seq_7`** | **`shuffled_seq_2`** | **`64.286`** | 14 | 5 | 0 | 46 | 59 | 23 | 36 | **`0.20`** | **`16.5`** |
| **`shuffled_seq_7`** | **`shuffled_seq_1`** | **`64.286`** | 14 | 3 | 1 | 11 | 22 | 55 | 68 | **`0.58`** | **`15.0`** |
| **`shuffled_seq_7`** | **`shuffled_seq_6`** | **`100.000`** | 6 | 0 | 0 | 8 | 13 | 39 | 44 | **`3.4`** | **`13.1`** |
| **`shuffled_seq_7`** | **`shuffled_seq_10`** | **`50.000`** | 12 | 6 | 0 | 45 | 56 | 5 | 16 | **`3.5`** | **`13.1`** |
| **`shuffled_seq_7`** | **`shuffled_seq_9`** | **`42.105`** | 19 | 11 | 0 | 2 | 20 | 26 | 44 | **`10`** | **`11.9`** |
| **`shuffled_seq_7`** | **`shuffled_seq_4`** | **`80.000`** | 5 | 1 | 0 | 37 | 41 | 21 | 25 | **`18`** | **`11.2`** |
| **`shuffled_seq_7`** | **`shuffled_seq_3`** | **`62.500`** | 8 | 3 | 0 | 34 | 41 | 1 | 8 | **`27`** | **`10.8`** |
| **`shuffled_seq_7`** | **`shuffled_seq_5`** | **`57.143`** | 7 | 3 | 0 | 24 | 30 | 27 | 33 | **`42`** | **`10.0`** |
| **`shuffled_seq_7`** | **`shuffled_seq_8`** | **`50.000`** | 6 | 3 | 0 | 46 | 51 | 12 | 17 | **`63`** | **`9.6`** |

| **`qseqid`** | **`sseqid`** | **`pident`** | `length` | `mismatch` | `gapopen` | `qstart` | `qend` | `sstart` | `send` | **`evalue`** | **`bitscore`** |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **`shuffled_seq_8`** | **`shuffled_seq_6`** | **`45.833`** | 24 | 13 | 0 | 25 | 48 | 2 | 25 | **`0.19`** | **`16.5`** |
| **`shuffled_seq_8`** | **`shuffled_seq_2`** | **`77.778`** | 9 | 2 | 0 | 2 | 10 | 33 | 41 | **`0.57`** | **`15.0`** |
| **`shuffled_seq_8`** | **`shuffled_seq_4`** | **`43.750`** | 32 | 16 | 1 | 10 | 39 | 5 | 36 | **`3.1`** | **`13.1`** |
| **`shuffled_seq_8`** | **`shuffled_seq_10`** | **`71.429`** | 7 | 2 | 0 | 45 | 51 | 4 | 10 | **`4.7`** | **`12.7`** |
| **`shuffled_seq_8`** | **`shuffled_seq_7`** | **`42.857`** | 14 | 8 | 0 | 11 | 24 | 45 | 58 | **`8.6`** | **`11.9`** |
| **`shuffled_seq_8`** | **`shuffled_seq_1`** | **`62.500`** | 8 | 3 | 0 | 40 | 47 | 2 | 9 | **`8.7`** | **`11.9`** |
| **`shuffled_seq_8`** | **`shuffled_seq_9`** | **`80.000`** | 5 | 1 | 0 | 66 | 70 | 35 | 39 | **`10`** | **`11.9`** |
| **`shuffled_seq_8`** | **`shuffled_seq_3`** | **`100.000`** | 4 | 0 | 0 | 66 | 69 | 7 | 10 | **`34`** | **`10.4`** |
| **`shuffled_seq_8`** | **`shuffled_seq_5`** | **`50.000`** | 6 | 3 | 0 | 10 | 15 | 31 | 36 | **`218`** | **`8.1`** |

| **`qseqid`** | **`sseqid`** | **`pident`** | `length` | `mismatch` | `gapopen` | `qstart` | `qend` | `sstart` | `send` | **`evalue`** | **`bitscore`** |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **`shuffled_seq_9`** | **`shuffled_seq_4`** | **`47.059`** | 17 | 9 | 0 | 17 | 33 | 15 | 31 | **`1.0`** | **`14.6`** |
| **`shuffled_seq_9`** | **`shuffled_seq_1`** | **`47.619`** | 21 | 11 | 0 | 22 | 42 | 27 | 47 | **`3.6`** | **`13.1`** |
| **`shuffled_seq_9`** | **`shuffled_seq_5`** | **`62.500`** | 8 | 3 | 0 | 54 | 61 | 59 | 66 | **`8.5`** | **`11.9`** |
| **`shuffled_seq_9`** | **`shuffled_seq_8`** | **`80.000`** | 5 | 1 | 0 | 35 | 39 | 66 | 70 | **`12`** | **`11.5`** |
| **`shuffled_seq_9`** | **`shuffled_seq_7`** | **`100.000`** | 4 | 0 | 0 | 9 | 12 | 64 | 67 | **`15`** | **`11.5`** |
| **`shuffled_seq_9`** | **`shuffled_seq_6`** | **`42.857`** | 14 | 8 | 0 | 39 | 52 | 30 | 43 | **`51`** | **`10.0`** |
| **`shuffled_seq_9`** | **`shuffled_seq_10`** | **`66.667`** | 6 | 2 | 0 | 1 | 6 | 62 | 67 | **`58`** | **`9.6`** |
| **`shuffled_seq_9`** | **`shuffled_seq_3`** | **`36.842`** | 19 | 12 | 0 | 10 | 28 | 4 | 22 | **`59`** | **`9.6`** |
| **`shuffled_seq_9`** | **`shuffled_seq_2`** | **`33.333`** | 9 | 6 | 0 | 41 | 49 | 48 | 56 | **`575`** | **`6.9`** |

| **`qseqid`** | **`sseqid`** | **`pident`** | `length` | `mismatch` | `gapopen` | `qstart` | `qend` | `sstart` | `send` | **`evalue`** | **`bitscore`** |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **`shuffled_seq_10`** | **`shuffled_seq_2`** | **`42.857`** | 35 | 19 | 1 | 27 | 61 | 18 | 51 | **`0.14`** | **`16.9`** |
| **`shuffled_seq_10`** | **`shuffled_seq_7`** | **`53.846`** | 13 | 6 | 0 | 5 | 17 | 45 | 57 | **`1.5`** | **`14.2`** |
| **`shuffled_seq_10`** | **`shuffled_seq_8`** | **`71.429`** | 7 | 2 | 0 | 4 | 10 | 45 | 51 | **`4.4`** | **`12.7`** |
| **`shuffled_seq_10`** | **`shuffled_seq_1`** | **`71.429`** | 7 | 2 | 0 | 2 | 8 | 62 | 68 | **`7.8`** | **`12.3`** |
| **`shuffled_seq_10`** | **`shuffled_seq_6`** | **`66.667`** | 6 | 2 | 0 | 42 | 47 | 61 | 66 | **`11`** | **`11.5`** |
| **`shuffled_seq_10`** | **`shuffled_seq_3`** | **`43.478`** | 23 | 12 | 1 | 23 | 44 | 6 | 28 | **`25`** | **`10.8`** |
| **`shuffled_seq_10`** | **`shuffled_seq_5`** | **`71.429`** | 7 | 2 | 0 | 34 | 40 | 18 | 24 | **`37`** | **`10.4`** |
| **`shuffled_seq_10`** | **`shuffled_seq_4`** | **`57.143`** | 7 | 3 | 0 | 8 | 14 | 27 | 33 | **`42`** | **`10.0`** |
| **`shuffled_seq_10`** | **`shuffled_seq_9`** | **`52.941`** | 17 | 6 | 1 | 18 | 34 | 9 | 23 | **`49`** | **`10.0`** |

* **[Original Script (BLAST_T2_Script.sh)](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/BLAST/T2/BLAST_T2_Script.sh)**

```bash
#!/bin/bash

# State script function
echo "This is a bash script that generates randomly shuffled sequences and align them based on BLAST algorithm."

# Locate directory
while true; do
    read -t 60 -p "Type your file's directory here: ~/blast/" dirpath

    if [[ -d "/home/test/blast/${dirpath}" ]]; then
        fulldirpath="/home/test/blast/${dirpath}"

        echo "This is all files/directories under your path."
        ls "${fulldirpath}" | cat -n

        # Locate file
        while true; do
            read -t 60 -p "Type the number before a file to select: " num
            ls "${fulldirpath}" | cat -n > "${fulldirpath}"/.tempdirpath.txt

            tempfile="${fulldirpath}/.tempdirpath.txt"
            totalnum=$(wc -l "${tempfile}" | awk '{print $1}')

            if (( ${num} <= ${totalnum} && ${num} >= 1 )); then
                numline=$(sed -n "${num}p" "${tempfile}")

                # Acquire permission
				while true; do
                	echo -e "Is this your file?\n${numline}"
                	read -t 60 -p "(y/n): " answeryn

                	if [[ ${answeryn,,} == "y" ]]; then
                   		echo "Beginning analysis now."
                    		filename=$(echo "${numline}" | awk '{$1=""; print substr($0,2)}')
                    		filepath="${fulldirpath}/${filename}"
                    
                    		# Randomly shuffle sequence
                    		echo "Beginning shuffling now."
                    		originalseq=$(cat "${filepath}")
		    				>"${fulldirpath}"/shufseq.fa

                    		for i in {1..10}; do
                        		shufseq=$(echo ${originalseq} | fold -w1 | shuf | tr -d '\n')

                        		echo ">shuffled_seq_$i" >> "${fulldirpath}"/shufseq.fa
                        		echo "${shufseq}" >> "${fulldirpath}"/shufseq.fa

                    		done

                    		shufseqfile="${fulldirpath}/shufseq.fa"
                    
                    		# Cat shufseq.fa
                    		echo -e "These are shuffled sequences in fa format (stored as ${shufseqfile})."
                    		cat "${shufseqfile}"

                    		cp "${shufseqfile}" "${fulldirpath}"/nonquery_shufseq.fa
                    		nonquery_shufseqfile="${fulldirpath}/nonquery_shufseq.fa"

                    		# Start BLAST
                    		echo "Beginning BLAST now."
                    		> "${fulldirpath}"/BLAST_results

                    		for i in {1..10}; do
                        
                        		# Extract and save query sequence
                        		grep -A1 "^>shuffled_seq_$i$" "${shufseqfile}" > "${fulldirpath}"/queryseq.fasta

                        		# Exclude query sequence from shufseq.fa
                        		sed "/^>shuffled_seq_$i$/,+1d" "${shufseqfile}" > "${nonquery_shufseqfile}"

                        		# Make BLAST database
                        		makeblastdb -dbtype prot -in "${nonquery_shufseqfile}" -out "${fulldirpath}"/database_blast

                        		# Start anlignment
                        		blastp -query "${fulldirpath}"/queryseq.fasta -db "${fulldirpath}"/database_blast -outfmt 6 -evalue 10000000 -num_threads 2 -max_hsps 1 -threshold 100 -word_size 2 >> "${fulldirpath}"/BLAST_results
                        		echo "" >> "${fulldirpath}"/BLAST_results

								# Remove database
								rm "${fulldirpath}"/database_blast.*

                    		done

                    		# End BLAST
                    		echo -e "BLAST ends now. The results for BLAST is stored in ${fulldirpath}/BLAST_results.txt."

                    		# Acquire permission to cat results
                    		while true; do
                        		read -t 60 -p "Do you want to read the results now? (y/n): " answeryn_two

                        		if [[ ${answeryn_two,,} == "y" ]]; then
                            			echo -e "qseqid\tsseqid\tpident\tlength\tmismatch\tgapopen\tqstart\tqend\tsstart\tsend\tevalue\tbitscore\n" > "${tempfile}"
                            			cat "${fulldirpath}"/BLAST_results >> "${tempfile}"
                            			cat "${tempfile}" | column -t

                            			break

                        		elif [[ ${answeryn_two,,} == "n" ]]; then
                            			break
                        
                        		else
                            			echo "Invalid answer. Type again please."
                            			continue
                        
                        		fi

                    		done

                    		# Integrate information into one file
							cp "${fulldirpath}"/BLAST_results "${fulldirpath}"/BLAST_results_old
                            echo -e "qseqid\tsseqid\tpident\tlength\tmismatch\tgapopen\tqstart\tqend\tsstart\tsend\tevalue\tbitscore\n" > "${fulldirpath}"/BLAST_results_old
							echo "" >> "${fulldirpath}"/BLAST_results_old

							cat "${fulldirpath}"/BLAST_results >> "${fulldirpath}"/BLAST_results_old
							column -t "${fulldirpath}"/BLAST_results_old > "${fulldirpath}"/BLAST_results
				
							prev=""
							while read line; do
								curr=$(echo "$line" | awk '{print $1}')

								if [[ -n "preve" && "${curr}" != "${prev}" ]]; then
									echo ""
								fi

								echo "$line"
								prev="${curr}"

							done < "${fulldirpath}"/BLAST_results > "${fulldirpath}"/BLAST_results.txt
				
							echo -e "\nShuffled sequences are shown below:\n" >> "${fulldirpath}"/BLAST_results.txt
                    		cat "${shufseqfile}" >> "${fulldirpath}"/BLAST_results.txt

                    		# Acquire permission to remove shufseqfile
                    		while true; do
                        		read -t 60 -p "Do you want to remove the file ${shufseqfile} now? (y/n): " answeryn_three

                        		if [[ ${answeryn_three,,} == "y" ]]; then
                            			echo "Removing file now."
                            			rm "${shufseqfile}"

                            			break

                        		elif [[ ${answeryn_three,,} == "n" ]]; then
                            			echo "File not removed."
                            			break
                        
                        		else
                            			echo "Invalid answer. Type again please."
                            			continue
                        
                        		fi

                    		done

                    		# Remove useless temporary files/directories
                    		echo "Removing useless tempfiles now."
                    		rm -f "${fulldirpath}"/BLAST_results "${fulldirpath}"/queryseq.fasta "${fulldirpath}"/database_blast.* "${nonquery_shufseqfile}" "${fulldirpath}"/BLAST_results_old

                    		# Exit program
                    		echo "Existing Program now."

                    		break
            
                	elif [[ ${answeryn,,} == "n" ]]; then
                    		echo "Select again please."
                    		continue 2
            
                	else
                    		echo "Invalid answer. Type again please."
                    		continue
            
                	fi

				done

                break

            else
                echo "Invalid number. Type again please."
                continue
				
            fi

            rm "${tempfile}"
        
        done

        break    

    else
        echo "Invalid path. Type again please."
        continue
    
    fi

done

exit
```

* **[Shuffled Sequences (BLAST_T2_Shuffled_Sequences.fasta)](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/BLAST/T2/BLAST_T2_Shuffled_Sequences.fasta)**

\>shuffled_seq_1

`VGYPTYSSVRYGSSSTGSSTSMMSGSPSTLLSSRATPSGSRAGSVSTYATLSRRRARTFSRLPASYSRVR`

\>shuffled_seq_2

`RRSRLSTSRSRARSPMVSPLSYGPAVTSSGRYGSSGYSSPRYSLTRTSVTFLMRASGGSTSSAASYTTVS`

\>shuffled_seq_3

`SVVSVTRTSTASPYTPSSSRSAVRGAGFTRLGYSSLYLRSGSPRGSTYTSPMMTSSLSARYSSSSRAGRR`

\>shuffled_seq_4

`RTSSRSGRLPTGSPVSSLGRTGSRTYRYMSSPSTVRRTMGALSYSSFVSTYGSSAASSPASALRVRSYST`

\>shuffled_seq_5

`SLRTSPVGVSPRSAVMLSRSGRSGLSGRTVRSGSSYSSATSSYTARGFSLTYTSPATASMSTYSRSRYPR`

\>shuffled_seq_6

`RRYSAPRSMPTYTPLRTSSVYSSMTSVTRGSSPSYVSASTSRARRVTLSLSGGSSLSSGGYTFSARGRSA`

\>shuffled_seq_7

`SRTSSYRSTSRARTYLPRSYVRPGRYTSSGSSFSAVSGSRTMLLTGPRVTSSVSTGSAGPLYSRSMASSA`

\>shuffled_seq_8

`TGSSGTSRPRSGPAVPRSPSSGASRSSSRRSLSAFSTLRGYYVYSSATRYVMASSVYTLSLTRSMRTSTG`

\>shuffled_seq_9

`SARRLYPYRSMATTPSVSTLAPSGYRSSSYMPSGRTATGVSSSYRTRSSGRSLSLSTFRRSSAVGSGVST`

\>shuffled_seq_10

`SLPSSGSRYVSTVSMGSRSSTSTRSSSTASLGPSRSSTSGGYGFRARPYPRVAATRRSVRYSATLLYSTM`
