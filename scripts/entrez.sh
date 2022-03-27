#!/bin/bash
# A script that takes a txt file full of queries as input and uses the entrez api to search and download fasta files
# The first argument should be a file with queries and the second argument is the database name, the third argument is the file format you want the output to have
set -e # for safety
set -x # for debugging
echo "This script is really rudimentary, strictly follow the following command convention, the script for now will not throw explanatory error statements"
echo "Usage"
echo "./entrez.sh [Query_file.txt] [DATABASE] [FORMAT]"
[[ -f $1 && ( -n $2 ) && ( -n $3 ) ]] && input=$1 &&  db=$2 && format=$3 # unelegant but works # Testing the inputs
#echo "$input" "$db" "$format"
while read -r line
do
esearch -db "$db" -query "$line" | efetch -format "$format" > "$line"."$format"
done < "$input"
