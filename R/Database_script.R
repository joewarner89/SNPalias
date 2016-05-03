
#### Load the [ackage to get the hgnc.table and create a file named hgnc ]

library(HGNChelper)
## Load the table to get all the gene symbols

data("hgnc.table", package="HGNChelper", envir=environment())
head(hgnc.table)

# Create a variable to read tables and then  save it 
hgnc <- hgnc.table
hgnc
View(hgnc)
## choose a directory to save the file 
setwd("~/Biomedical Informatics/INTERNSHIPS/Assignment")
write.csv(hgnc,"hgnc_tbl.csv")
 read.csv("hgnc_tbl.csv")
 View(read.csv("hgnc_tbl.csv"))
### Create the database containing all the tables creates during the project.
### we will name it HGNChelper 
##load required packages 
library(sqldf)
library(RSQLite)
install.packages("XLConnect")
 ## lunch a connection to make the database operational
## With no data added to the database system, it is not yet created

db <- dbConnect(SQLite(), "HGNChelper.sqlite")

## create a test connection called HGNChelper.sqlite
sqldf("attach 'HGNChelper1.sqlite' as new ")
 ### Create table based on the csv file generated 
## first we create hgnc table 
dbWriteTable( db, "hgnc", "hgnc_tbl.csv", overwrite = TRUE, sep = ",")
dbListFields(db,"hgnc")


### list the tables in the database 
dbListTables(db)
## Show the column names of hgnc 
dbListFields(db,"hgnc")

##Make a table for SNP identifiers 
## Change directory to locate the SNPs
 setwd("~/Biomedical Informatics/INTERNSHIPS/Assignment/SNAP-Results")
#### make the following tables
 dbWriteTable(db, "snp", "gene_sym.csv", overwrite = TRUE, sep = ",")
 ### checks if the tables created in the database 
 dbListTables(db)
 
 ## ## Show the column name of snp 
 dbListFields(db,"snp")
 ### create another table containing the cell line curation and drug treatments 
 ## creating the file using curation_id 
 setwd("~/Biomedical Informatics/INTERNSHIPS/Updated_file")
 hhe <- read.csv("curation_id.csv")
 ## Creation of the table in the database 
dbWriteTable(db,"cell_drug_id" ,"curation_id.csv ", overwrite = TRUE,sep="," )

 ### Checking to see if table is well created 
dbListFields(db,"cell_drug_id")
dbListTables(db)



