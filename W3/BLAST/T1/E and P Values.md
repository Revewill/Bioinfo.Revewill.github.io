# I. Practical Meaning of `E-Value`
> `E-value` represents the **number of matches** you would expect to see **by chance** that have a score equal to or better than the current match. It is calculated by combining the *alignment score* with *the size of the database*.

### 1. What the `E-Value` Number Means
* **Smaller `E-value`**
    > Closer to `0`.
    * This means it's highly **unlikely** that the match occurred by **random** chance. 
        * In practice, this indicates a very **high probability of a _true homologous relationship_** between the query and target sequence.
        > *e.g.*, an `E-value` less than `1×10⁻⁵` is considered **reliable evidence of _homology_**.
* **Larger `E-value`** 
    > *e.g.*, greater than `0.01` or `0.1` 
    * This suggests the match could easily be due to **random similarity**, especially with *short* sequences or *low-complexity* regions.
        * In practice, such matches often need **further verification**.

### 2. How `E-Value` Affects Results
> Control the number and reliability of your results by adjusting the `E-value` in the `BLAST` parameters.
* **Setting a low `E-value` threshold**
    >*e.g.*, `0.001`
    * This will **reduce the number of matches** in your output, but the remaining sequences will be **highly reliable**.
      > Suitable for finding *orthologs* or highly *conserved* sequences.
* **Setting a high `E-value` threshold**
    > *e.g.*, `10`
    * This will return **more matches**, yet with more **false positives**.
        > Useful for exploring *distant homology* or quickly *screening for __potential__ similarities*.

---

# II. Practical Meaning of `P-Value`
> `P-value` represents the **probability** that the observed match score could occur **by chance** under a **random model**. It describes the *statistical significance* of a *__single__ alignment*.

### 1. Relationship Between `P-Value` and `E-Value`
* **`P-value` considers only a _single_ alignment**
    * The probability of this **specific** match happening by chance.
* **`E-value` accounts for the overall size of the database**
    * Essentially, it's **`P-value`** multiplied by **database size** (or search space).

### 2. In Practical Context
> In actual `BLAST` output, one should primarily rely on `E-value`.

* A database search involves millions of comparisons. `P-value` alone without considering the **number of searches** could lead to **false positives**.
* `E-value` already includes a correction for multiple comparisons, making it a more **realistic measure of significance** in a database search context.