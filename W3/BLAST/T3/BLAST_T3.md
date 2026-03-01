## `BLAST` Speed Optimization Methods
> Other than `dynamic programming` (`DP`), `BLAST` uses other speeding methods.

- **Indexing via `Seeding` (Word Lookup)**
  - Breaks query into short "words" (*e.g.*, `3 aa` for proteins, `11 nt` for DNA).
  - Builds a **lookup table** for "words" to identify database positions with high-scoring matches [1].
  - Transforms the search from a global DP calculation to a local lookup process.

- **Neighbor Words (`Substitution Matrices`)**
  - For proteins, the initial word list includes not just exact matches but high-scoring variants based on a substitution matrix (*e.g.*, `BLOSUM62`) [2].
  - Increases sensitivity without re-scanning the database, capturing `weak similarities` that exact matching would miss.

- **`Two-Hit Algorithm`**
  - Requires `2` non-overlapping word hits **on the same diagonal within a short distance** to trigger the extension step [2].
  - Filters out isolated random matches, **high sensitivity** [2].

- **Low-Complexity Region Filtering (`SEG`/`DUST`)**
  - Masks regions with **biased composition** (*e.g.*, coils, transmembrane regions) during the search [3].
  - Prevents `BLAST` from spending time on **statistically significant but biologically uninformative** matches (*false positives*), increasing overall search speed.

- **`Spaced Seeds` (Optimized for DNA)**
  - Uses **non-contiguous** patterns for initial word matching in nucleotide searches [4].
  - **Enhances search sensitivity** while maintaining the speed advantage of heuristic seeding.

- **`Query Chunking` & `Parallelization`**
  - Modern implementations (`BLAST+`) split long queries into **chunks** and distribute them across multiple CPU threads [5].
  - Reduces **wall-clock time** for **large searches** by efficiently utilizing modern hardware [5].

---

### References

[1] [Altschul SF, Gish W, Miller W, Myers EW, Lipman DJ. Basic local alignment search tool. *J Mol Biol*. 1990;**215**(3):403-410.](https://doi.org/10.1016/S0022-2836(05)80360-2)

[2] [Altschul SF, Madden TL, Schäffer AA, et al. Gapped BLAST and PSI-BLAST: a new generation of protein database search programs. *Nucleic Acids Res*. 1997;**25**(17):3389-3402.](https://doi.org/10.1093/nar/25.17.3389)

[3] [Wootton JC, Federhen S. Statistics of local complexity in amino acid sequences and sequence databases. *Comput Chem*. 1993;**17**(2):149-163.](https://doi.org/10.1016/0097-8485(93)85006-X)

[4] [Ma B, Tromp J, Li M. PatternHunter: faster and more sensitive homology search. *Bioinformatics*. 2002;**18**(3):440-445.](https://doi.org/10.1093/bioinformatics/18.3.440)

[5] [Camacho C, Coulouris G, Avagyan V, et al. BLAST+: architecture and applications. *BMC Bioinformatics*. 2009;10:421.](https://doi.org/10.1186/1471-2105-10-421)