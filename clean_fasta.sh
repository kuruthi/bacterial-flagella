#!/bin/bash

#Author: P. Venkateshwar
#Date created: 07-04-2022
#Last modified: 01-05-2022

#Description
#Script takes a fasta file as input and removes unnecessary line carriages in the sequences
#Adding functionalities
set -e
#set -x

[[ -f $1 ]] && input="$1"

tr -d "\n" < "$input" | sed -e 's/]/]\n/g' -e 's/>/\n>/g' -e 's/\n>/>/1' > "$input".temp
readarray -t fasta_array < "$input".temp

for index in "${!fasta_array[@]}"; ## Don't know the use of "!" here, but the script needs it
do
	if [[ $(( index % 2 )) != 0 ]] 
	then
	declare "$( echo "${fasta_array[ (( index - 1 )) ]}" | cut -f 1 -d " " | tr -d ">_." )"="${#fasta_array[index]}"
	echo "$"$(echo "${fasta_array[ (( index - 1 )) ]}" | cut -f 1 -d " " | tr -d ">_." )""

	fi
	#i=$(( i + 1 )) #incrementing
done

#echo "${#fasta_array[@]}"
#echo "${#fasta_array[1]}"
#Works but need to add checks to make sure there are no descrepancies between the number of seqs in the input and the output
echo "Done"

exit
