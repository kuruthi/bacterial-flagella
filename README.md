# bacterial-flagella
A repository for my entrez shell scripts.

This is a student project and project code is available under GNU public license, don't forget to credit.
All the script files are written in Bash, and there is some R code too.
The script file functions.sh contains all the functions used here. Other script files source the functions.sh file and call the functions.

entrez_v2.sh Usage
=============================================================================================================================================
entrez_v2.sh takes a fasta formatted file as the input
The three arguments to the file are [Input fasta file], [Output file name], [output file format].
The third argument is optional, if omitted the default file format is taken as fasta.
You can change this behavior by editing the def_format variable in the functions.sh file.

Other scripts
==============================================================================================================================================
The repo also contains some of my scripts that have no direction, scripts that I wrote for my own particular use case or for fun.
**clean_fasta.sh** is a simple script that removes unnecessary line carriages in the input fasta file and returns a new file as 
[input_file].new
**getnames_output.sh** -- I wrote this script to get a file that contains all the names of the sequences in a fasta file,
can prove quite handy if you want to know what are the sequences present.
The script works with the help of unix cli utilities grep, and sed.
