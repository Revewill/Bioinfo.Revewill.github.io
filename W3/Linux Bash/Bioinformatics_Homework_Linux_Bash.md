---

### Bash script:

```bash
#!/bin/bash

echo "This script reads a typed directory and sorts the files/subdirectories in it."

while true; do
    read -t 60 -p "Enter your directory here: ~/linux/Bash/" dir 
    fulldir="/home/test/linux/Bash/${dir}" 

    if [ -d "$fulldir" ]; then 
        ls -F "$fulldir" 
        echo -e "These are all files/directories within your directory.\nTask done." 
        touch /home/test/linux/Bash/filenames.txt /home/test/linux/Bash/dirname.txt 

        ls "$fulldir" | while read item; do 
            if [ -f "$fulldir/$item" ]; then 
                echo "$item" >> /home/test/linux/Bash/filenames.txt 
            elif [ -d "$fulldir/$item" ]; then 
                echo "$item" >> /home/test/linux/Bash/dirname.txt 
            else 
                continue 
            fi 
        done 

        read -t 60 -p "Do you want to cat the .txt files? (Press anything other than y to exit) " answer 

        if [[ ${answer,,} == "y" ]]; then 
            echo -e "\nFilenames:\n" 
            cat /home/test/linux/Bash/filenames.txt 
            echo -e "\nDirnames:\n" 
            cat /home/test/linux/Bash/dirname.txt 
        fi 

        break 
    else 
        echo -e "This is a wrong directory! Type in again.\nCurrent directory ls:" 
        ls /home/test/linux/Bash 
    fi 
done
```

### filenames.txt:

a1.txt

a.txt

b1.txt

bam\_wig.sh

b.filter\_random.pl

c1.txt

chrom.size

c.txt

d1.txt

dir.txt

e1.txt

f1.txt

human\_geneExp.txt

if.sh

image

insitiue.txt

mouse\_geneExp.txt

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

a1.txt

a.txt

b1.txt

bam\_wig.sh

b.filter\_random.pl

c1.txt

chrom.size

c.txt

d1.txt

dir.txt

e1.txt

f1.txt

human\_geneExp.txt

if.sh

image

insitiue.txt

mouse\_geneExp.txt

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

a1.txt

a.txt

b1.txt

bam\_wig.sh

b.filter\_random.pl

c1.txt

chrom.size

c.txt

d1.txt

dir.txt

e1.txt

f1.txt

human\_geneExp.txt

if.sh

image

insitiue.txt

mouse\_geneExp.txt

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

a1.txt

a.txt

b1.txt

bam\_wig.sh

b.filter\_random.pl

c1.txt

chrom.size

c.txt

d1.txt

dir.txt

e1.txt

f1.txt

human\_geneExp.txt

if.sh

image

insitiue.txt

mouse\_geneExp.txt

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

a1.txt

a.txt

b1.txt

bam\_wig.sh

b.filter\_random.pl

c1.txt

chrom.size

c.txt

d1.txt

dir.txt

e1.txt

f1.txt

human\_geneExp.txt

if.sh

image

insitiue.txt

mouse\_geneExp.txt

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

a1.txt

a.txt

b1.txt

bam\_wig.sh

b.filter\_random.pl

c1.txt

chrom.size

c.txt

d1.txt

dir.txt

e1.txt

f1.txt

human\_geneExp.txt

if.sh

image

insitiue.txt

mouse\_geneExp.txt

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

a1.txt

a.txt

b1.txt

bam\_wig.sh

b.filter\_random.pl

c1.txt

chrom.size

c.txt

d1.txt

dir.txt

e1.txt

f1.txt

human\_geneExp.txt

if.sh

image

insitiue.txt

mouse\_geneExp.txt

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

a1.txt

a.txt

b1.txt

bam\_wig.sh

b.filter\_random.pl

c1.txt

chrom.size

c.txt

d1.txt

dir.txt

e1.txt

f1.txt

human\_geneExp.txt

if.sh

image

insitiue.txt

mouse\_geneExp.txt

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

---

### dirname.txt:

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

node\_modules

perl5

postar2

postar\_app

postar.docker

RBP\_map

rout

script

script\_backup

software

tcga

test

tmp

tmp\_script

var

x-rbp

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

node\_modules

perl5

postar2

postar\_app

postar.docker

RBP\_map

rout

script

script\_backup

software

tcga

test

tmp

tmp\_script

var

x-rbp

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

node\_modules

perl5

postar2

postar\_app

postar.docker

RBP\_map

rout

script

script\_backup

software

tcga

test

tmp

tmp\_script

var

x-rbp

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

node\_modules

perl5

postar2

postar\_app

postar.docker

RBP\_map

rout

script

script\_backup

software

tcga

test

tmp

tmp\_script

var

x-rbp

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

node\_modules

perl5

postar2

postar\_app

postar.docker

RBP\_map

rout

script

script\_backup

software

tcga

test

tmp

tmp\_script

var

x-rbp

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

node\_modules

perl5

postar2

postar\_app

postar.docker

RBP\_map

rout

script

script\_backup

software

tcga

test

tmp

tmp\_script

var

x-rbp

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

node\_modules

perl5

postar2

postar\_app

postar.docker

RBP\_map

rout

script

script\_backup

software

tcga

test

tmp

tmp\_script

var

x-rbp

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

node\_modules

perl5

postar2

postar\_app

postar.docker

RBP\_map

rout

script

script\_backup

software

tcga

test

tmp

tmp\_script

var

x-rbp

---

