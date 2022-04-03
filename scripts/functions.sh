#!/bin/bash

#Author: P. Venkateshwar
#Date created: 03/04/2022
#Last modified:

#Description:
#Functions for the entrez file will be defined here

#set -e #Exit in case of problems #don't know if necessary in a functions file
#set -x #Only for debugging #Comment or uncomment

#This section checks if the command arguments are passed correctly
function check_args {
	def_format="fasta" #let fasta be the default output format
[ -f "$1" ] && input="$1" 

if [ ! -e "$2" ] #check if the supplied output name is file already, if not
then
	if [[ -n "$3" && ( "$3" != "$def_format") ]] #and a output format is specified
	then
		output="$2"."$3" #output file is given the user chosen filename and
				 #+extension
		format="$3"
	elif [[ -z "$3" || ( "$3" = "$def_format") ]] #if user has not specified a file format or gave fasta
	then
		output="$2"."$def_format" #then output file is given the user chosen
					  #+file name and the default file extension
		format="$def_format"
	elif [[ -n "$3" && ( "$3" = "$def_format") ]]
	then
		output="$2"
		format="$def_format"
	fi
elif [ -e "$2" ] #if the file does exist
then
	if [[ -n "$3" && ( "$3" != "$def_format") ]] #and the format is given 
	then
		output="$2"[v]."$3" #the output file is saved with an altered name
		format="$3"
	elif [[ -z "$3" || ( "$3" = "$def_format") ]] #either format not specified or fasta, we use default
	then 
		output="$2"[v]."$def_format"
		format="$def_format"
	fi
fi
##The above code block is completely ugly and unelegant, change it
#echo "$output"
} 

#Function that calls the NCBI database

function prot_result_count {

	db1="protein" #The databases where we are going to be searching for the proteins
	db2="ipg"
	grep_string="<Count>" #ignore case in case the pattern changes in the future
	error_file="error.log"
	failed="failed_queries.txt"
	while read -r -u 3 line; do
		{
			db1_count=$(esearch -db "$db1" -query "$line" | grep -i "$grep_string" | grep -o '[0-9]' | tr -d '\n')
			db2_count=$(esearch -db "$db2" -query "$line" | grep -i "$grep_string" | grep -o '[0-9]' | tr -d '\n')
			echo "For " "$line"
			echo "Results found in Protein database:" "$db1_count"
			echo "Results found in Identical Protein Groups database:" "$db2_count"
			if [ "$db1_count" -le "$db2_count" ] && [ "$db1_count" != 0 ] #-le because being less is what we want
			then
				db="$db1"
				echo "Choosing to download from " "$db1"
				esearch -db "$db" -query "$line" | efetch -format "$format" >> "$output"
			elif [ "$db1_count" -gt "$db2_count" ] && [ "$db2_count" != 0 ]
			then
				db="$db2"
				echo "Choosing to download from " "$db2"
				esearch -db "$db" -query "$line" | efetch -format "$format" >> "$output"
			elif [ "$db1_count" == 0 ] && [ "$db2_count" == 0 ]
			then
				echo "Zero results found in both databases"
				echo "Passing failed query to failed_queries file"
				touch "$failed"
				echo "$line" >> "$failed"	
			fi
		} 3<&-
	done 3<"$input"
}
