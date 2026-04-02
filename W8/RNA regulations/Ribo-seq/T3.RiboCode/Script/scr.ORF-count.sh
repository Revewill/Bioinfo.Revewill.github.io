RiboCode_annot=/home/test/rna_regulation/ribo-code/RiboCode_annot
OUT=/home/test/rna_regulation/ribo-code/wtuvb2/
config=${OUT}/metaplots/wtuvb2._pre_config.txt
mkdir -p ${OUT}/ORF_count
/home/test/software/miniconda3/bin/ORFcount -g ${OUT}/ORF/ORF.gtf \
-r ${OUT}/wtuvb2.Aligned.sortedByCoord.out.bam \
-f 15 -l 5 -e 100 -m 24 -M 35 -s yes \
-o ${OUT}/ORF_count/data_all.txt
