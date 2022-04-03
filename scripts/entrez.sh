#!/bin/bash

# Author: P. Venkateshwar

# Description:

# A script that takes a txt file full of queries as input and uses the entrez api to search and download fasta files
# The first argument should be a file with queries and the second argument is the database name, the third argument is the file format you want the output to have, the fourth argument is the output file name
set -e # for safety
set -x # for debugging
echo "This script is really rudimentary, strictly follow the following command convention, the script for now will not throw explanatory error statements"
echo "Usage"
echo "./entrez.sh [Query_file.txt] [DATABASE] [FORMAT] [OUTPUT FILE NAME w/o EXTENSION]"
[[ -f $1 && ( -n $2 ) && ( -n $3 ) && ( -n $4)]] && input=$1 &&  db=$2 && format=$3 && output=$4 # unelegant but works # Testing the inputs
#echo "$input" "$db" "$format"
[[ -f "$output"."$format" ]] && cat /dev/null > "$output"."$format" # If the output file already exists empty its contents.
while read -r -u 3 line; do # -u fd - read from file descriptor
	{
#echo "$line"
esearch -db "$db" -query "$line" | efetch -format "$format" >> "$output"."$format" ## >> means the output file gets concatenated
	} 3<&- # the hyphen closes the file descriptor 3, so that esearch does not read from it
done 3<"$input" # input file copied to a new file descriptor 3, 
