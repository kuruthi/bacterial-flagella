library(jsonlite)

setwd("~/Documents/toxin_project/t3db/")

t3db <- fromJSON("toxins.json",simplifyDataFrame = TRUE)
View(t3db)
t3db$uniprot_id
pubchem <- t3db$pubchem_id
t3db$id[pubchem_id='104737']
class(pubchem)
as.numeric(pubchem)
protein_toxins <- read.csv("protein_toxins.csv")
View(protein_toxins)
write(protein_toxins$Toxin.name,"toxin_names.txt")
