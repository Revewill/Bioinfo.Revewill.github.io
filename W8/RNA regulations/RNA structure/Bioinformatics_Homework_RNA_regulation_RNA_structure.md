# RNA Structure
> An answer `md` file for Bioinformatics_Homework_RNA_regulation_RNA_structure

> Direct to [T1](#t1), [T2](#t2) quickly here.
---
### T1
> Structure-seq principles explained
* **Structure-seq** is a high-throughput technology that decrypts RNA secondary structures in genome-wide scale[^1]
* Structure-seq steps
  * 1. Chemical modification on RNAs
    * Use reagents to process RNA that distinguishes between flexible/rigid regions
    * *e.g.*, DMS can selectively methylate unpaired A and C (in single chain regions) with paired bases protected from modification
  * 2. Reverse transcription
    * Apply reverse transcription to modified RNAs
    * When the reverse transcriptase hit DMS-modified site, it will stop the transcription process
    * This leaves a bunch of cDNAs of different lengths
  * 3. High-throughput sequencing
    * Sequence these cDNA libraries and acquire read information
  * 4. Structure reconstruction
    * The sequenced reads are mapped onto reference sequence
    * Calculate how many reads are terminated at a specific site
    * If this signal is strong, it indicates that this site is in flexible regions in RNA secondary structure, and *vice versa*
[^1]: [Ding Y, Kwok CK, Tang Y, Bevilacqua PC, Assmann SM. Genome-wide profiling of in vivo RNA structure at single-nucleotide resolution using structure-seq. *Nat Protoc*. 2015;10(7):1050-1066.](https://doi.org/10.1038/nprot.2015.064)
---
### T2
> Reactivity explained[^2]
* **Reactivity** is a core quatifiable index in **SHAPE**-like techniques, estimating the intensity of each nucleotide reacting with a chemical probe
  * **SHAPE**, selective 2'-hydroxyl acylation and primer extension, is a technique that probes `2'-OH` in RNA main chains using acylation via SHAPE reagent, thereby identifying how "mobile" or "flexible" a nucleotide is as the reactivity of its `2'-OH` reflects its exposure
* Lower reactivity (0 ~ 0.2) supports paired regions like stem regions, while higher reactivity (0.9 ~ 2.0) supports unpaired or flexible regions like hairpin loops; intermediate levels (0.3 ~ 0.8) might support loops or bulges
* Formula in general
  > $\text{Background}_{i}$: backgroud signal measured by setting control group without probes;
  > $\text{Normalization factor}$: aims to normalize all $\text{Reactivity}$ to the range of 0 ~ 2.

    $$
    \text{Reactivity}_{i} = \frac{\text{Signal}_{i} - \text{Background}_{i}}{\text{Normalization factor}}
    $$
* Afterwards, reactivity values can be used to predict or reconstruct the RNA's secondary structure

[^2]: [Merino EJ, Wilkinson KA, Coughlan JL, Weeks KM. RNA structure analysis at single nucleotide resolution by selective 2'-hydroxyl acylation and primer extension (SHAPE). *J Am Chem Soc*. 2005;127(12):4223-4231.](https://doi.org/10.1021/ja043822v)
