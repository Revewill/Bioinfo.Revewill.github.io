#!/bin/bash
# This is a bash script for alternative splicing
# How to run this script: ./alt-spl.sh file_for_input/b1 file_for_input/b2 gtf_file

sep=$(echo "---------------------------------------------------------")
rmats_py=$(which rmats.py)

echo "$1" > "b1.txt"
echo "$2" > "b2.txt"

b1_len=$(samtools view $1 | cut -f 10 | perl -ne 'chomp;print length($_) . "\n"' | sort | uniq)
b2_len=$(samtools view $2 | cut -f 10 | perl -ne 'chomp;print length($_) . "\n"' | sort | uniq)

echo -e "$sep\nInput b1 file:\nFile name: $1\nRead lengths: $b1_len"
echo -e "$sep\nInput b2 file:\nFile name: $2\nRead lengths: $b2_len"
echo -e "$sep\nReference genome file:\nFile name: $3"

if [ "$b1_len" == "$b2_len" ]; then

	echo -e "$sep\nRead lengths of input files are identical.\nBeginning Analysis..."

	mkdir -p output
	mkdir -p tmp

	python3 "${rmats_py}" \
	--b1 b1.txt --b2 b2.txt --gtf "$3" \
	--od output --tmp tmp \
	-t paired \
	--readLength $b1_len

	rm -rf tmp
	
	mkdir -p Results
	find output -name "*.MATS.JCEC.txt" -exec cp {} Results/ \;

	echo -e "Analysis completed.\nAll results are stored in directory "output".\nExiting program now."
else
	echo -e "$sep\nThe read lengths of input files are not identical.\nPlease enter valid files for analysis!"
fi

rm b[0-9].txt
