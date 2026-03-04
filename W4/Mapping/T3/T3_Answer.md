# `sam`/`bam` File format explained
### 3.1 `CIGAR` strings
> ‌Compact Idiosyncratic Gapped Alignment Report, `CIGAR`
* Located at the `6`<sup>th</sup> column in `sam`/`bam` files
* Records how a specific read maps to the reference genome via a **compact string** of characters
    > *e.g.*, how many **matches**, **indels**, etc.
* Form of `CIGAR` strings
    * Made up of **`<integer><op>` pairs**
        * **`<integer>`** specifies the *number* of consecutive operation
        * **`<op>`** (operation) describes the type of column in *alignment*
        > *e.g.*, `CIGAR` string `100M2I100M2D3M` represents:

        | `<integer><op>` pairs | Meaning | Explanation |
        | :---: | :---: | :--- |
        | `100M` | `100` bp of **Matches**/**Mismatches** | Consecutive matches/mismatches |
        | `2I` | `2` bp of **Insertion** | Consecutive gap in reference genome |
        | `100M` | `100` bp of **Matches**/**Mismatches** | Consecutive matches/mismatches |
        | `2D` | `2` bp of **Deletion** | Consecutive gap in read |
        | `3M` | `3` bp of **Matches**/**Mismatches** | Consecutive matches/mismatches |
    * **`<op>`** table

        | `<op>` | Meaning |
        | :---: | :--- |
        | `M` | **Match** or **mismatch** (originally `=` for match and `X` for mismatch) |
        | `D` | **Deletion** in read sequence |
        | `I` | **Insertion** in read sequence |
        | `N` | **Skipped region** in reference sequence, i.e., a long reference sequence skipped by reads, like **introns** |
        | `S` | **Soft clip** in read sequence, i.e., **start**/**end** segments that don't appear in alignment but are **given** in `sam`/`bam` files |
        | `H` | **Hard clip** in read sequence, i.e., **start**/**end** segments that don't appear in alignment and are **not given** in `sam`/`bam` files |

### 3.2 Soft clips
* Are **segments of read sequence** that don't appear in the alignment but *saved and given* in `sam`/`bam` files
* Usually due to
    * **Indels** in read sequences (especially at **start**/**end**)
    * **Sequencing** faults (*e.g.*, remaining primer)
    * Incomplete or ill-suited **Reference Genome**

### 3.3 Mapping quality
> Mapping Quality, `MAPQ`
* Located at the `5`<sup>th</sup> column in `sam`/`bam` files
* Is a **numeric score** that reflects the **quality** (credibility) of alignment results
    * Higher `MAPQ` value indicates **higher accuracy of mapping location** of the read
    * `MAPQ` = `255` represents **invalid** `MAPQ` value
        > *e.g.*, `Bowtie` doesn't calculate `MAPQ` values, so the corresponding column of each read is filled with `255`.
* Calculation formula
    * `MAPQ` = $-10 lg (P)$, where $P$ is the **probability** of mapping location being mistaken

### 3.4 Reconstruction of reference genome sequences
> Based only on `sam`/`bam` files, reference genome sequences can be reconstructed from `SEQ`, `CIGAR` and `MD` Tag data **given `N` is not present in `CIGAR` strings**.

> Otherwise, the skipped segments of reference genome **cannot be recovered**.
* `MD` Tags
    * A string of characters that describes the relative differences of **reference** sequence aligned to **read** sequence `SEQ`
    * Format

        | Item | Description | Meaning |
        | :---: | :---: | :--- |
        | `[0-9]*` | Integer | Represents number of consecutive matches of **reference** with `SEQ` |
        | `[A-Z]` | Base (`A`/`T`/`C`/`G`) | Marks the base in **reference** at a mismatch site |
        | `^[A-Z]` | Deleted base (`^A`/`^T`/`^C`/`^G`) | Marks the deleted base in **reference** during alignment |
        > *e.g.*, `MD` string `4A3^AC1`, `CIGAR` string `8M2D1I1M`, `SEQ` `TACGGATGTC`, then **reference** sequence would be `TACGAATGACC`
    * Allows **reconstruction** when combined with `CIGAR` and `SEQ`
* `N` in `CIGAR` strings
    * A skipped sequence in reference genome
        > *e.g.*, in `RNA-seq`, RNA splicing often results in the deletion of introns, making these corresponding regions **absent in read sequences**.
    * Without information on these skipped regions, those segments in the reference genome **cannot be reconstructed** from `MD`, `CIGAR` and `SEQ` combined.
    * In this scenario, relying solely on `sam`/`bam` files **isn't sufficient for reference reconstruction**.