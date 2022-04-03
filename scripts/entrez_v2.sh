#!/bin/bash

#Author: P. Venkateshwar
#Date created: 03/04/2022
#Last modified:

#Description:
#My entrez script version 2.0
#This version will take queries from a text file and search NCBI data in
#+two databases "Protein" and "IPG", and download data from the database where the
#+number of results is lesser.
#This will hopefully solve the problem of redundant sequences getting downloaded.

set -e #Exit in case of problems
#set -x #Only for debugging #Comment or uncomment

clear #clears the terminal clutter

source ~/bacterial-flagella/scripts/functions.sh

check_args "$1" "$2" "$3" ##Calling the function

prot_result_count ##

exit
