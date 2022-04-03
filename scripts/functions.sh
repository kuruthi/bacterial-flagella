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
	elif [[ -z "$3" || ( "$3" = "$def_format") ]] #if user has not specified a file format or gave fasta
	then
		output="$2"."$def_format" #then output file is given the user chosen
					  #+file name and the default file extension
	elif [[ -n "$3" && ( "$3" = "$def_format") ]]
	then
		output="$2"
	fi
elif [ -e "$2" ] #if the file does exist
then
	if [[ -n "$3" && ( "$3" != "$def_format") ]] #and the format is given 
	then
		output="$2"[v]."$3" #the output file is saved with an altered name
	elif [[ -z "$3" || ( "$3" = "$def_format") ]] #either format not specified or fasta, we use default
	then 
		output="$2"[v]."$def_format"
	fi
fi
##The above code block is completely ugly and unelegant, change it
#echo "$output"
} 

#Function 
