#!/bin/bash

# Function statement
echo -e "This is a bash script that generates random sequences and align them based on BLAST algorithm."

# Locate file and acquire permission
read -t 60 -p "Type your file's directory here: ~/blast/" dirpath
fulldirpath="/home/test/blast/${dirpath}"