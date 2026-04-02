RiboCode_annot=/home/test/rna_regulation/ribo-code/RiboCode_annot
OUT=/home/test/rna_regulation/ribo-code/wtuvb2/
mkdir -p ${OUT}
mkdir -p ${OUT}/metaplots

/home/test/software/miniconda3/bin/metaplots -a ${RiboCode_annot} \
-r /home/test/rna_regulation/ribo-code/wtuvb2/wtuvb2.Aligned.toTranscriptome.out.sorted.bam \
-o ${OUT}/metaplots/wtuvb2. \
-m 26 -M 50 -s yes -pv1 1 -pv2 1
