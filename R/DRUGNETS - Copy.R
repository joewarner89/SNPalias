library(R.utils) #gunzip function
## Read the files we get from DRUGNET 
ht <- read.csv("matching_cell.csv")
ht
View(ht)
## View another file 
ho <-read.csv("matching_drug.csv")
ho
View(ho)

## Use sql to filter information from the 2 files
library(sqldf)
# read teh the following table.
st <- sqldf( "select unique.cellid,unique.drugid from ho, ht")
st
View(st)

## write cvs file containing both the vell curation and the drug treatment
write.csv(st, file="drug_cell")
hola <- read.csv("drug_cell")
v <- ho[,c('unique.drugid')]
v
View(v)
### create variable containing two columns: unique.drugid and unique.cellid
drugnet <- merge(ht$unique.cellid,ho$unique.drugid)
drugnet
View(drugnet)

## Name the columns as they were in DRUGNET
colnames(drugnet) <- c("unique.cellid","unique.drugid")
drugnet
write.csv(drugnet, file = "curation_id")
hhe <- read.csv("curation_id")
hhe

