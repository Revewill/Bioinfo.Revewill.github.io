#!/bin/bash

# State script function
echo "This is a bash script that generates randomly shuffled sequences and align them based on BLAST algorithm."

# Locate directory
while true; do
    read -t 60 -p "Type your file's directory here: ~/blast/" dirpath

    if [[ -d "/home/test/blast/${dirpath}" ]]; then
        fulldirpath="/home/test/blast/${dirpath}"

        echo "This is all files/directories under your path."
        ls "${fulldirpath}" | cat -n

        # Locate file
        while true; do
            read -t 60 -p "Type the number before a file to select: " num
            ls "${fulldirpath}" | cat -n > "${fulldirpath}"/.tempdirpath.txt

            tempfile="${fulldirpath}/.tempdirpath.txt"
            totalnum=$(wc -l "${tempfile}" | awk '{print $1}')

            if (( ${num} <= ${totalnum} && ${num} >= 1 )); then
                numline=$(sed -n "${num}p" "${tempfile}")

                # Acquire permission
				while true; do
                	echo -e "Is this your file?\n${numline}"
                	read -t 60 -p "(y/n): " answeryn

                	if [[ ${answeryn,,} == "y" ]]; then
                   		echo "Beginning analysis now."
                    		filename=$(echo "${numline}" | awk '{$1=""; print substr($0,2)}')
                    		filepath="${fulldirpath}/${filename}"
                    
                    		# Randomly shuffle sequence
                    		echo "Beginning shuffling now."
                    		originalseq=$(cat "${filepath}")
		    				>"${fulldirpath}"/shufseq.fa

                    		for i in {1..10}; do
                        		shufseq=$(echo ${originalseq} | fold -w1 | shuf | tr -d '\n')

                        		echo ">shuffled_seq_$i" >> "${fulldirpath}"/shufseq.fa
                        		echo "${shufseq}" >> "${fulldirpath}"/shufseq.fa

                    		done

                    		shufseqfile="${fulldirpath}/shufseq.fa"
                    
                    		# Cat shufseq.fa
                    		echo -e "These are shuffled sequences in fa format (stored as ${shufseqfile})."
                    		cat "${shufseqfile}"

                    		cp "${shufseqfile}" "${fulldirpath}"/nonquery_shufseq.fa
                    		nonquery_shufseqfile="${fulldirpath}/nonquery_shufseq.fa"

                    		# Start BLAST
                    		echo "Beginning BLAST now."
                    		> "${fulldirpath}"/BLAST_results

                    		for i in {1..10}; do
                        
                        		# Extract and save query sequence
                        		grep -A1 "^>shuffled_seq_$i$" "${shufseqfile}" > "${fulldirpath}"/queryseq.fasta

                        		# Exclude query sequence from shufseq.fa
                        		sed "/^>shuffled_seq_$i$/,+1d" "${shufseqfile}" > "${nonquery_shufseqfile}"

                        		# Make BLAST database
                        		makeblastdb -dbtype prot -in "${nonquery_shufseqfile}" -out "${fulldirpath}"/database_blast

                        		# Start anlignment
                        		blastp -query "${fulldirpath}"/queryseq.fasta -db "${fulldirpath}"/database_blast -outfmt 6 -evalue 10000000 -num_threads 2 -max_hsps 1 -threshold 100 -word_size 2 >> "${fulldirpath}"/BLAST_results
                        		echo "" >> "${fulldirpath}"/BLAST_results

								# Remove database
								rm "${fulldirpath}"/database_blast.*

                    		done

                    		# End BLAST
                    		echo -e "BLAST ends now. The results for BLAST is stored in ${fulldirpath}/BLAST_results.txt."

                    		# Acquire permission to cat results
                    		while true; do
                        		read -t 60 -p "Do you want to read the results now? (y/n): " answeryn_two

                        		if [[ ${answeryn_two,,} == "y" ]]; then
                            			echo -e "qseqid\tsseqid\tpident\tlength\tmismatch\tgapopen\tqstart\tqend\tsstart\tsend\tevalue\tbitscore\n" > "${tempfile}"
                            			cat "${fulldirpath}"/BLAST_results >> "${tempfile}"
                            			cat "${tempfile}" | column -t

                            			break

                        		elif [[ ${answeryn_two,,} == "n" ]]; then
                            			break
                        
                        		else
                            			echo "Invalid answer. Type again please."
                            			continue
                        
                        		fi

                    		done

                    		# Integrate information into one file
							cp "${fulldirpath}"/BLAST_results "${fulldirpath}"/BLAST_results_old
                            echo -e "qseqid\tsseqid\tpident\tlength\tmismatch\tgapopen\tqstart\tqend\tsstart\tsend\tevalue\tbitscore\n" > "${fulldirpath}"/BLAST_results_old
							echo "" >> "${fulldirpath}"/BLAST_results_old

							cat "${fulldirpath}"/BLAST_results >> "${fulldirpath}"/BLAST_results_old
							column -t "${fulldirpath}"/BLAST_results_old > "${fulldirpath}"/BLAST_results
				
							prev=""
							while read line; do
								curr=$(echo "$line" | awk '{print $1}')

								if [[ -n "preve" && "${curr}" != "${prev}" ]]; then
									echo ""
								fi

								echo "$line"
								prev="${curr}"

							done < "${fulldirpath}"/BLAST_results > "${fulldirpath}"/BLAST_results.txt
				
							echo -e "\nShuffled sequences are shown below:\n" >> "${fulldirpath}"/BLAST_results.txt
                    		cat "${shufseqfile}" >> "${fulldirpath}"/BLAST_results.txt

                    		# Acquire permission to remove shufseqfile
                    		while true; do
                        		read -t 60 -p "Do you want to remove the file ${shufseqfile} now? (y/n): " answeryn_three

                        		if [[ ${answeryn_three,,} == "y" ]]; then
                            			echo "Removing file now."
                            			rm "${shufseqfile}"

                            			break

                        		elif [[ ${answeryn_three,,} == "n" ]]; then
                            			echo "File not removed."
                            			break
                        
                        		else
                            			echo "Invalid answer. Type again please."
                            			continue
                        
                        		fi

                    		done

                    		# Remove useless temporary files/directories
                    		echo "Removing useless tempfiles now."
                    		rm -f "${fulldirpath}"/BLAST_results "${fulldirpath}"/queryseq.fasta "${fulldirpath}"/database_blast.* "${nonquery_shufseqfile}" "${fulldirpath}"/BLAST_results_old

                    		# Exit program
                    		echo "Existing Program now."

                    		break
            
                	elif [[ ${answeryn,,} == "n" ]]; then
                    		echo "Select again please."
                    		continue 2
            
                	else
                    		echo "Invalid answer. Type again please."
                    		continue
            
                	fi

				done

                break

            else
                echo "Invalid number. Type again please."
                continue
				
            fi

            rm "${tempfile}"
        
        done

        break    

    else
        echo "Invalid path. Type again please."
        continue
    
    fi

done

exit
