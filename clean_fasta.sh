#!/bin/bash

#Author: P. Venkateshwar
#Date created: 07-04-2022
#Last modified:

#Description
#Script takes a fasta file as input and removes unnecessary line carriages in the sequences

set -e
set -x

[[ -f $1 ]] && input="$1"

tr -d "\n" < "$input" | sed -e 's/]/]\n/g' -e 's/>/\n>/g' -e 's/\n>/>/1' > "$input".temp

#Works but need to add checks to make sure there are no descrepancies between the number of seqs in the input and the output
echo "Done"

exit
