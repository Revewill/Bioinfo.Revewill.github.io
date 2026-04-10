# Sequence Motif
> An answer `md` file for Bioinformatics_Homework_Motif_Sequence_Motif

> Direct to [T1](#t1), [T2](#t2), [T3](#t3), [T4](#t4) quickly here.
---
### T1
> Function `promoters` in package `GenomicFeatures` explained

> Reference: `GenomicFeatures` manual ([online](https://bioconductor.org/packages/release/bioc/manuals/GenomicFeatures/man/GenomicFeatures.pdf) and [local](./T1/GenomicFeatures.pdf))
* Basic Grammar of `promoters` function

    ```R
    promoters(txdb.object, upstream = <num>, downstream = <num>, use.names = TRUE, ...)
    ```
* How `promoters` define genomic regions corresponding to promoters by default
  * Find a Transcription Start Site (TSS) in `txdb`
    * The border of transcripts
  * Promoter genomic region is
    * For `+` strands, from `TSS - <upstream>` to `TSS + <downstream>`
    * For `-` strands, from `TSS - <downstream>` to `TSS - <upstream>`
  * Default arguments: `<upstream> = 2000 bp`, `<downstream> = 200 bp`
---
### T2
> Argument `-mod` in `meme` command

> Reference: [**Meme** webpage](https://meme-suite.org/meme/doc/meme.html)
* Argument `-mod`
  * Describes the distribution of motif sites per sequence
* Values `oops`, `zoops` and `anr` (default: `zoops`)
  * In short, if any sequence in the dataset contains $n$ motif sites, then
    * `-mod oops`: $n = 1$
    * `-mod zoops`: $n \in \{0,1\}$
    * `-mod anr`: $n \in \mathbb{N}$
  * Comparison
    > Sensitivity means sensitivity to weak motifs

    | Value | Name | Properties |
    | :--- | :--- |:--- |
    | `oops` | One Occurrence Per Sequence | Fastest, most sensitive, most inaccurate |
    | `zoops` | Zero or One Occurrence Per Sequence | Slower, less sensitive, more accurate |
    | `anr` | Any Number of Repetitions | Slowest, most insensitive, most accurate |
---
### T3
> 5'-UTRs motif discovery and motif enrichment analysis

> Note: Personally, I didn't use the prepared docker image and installed relevant softwares/packages myself
* Preparation
  * Install **Meme**

    ```bash
    # Make working dir
    $ mkdir ~/motif && cd ~/motif
    $ mkdir meme && cd meme

    # Get package
    $ wget https://meme-suite.org/meme/meme-software/5.5.9/meme-5.5.9.tar.gz
    $ tar -xzf meme-5.5.9.tar.gz && rm meme-5.5.9.tar.gz

    # Compile
    $ mamba install -c conda-forge c-compiler gcc
    $ ./configure --prefix=/root/motif/meme \
    > --enable-build-libxml2 \
    > --enable-build-libxslt \
    > --disable-mpi
    $ make -j$(nproc)
    $ make install

    # Write variable
    $ echo 'export PATH=$HOME/motif/meme/bin:$HOME/motif/meme/libexec/meme-5.5.9:$PATH' >> ~/.zshrc
    # Or ~/.bashrc
    $ source ~/.zshrc

    # Check if successful
    $ which meme && which ame
    ```
  * Install required `R` packages

    ```bash
    # Install bioconductor packages
    $ mamba install -c conda-forge -c bioconda \
    > r-base \
    > r-rcurl \
    > bioconductor-rtracklayer \
    > bioconductor-genomicfeatures

    # Appoint dir for R
    $ cat >> ~/.zshrc << 'EOF'
    > alias r.conda='export PATH=/opt/micromamba/bin:$PATH && R'
    > EOF

    # Open an R terminal
    $ r.conda
    ```

    ```R
    # GenomicFeatures
    r$> library(GenomicFeature)

    # BiocManager
    r$> install.packages("BiocManager")

    # txdbmaker and Biostrings
    r$> BiocManager::install(c("txdbmaker", "Biostrings"))
    r$> library(c("txdbmaker", "Biostrings"))
    ```
  * Prepare working directory

    ```bash
    $ mkdir ~/motif/sequence-motif && cd ~/motif/sequence-motif
    $ mkdir scripts bed sequences known-motifs

    # Download relevant files
    # For genome
    $ ln -s ~/data/genome
    ```
  * Prepare files (downloaded from Tsinghua cloud)
    * Create `bed` files via [`R` script](./T3/Scripts/get.interest.regions.R)
  
        ```R
        #!/usr/bin/env Rscript

        message("Load required packages ...")
        suppressPackageStartupMessages(library("GenomicFeatures"))
        suppressPackageStartupMessages(library("txdbmaker"))

        message("Load trasncripts in gencode human genome annotation ...")

        # specify the location of your genome annotation in gtf format
        gtf.path <- "genome/gencode.v27.annotation.gtf"

        # GenomicFeatures package use "TxDb" to store annotation for each transcripts
        tx.db <- makeTxDbFromGFF(gtf.path, format="gtf")

        # Here we only consider longest trasncript of each gene to avoid over representation of genes with multiple isoform
        tx.lengths <- transcriptLengths(tx.db, with.cds_len=FALSE,with.utr5_len=FALSE, with.utr3_len=FALSE)
        # tx.lengths is a data.frame with 5 fields:
        # tx_id, tx_name, gene_id, nexon (numer of exons), tx_len
        gene.id.2.longest.tx.id <- lapply(split(tx.lengths,tx.lengths$gene_id),
                                        function(isoform.length.table){isoform.length.table$tx_name[which.max(isoform.length.table$tx_len)];})
        # get a look up table: gene id to longest transcript id  
        gene.id.2.longest.tx.id <- unlist(gene.id.2.longest.tx.id)


        message("Load gene ids of interest ...")
        gene.ids <- read.delim("gene.ensembl.ids.txt",sep="\n",stringsAsFactors = F,header = F)$V1
        message(length(gene.ids)," genes were loaded .")

        considered.tx.ids <- gene.id.2.longest.tx.id[gene.ids]


        # longest transcript id to gene id look up
        names(gene.ids) <- considered.tx.ids


        # fetch 5' UTR sequences 
        message("Fetch 5' UTR genomic intervals ...")
        five.prime.utrs = fiveUTRsByTranscript(tx.db, use.names=T)
        five.prime.utrs <- data.frame(five.prime.utrs)
        # five.prime.utrs is now a data.frame like this:
        #  group      group_name       seqnames  start    end     width strand exon_id     exon_name            exon_rank
        #1   1     ENST00000641515.1     chr1    65419    65433    15      +      21	   ENSE00003812156.1         1
        #2   1     ENST00000641515.1     chr1    65520    65573    54      +      22       ENSE00003813641.1         2
        #3   1     ENST00000641515.1     chr1    69037    69090    54      +      23       ENSE00003813949.1         3

        message("Saving 5' UTR genomic intervals in bed format ...")
        fields <- c("seqnames","start","end","group_name","exon_id","strand")
        five.prime.utrs <- five.prime.utrs[five.prime.utrs$group_name %in% considered.tx.ids,fields]
        five.prime.utrs$group_name <- paste0(gene.ids[five.prime.utrs$group_name],"-",five.prime.utrs$group_name)
        five.prime.utrs$start <- five.prime.utrs$start - 1
        write.table(five.prime.utrs,"five.prime.utrs.bed",quote=FALSE,sep="\t",col.names=FALSE,row.names=FALSE)

        # fetch 3' UTR sequences
        message("Fetch 3' UTR genomic intervals ...")
        three.prime.utrs = threeUTRsByTranscript(tx.db, use.names=T)
        three.prime.utrs <- data.frame(three.prime.utrs)
        message("Saving 3' UTR genomic intervals in bed format ...")
        three.prime.utrs <- three.prime.utrs[three.prime.utrs$group_name %in% considered.tx.ids,fields]
        three.prime.utrs$group_name <- paste0(gene.ids[three.prime.utrs$group_name],"-",three.prime.utrs$group_name)
        three.prime.utrs$start <- three.prime.utrs$start - 1
        write.table(three.prime.utrs , "three.prime.utrs.bed",quote=FALSE,sep="\t",col.names=FALSE,row.names=FALSE)


        # fetch promoter sequences 
        message("Fetch promoter genomic intervals ...")
        # how are so called "promoters" defined in GenomicFeatures package? please see its manual.
        promoters.ivs <- promoters(tx.db)
        promoters.ivs <- data.frame(promoters.ivs)
        message("Saving promoter genomic intervals ...")
        fields <- c("seqnames","start","end","tx_name","tx_id","strand")
        promoters.ivs <- promoters.ivs[promoters.ivs$tx_name %in% considered.tx.ids,fields]
        promoters.ivs$start <- promoters.ivs$start - 1
        write.table(promoters.ivs, "promoters.bed",quote=FALSE,sep="\t",col.names=FALSE,row.names=FALSE)

        message("All done .")
        ```

        ```bash
        $ mv *.bed bed
        ```
    * Acquire exon sequences

        ```bash
        $ bedtools getfasta -s -name+ -fi genome/GRCh38.p10.genome.fa -bed bed/promoters.bed -fo sequences/promoters.fa
        $ bedtools getfasta -s -name+ -fi genome/GRCh38.p10.genome.fa -bed bed/five.prime.utrs.bed -fo sequences/five.prime.utrs.fa
        $ bedtools getfasta -s -name+ -fi genome/GRCh38.p10.genome.fa -bed bed/three.prime.utrs.bed -fo sequences/three.prime.utrs.fa
        ```
    * Merge exons
      * [3'-UTR](./T3/Scripts/3'UTR.exon.R)
        ```R
        #!/usr/bin/env Rscript

        message("Load required packages ...")
        suppressPackageStartupMessages(library("Biostrings"))


        input.sequences.path <- "sequences/three.prime.utrs.fa"
        output.sequences.path <- "sequences/three.prime.utrs.spliced.fa"

        message("Load sequences ...")
        # load fasta file with readBStringSet function in Biostrings package
        sequences <- readBStringSet(input.sequences.path, format="fasta")

        #example: ENSG00000257315.2-ENST00000550078.2::chr1:203848330-203848407(+)
        seq.names.long <- names(sequences)

        #example: ENSG00000257315.2-ENST00000550078.2
        seq.names <- unlist(lapply(seq.names.long,function(s){strsplit(s,"::")[[1]][1]}))

        #example: chr1:203848330-203848407(+)
        regions <- unlist(lapply(seq.names.long,function(s){strsplit(s,"::")[[1]][2]}))

        #example: 203848330
        start.positions <- as.numeric(unlist(lapply(regions,function(s){strsplit(strsplit(s,":")[[1]][2],"-")[[1]][1]})))
        strands <- unlist(lapply(regions,function(s){l=nchar(s);substr(s,l-1,l-1);}))


        region.table <- data.frame(seq.names.long=seq.names.long,start.positions=start.positions,strands=strands)

        intervals.by.tx <- split(region.table,seq.names)

        message("Concatenate sequences ...")

        string.set <- DNAStringSet()
        for(tx.id in names(intervals.by.tx)){
        intervals <- intervals.by.tx[[tx.id]]
        if(intervals$strands[1]=="+"){
        intervals <- intervals[order(intervals$start.positions,decreasing=F),];
        }else{
        intervals <- intervals[order(intervals$start.positions,decreasing=T),];
        }
        # concatenate exons that belongs to same UTR into a single spliced sequence
        spliced.sequence <- paste(apply(intervals,1,function(x){toString(sequences[x[1]]);}),collapse="")
        string.set[[tx.id]] = spliced.sequence
        }

        # save results in fasta format

        message("Saving results ...")
        writeXStringSet(string.set,output.sequences.path)
        message("All done.")
        ```
      * [5'-UTR](./T3/Scripts/5'UTR.exon.R)

        ```R
        #!/usr/bin/env Rscript

        message("Load required packages ...")
        suppressPackageStartupMessages(library("Biostrings"))


        input.sequences.path <- "sequences/five.prime.utrs.fa"
        output.sequences.path <- "sequences/five.prime.utrs.spliced.fa"

        message("Load sequences ...")
        # load fasta file with readBStringSet function in Biostrings package
        sequences <- readBStringSet(input.sequences.path, format="fasta")

        #example: ENSG00000257315.2-ENST00000550078.2::chr1:203848330-203848407(+)
        seq.names.long <- names(sequences)

        #example: ENSG00000257315.2-ENST00000550078.2
        seq.names <- unlist(lapply(seq.names.long,function(s){strsplit(s,"::")[[1]][1]}))

        #example: chr1:203848330-203848407(+)
        regions <- unlist(lapply(seq.names.long,function(s){strsplit(s,"::")[[1]][2]}))

        #example: 203848330
        start.positions <- as.numeric(unlist(lapply(regions,function(s){strsplit(strsplit(s,":")[[1]][2],"-")[[1]][1]})))
        strands <- unlist(lapply(regions,function(s){l=nchar(s);substr(s,l-1,l-1);}))


        region.table <- data.frame(seq.names.long=seq.names.long,start.positions=start.positions,strands=strands)

        intervals.by.tx <- split(region.table,seq.names)

        message("Concatenate sequences ...")

        string.set <- DNAStringSet()
        for(tx.id in names(intervals.by.tx)){
        intervals <- intervals.by.tx[[tx.id]]
        if(intervals$strands[1]=="+"){
        intervals <- intervals[order(intervals$start.positions,decreasing=F),];
        }else{
        intervals <- intervals[order(intervals$start.positions,decreasing=T),];
        }
        # concatenate exons that belongs to same UTR into a single spliced sequence
        spliced.sequence <- paste(apply(intervals,1,function(x){toString(sequences[x[1]]);}),collapse="")
        string.set[[tx.id]] = spliced.sequence
        }

        # save results in fasta format

        message("Saving results ...")
        writeXStringSet(string.set,output.sequences.path)
        message("All done.")
        ```
    * **Filter length**
      * Create [`R` script](./T3/Scripts/filter.short.R)

        ```R
        # filter.short.R
        # Usage: Rscript filter.short.R input.fasta output.fasta min_len

        library(Biostrings)

        args <- commandArgs(trailingOnly = TRUE)
        input_file <- args[1]
        output_file <- args[2]
        min_len <- as.numeric(args[3])

        # read from fasta
        seqs <- readDNAStringSet(input_file)

        # Filter sequences by length
        filtered <- seqs[width(seqs) >= min_len]

        # Output
        writeXStringSet(filtered, output_file)

        # Report
        cat("Original:", length(seqs), "sequences\n")
        cat("Filtered:", length(filtered), "sequences (min length", min_len, ")\n")
        cat("Removed:", length(seqs) - length(filtered), "sequences\n")
        ```
      * Filter

        ```bash
        $ Rscript scripts/filter.short.R \
        > sequences/five.prime.utrs.spliced.fa \
        > sequences/five.prime.utrs.spliced.filtered.fa \
        > 50
        Original: 79 sequences
        Filtered: 72 sequences (min length 50 )
        Removed: 7 sequences
        ```
    * Shuffled background sequence

        ```bash
        $ fasta-dinucleotide-shuffle \
        > -f sequences/five.prime.utrs.spliced.filtered.fa >\
        > sequences/five.prime.utrs.spliced.dinuc.shuffled.fa
        ```
* Analysis
  * Motif discovery

    ```bash
    $ meme \
    > -dna \
    > -minw 6 -maxw 10 \
    > -oc five.prime.utrs.motif.discovery \
    > -nmotifs 5 \
    > sequences/five.prime.utrs.spliced.filtered.fa

    $ perl ~/motif/meme/libexec/meme-5.5.9/meme_xml_to_html \
    > five.prime.utrs.motif.discovery/meme.xml \
    > five.prime.utrs.motif.discovery/meme.html
    ```
  * Motif enrichment

    ```bash
    $ ame \
    > --control sequences/five.prime.utrs.spliced.dinuc.shuffled.fa \
    > --oc five.prime.utrs.motif.enrichment \
    > sequences/five.prime.utrs.spliced.filtered.fa \
    > known-motifs/Ray2013_rbp_Homo_sapiens.meme
    ```
* Results
  * Motif discovery
    * Acquired [motifs](./T3/Screenshots/motif.discovery.png)
    ![motifs](./T3/Screenshots/motif.discovery.png)
    * Result suggests **no significant motif found**
  * Motif enrichment
    * Acquired [enrichment](./T3/Screenshots/motif.enrichment.png)
    ![enrichment](./T3/Screenshots/motif.enrichment.png)
    * Result suggests **no significant enrichment found**
---
### T4
> Motif finding on ChIP-seq peaks
* Preparation and analysis

    ```bash
    $ homerTools extract \
    > ~/chip-seq/output/part.peak \
    > ~/homer/data/genomes/sacCer2/ -fa >\
    > sequences/chip-seq.peaks.fa

    $ meme \
    > -dna \
    > -minw 6 -maxw 10 \
    > -oc chip-seq.peak.motif.discovery \
    > -nmotifs 5 \
    > sequences/chipe-seq.peaks.fa

    $ perl ~/motif/meme/libexec/meme-5.5.9/meme_xml_to_html \
    > chip-seq.peak.motif.discovery/meme.xml \
    > chip-seq.peak.motif.discovery/meme.html
    ```
* Results
  * Acquired [motifs](./T4/Screenshot/chip-seq.peak.motif.discovery.png)
  ![motifs](./T4/Screenshot/chip-seq.peak.motif.discovery.png)
  * The first **3** motifs are significant results
---