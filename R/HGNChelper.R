####create connection with the database 
if(!file.exists('HGNChelper1.sqlite')) getSQLiteFile()
file.info('HGNChelper.sqlite')
db <- dbConnect(SQLite(), 'HGNChelper1.sqlite')
#### Check the database tables
dbListTables(db)

##Getting the data out of HGNChelper
install.packages("HGNChelper")
data("hgnc.table", package="HGNChelper", envir=environment())
head(hgnc.table)
hgnc <-hgnc.table
hgnc
#### create a csv file from HGNChelper package
write.csv(hgnc,"hgnc.csv", row.names=FALSE, na="",col.names=FALSE, sep=",")
hgnc1 <- read.csv("hgnc.csv")
hgnc1
View(hgnc1)
### Read the table for drug curation and cell line curation 
drug <- read.csv("drugid.csv")
drug
cell <- read.csv("cell.curation.csv")
cell

snp <- read.csv("gene_sym.csv")
snp

### Integrade data into database 
#### Creating table for all the snp alias
dbWriteTable(db, "snp", "gene_sym.csv", overwrite = TRUE,sep = ",",eol = "\r")
dbListFields(conn = db,"snp")

##Creating table for all the hgnc table 
dbWriteTable( db, "hgnc", "hgnc.csv", overwrite = TRUE, sep = ",",eol = "\r")
### creating table for all the drugid table
dbRemoveTable(db,"snp")
dbWriteTable(conn = db, name = "drugid", value = "drugid.csv",overwrite = TRUE, eol = "\r")
dbListFields(db, "snp")
#### creating table for all the cellid data
dbWriteTable(conn = db, name = "cellid", value = "cell.curation.csv", eol = "\r")
dbListFields(db,"cellid")
### Read table for all the files 
dbListTables(db)
dbListFields(db,"hgnc")
View(dbReadTable(db,"cellid"))
#### Queries all the tables
gene <- dbGetQuery(db, 'select * from hgnc ')
gene
approveSym <- dbGetQuery(db,'select Approved_Symbol from hgnc' )
View(approveSym)
Symbol <- dbGetQuery(db,'select Symbol from hgnc')
Symbol
#Queries for snp tables

approveSym1 <- dbGetQuery(db, paste("select Approved_Symbol from snp"))
approveSym1
Symbol1 <- dbGetQuery(db,'select Symbol from snp')
Symbol1

## Queries for drug id 
drugI<- dbGetQuery(db,'select unique_drugid from drugid')
drugI

## queries for cell id
cellI <- dbGetQuery(db,"select unique_cellid from cellid")
cellI
install.packages("tcltk")
library(HGNChelper)
