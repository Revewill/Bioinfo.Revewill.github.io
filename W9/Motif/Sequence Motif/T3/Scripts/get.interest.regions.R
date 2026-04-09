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