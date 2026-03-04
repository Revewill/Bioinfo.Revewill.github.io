# `Bowtie`: Maximum speed and minimal memory usage
### 1. `BWT` property and alignment speed
> `Bowtie` utilizes the **LF Mapping (Last-First Mapping)** property of `BWT` to improve **alignment speed**
* Performs **backward search** from *the last character* of the read, quickly narrowing down the **matching range** in each iteration.
    * Search time proportional to read length
    * ~~Global scanning~~
### 2. Memory usage optimization
> `Bowtie`'s strategies to optimize **memory usage**
* 2.1. **Stores only `BWT` itself**
    * Instead of storing the complete suffix array, `Bowtie` only stores the `BWT` string (saves space)
* 2.2. **Milestone sampling**
    * Stores genome positions only **every `32` rows**
    * When needed, **"walk left"** from the nearest milestone to *calculate the exact position*, reducing memory
* 2.3. **Checkpoint precomputation**
    * **Pre-calculate** cumulative counts for each base every `448` rows
    * Regularly stores rank data for faster **queries**
        > Saves memory usage

> Total memory significantly less than traditional methods