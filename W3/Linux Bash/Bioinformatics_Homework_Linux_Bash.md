### 1. Bash script

```bash
#!/bin/bash

echo "This script reads a typed directory and sorts the files/directories in it."

while true; do
    read -t 60 -p "Enter your directory here: ~/linux/Bash/" dir 
    fulldir="/home/test/linux/Bash/${dir}" 

    if [ -d "$fulldir" ]; then 
        ls -F "$fulldir" 
        echo -e "These are all files/directories within your directory.\nTask done." 
        > /home/test/linux/Bash/filenames.txt
        > /home/test/linux/Bash/dirname.txt

        ls "$fulldir" > /home/test/linux/Bash/.temp.txt

        while read item; do 
            if [ -f "$fulldir/$item" ]; then 
                echo "$item" >> /home/test/linux/Bash/filenames.txt 
            elif [ -d "$fulldir/$item" ]; then 
                echo "$item" >> /home/test/linux/Bash/dirname.txt 
            else 
                continue 
            fi 
        done < /home/test/linux/Bash/.temp.txt

        read -t 60 -p "Do you want to cat the .txt files? (Press anything other than y to exit) " answer 

        if [[ ${answer,,} == "y" ]]; then 
            echo -e "\nFilenames:\n" 
            cat /home/test/linux/Bash/filenames.txt 
            echo -e "\nDirnames:\n" 
            cat /home/test/linux/Bash/dirname.txt 
        fi

        rm /home/test/linux/Bash/.temp.txt

        break 

    else 
        echo -e "Invalid directory. Type in again.\nCurrent directory ls:" 
        ls /home/test/linux/Bash
        continue
    fi 
done
```

### 2. [filenames.txt](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/Linux%20Bash/filenames.txt)
a1.txt
a.txt
b1.txt
bam_wig.sh
b.filter_random.pl
c1.txt
chrom.size
c.txt
d1.txt
dir.txt
e1.txt
f1.txt
human_geneExp.txt
if.sh
image
insitiue.txt
mouse_geneExp.txt
name.txt
number.sh
out.bw
random.sh
read.sh
test3.sh
test4.sh
test.sh
test.txt
wigToBigWig

### 3. [dirname.txt](https://revewill.github.io/Bioinfo.Revewill.github.io/W3/Linux%20Bash/dirname.txt)
a-docker
app
backup
bin
biosoft
c1-RBPanno
datatable
db
download
e-annotation
exRNA
genome
git
highcharts
home
hub29
ibme
l-lwl
map2
mljs
module
mogproject
node_modules
perl5
postar2
postar_app
postar.docker
RBP_map
rout
script
script_backup
software
tcga
test
tmp
tmp_script
var
x-rbp
