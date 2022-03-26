#!/bin/bash
# instead of typing the commands everytime, I am creating this script
# takes the fasta file name as the first argument
set -e
clustalo --in=$1.fasta --outfmt=clustal --out=$1.aln --log=$1_log.txt --wrap=100 --force -v

