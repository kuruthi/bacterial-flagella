#!/bin/bash

#Author: P. Venkateshwar
#Date created: 06/04/2022
#Date modified:

#Description
#Script that gives you the name of the sequences in a fasta file

set -x

[[ -f $1 ]] && input=$1

cat "$input" | sed 's/\[/(/g' | sed 's/\]/)/g' | grep '(.*)' > "$input"_names.txt
count=$(cat "$input" | sed 's/\[/(/g' | sed 's/\]/)/g' | grep -c '(.*)')
echo "Number of names fetched: " "$count"
#. any character, * any number of times
dir_now=$(pwd)
#input=$(cat "$input" | tr -d '.fasta')
echo "Done, File saved as "$input"_names.txt at " "$dir_now"

exit
