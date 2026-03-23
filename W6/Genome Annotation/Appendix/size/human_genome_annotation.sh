#!/bin/bash

# Usage: ./extract_length_table.sh GCF_000001405.40-RS_2025_08_annotation_report.xml

XML_FILE="$1"

if [ -z "$XML_FILE" ]; then
    echo "Usage: $0 <annotation_report.xml>"
    exit 1
fi

if ! command -v xmlstarlet &> /dev/null; then
    echo "Error: xmlstarlet is not installed."
    exit 1
fi

echo "Type,Count,Total_Length_bp"

# Gene (protein coding)
count=$(xmlstarlet sel -t -v "//AssemblyCounts[@Accession='GCF_000001305.16']/Counts[@feature_type='genes']/Subcount[@subtype='protein coding']" "$XML_FILE")
echo "Protein-coding genes,$count,"

# Gene (non-coding)
count=$(xmlstarlet sel -t -v "//AssemblyCounts[@Accession='GCF_000001305.16']/Counts[@feature_type='genes']/Subcount[@subtype='non coding']" "$XML_FILE")
echo "Non-coding RNA genes,$count,"

# Pseudogenes (non-transcribed + transcribed)
non_transcribed=$(xmlstarlet sel -t -v "//AssemblyCounts[@Accession='GCF_000001305.16']/Counts[@feature_type='genes']/Subcount[@subtype='non-transcribed pseudo']" "$XML_FILE")
transcribed=$(xmlstarlet sel -t -v "//AssemblyCounts[@Accession='GCF_000001305.16']/Counts[@feature_type='genes']/Subcount[@subtype='transcribed pseudo']" "$XML_FILE")
pseudo_total=$((non_transcribed + transcribed))
echo "Pseudogenes,$pseudo_total,"

# Total genes
total_genes=$(xmlstarlet sel -t -v "//AssemblyCounts[@Accession='GCF_000001305.16']/Counts[@feature_type='genes']/Total" "$XML_FILE")
echo "All genes,$total_genes,"

# --- RNA types by transcript (from LengthStats, using Count and Mean) ---
for rna_type in lncRNA miRNA misc_RNA rRNA snRNA snoRNA tRNA mRNA; do
    count=$(xmlstarlet sel -t -v "//AssemblyStats[@Accession='GCF_000001305.16']/LengthStats[@category='$rna_type']/Count" "$XML_FILE")
    mean=$(xmlstarlet sel -t -v "//AssemblyStats[@Accession='GCF_000001305.16']/LengthStats[@category='$rna_type']/Mean" "$XML_FILE")
    if [ -n "$count" ] && [ -n "$mean" ]; then
        # Calculate total length = count * mean (as float, then round to integer)
        total=$(echo "$count * $mean" | bc | xargs printf "%.0f")
        echo "$rna_type transcripts,$count,$total"
    else
        echo "$rna_type transcripts,0,0"
    fi
done 
