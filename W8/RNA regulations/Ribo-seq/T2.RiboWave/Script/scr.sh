mkdir -p /home/test/rna_regulation/ribo-wave/GSE52799/Ribowave
script/Ribowave \
-T 9012445  GSE52799/mRNA/SRR1039761.RPKM \
-a GSE52799/bedgraph/SRR1039770/final.psite \
-b annotation_fly/final.ORFs \
-o GSE52799/Ribowave \
-n SRR1039770 \
-s script \
-p 8
