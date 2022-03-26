#!/bin/bash
# A script that queries the NCBI protein database.
# Takes a file with the names of the proteins as input
set -e ## Exit if facing problems
set -x ## For debugging
url="https://www.ncbi.nlm.nih.gov/ipg/?term="
[[ -f $1 ]] && touch ~/temp.txt | sed 's_\ _\+_g' $1 > temp.txt
#echo $url
#i=0
input_file=temp.txt
while read -r line
do
  echo "Now downloading..."
  echo $line
   #i=$(i++)
   wget -v -O - $url$line > $line.html
done < $input_file

rm ~/temp.txt
