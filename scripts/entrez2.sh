#!/bin/bash

# Author: P. Venkateshwar

# Description:

# A script that takes a txt file full of queries as input and uses the entrez api to search and download fasta files
# The first argument should be a file with queries and the second argument is the database name, the third argument is the file format you want the output to have
set -e # for safety
set -x # for debugging
echo "This script is really rudimentary, strictly follow the following command convention, the script for now will not throw explanatory error statements"
echo "Usage"
echo "./entrez.sh [Query_file.txt] [DATABASE] [FORMAT]"
[[ -f $1 && ( -n $2 ) && ( -n $3 ) ]] && input=$1 &&  db=$2 && format=$3 # unelegant but works # Testing the inputs
echo "$input" "$db" "$format"
while read -r line; do
	{
#echo "$line"
esearch -db "$db" -query "$line" </dev/null | efetch -format "$format" >> output."$format"
	} # Read detailed comment at the bottom
done < "$input"

exit

## Have to thank u/aioeu who suggested adding </dev/null
#+ Which I understand basically tells esearch to read from nothing all the
#+ while letting esearch believe that it has read something.
## The reason the while loop quits prematurely without reading all the 
#+ queries when we didnot add </dev/null was because esearch was reading 
#+ stdin along with the while loop and moved the file pointer to the end
