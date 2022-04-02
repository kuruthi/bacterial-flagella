#Author: P. Venkateshwar

#Description
#An R script that outputs the toxin names from the data downloaded 
#+from the t3db database

library(jsonlite) # loading the jsonlite library
setwd("~/bacterial-flagella/t3db/") # Path to the file directory

t3db <- fromJSON("toxins.json",simplifyDataFrame = TRUE) # Reading the json file from t3db database onto the R environment

#View(t3db) # Uncomment to view in the R environment

#t3db$uniprot_id # The database is not complete and the proteins do not have a matching uniprot ID entry

#pubchem <- t3db$pubchem_id

#t3db$id[pubchem_id='104737']

# Loading the downloaded csv file into the R environment
protein_toxins <- read.csv("protein_toxins.csv")

#View(protein_toxins) #uncomment to view in the R environment

#Write the toxin names to a txt file, edit the name if needed
write(protein_toxins$Toxin.name,"toxin_names.txt")
