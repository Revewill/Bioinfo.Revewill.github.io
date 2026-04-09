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