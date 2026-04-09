# filter_fasta.R
# Usage: Rscript filter_fasta.R input.fasta output.fasta min_len

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