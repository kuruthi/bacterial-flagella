#!/bin/bash

#Author: P. Venkateshwar
#Date created: 07-04-2022
#Last modified: 01-05-2022

#Description
#Script takes a fasta file as input and removes unnecessary line carriages in the sequences
#Takes a number as user and puts sequences smaller than te number in one file and sequences larger or equal to it in another file
#Have an idea to find the average size of the seqs and use that as the user given number
set -e
#set -x
small="smaller.fasta"
large="larger.fasta"
[[ -f "$small" ]] && rm "$small" #< /dev/null
[[ -f "$large" ]] && rm "$large" #< /dev/null ##Emptying the contents of the output files if they already exist
[[ -f $1 ]] && input="$1" && [[ -n $2 ]] && sort_by="$2"

tr -d "\n" < "$input" | sed -e 's/]/]\n/g' -e 's/>/\n>/g' -e 's/\n>/>/1' > "$input".temp
#Works but need to add checks to make sure there are no descrepancies between the number of seqs in the input and the output

readarray -t fasta_array < "$input".temp ##Read the file into an array
##Even numbered indices hold the name and odd numbered indices hold the sequence

for index in "${!fasta_array[@]}";
do
	if [[ $(( index % 2 )) != 0 ]]
	then	
		if [[ "${#fasta_array[index]}" -ge "$sort_by" ]]
		then
			echo "${fasta_array[index-1]}" >> "$large"
			echo "${fasta_array[index]}" >> "$large"
		elif [[ "${#fasta_array[index]}" -lt "$sort_by" ]] 
		then 
			echo "${fasta_array[index-1]}" >> "$small"
			echo "${fasta_array[index]}" >> "$small"
		fi
	fi
done

echo "Done"

exit
