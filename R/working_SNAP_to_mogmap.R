library(data.table) ## Use data.table package for fast data processing


## setting my directory for data analysis
setwd(setwd("~/Biomedical Informatics/INTERNSHIPS/Assignment/SNAP-Results")) 

## Read all the fine using the function fread
x.all=fread("../SNAP-Results/chrUn SNAP results.txt", data.table = FALSE)

## create a variable to get all values and the null values

x2 <- x.all[x.all$Aliases != "null", ]
x3 <- strsplit(x2[, 3], ",")
names(x3) <- x2$SNP
x2

## create another valuable and eliminate Buil135, which is similar to the symbol colomn
### Name teh column Symbole and approved>Symbol
x4 <- sapply(1:length(x3), function(i) cbind(x3[[i]], names(x3)[i]))
x4 <- do.call(rbind, x4)
x4 <- data.frame(x4, stringsAsFactors = FALSE)
colnames(x4) <- c("Symbol", "Approved.Symbol")
View(x4)
#### create another variables to get the rest of the genes
x.nomap <- x.all[x.all[, 3] == "null", 1:2]
colnames(x.nomap) <- c("Symbol", "Approved.Symbol")

## Combine both variables to get all the genes

chrUn_mogmap <- rbind.data.frame(x4, x.nomap)

rownames(chrUn_mogmap) <- NULL
## Save the file in the same directory as 
save(chrUn_mogmap, file="chrUn_mogmap.rda", compress="bzip2")

## Create the file in csv format so, we can use it in any format.
write.csv(chrUn_mogmap,file="gene_sym")
## Use sqldf to get run sql querries to one column 
library(sqldf)
lol <- read.csv("gene_sym")
View(lol)
ff <- sqldf("select Symbol from lol")
write.csv(ff,file = "gene_symbol")
library(HGNChelper)
va <- affyToR(lol)
checkGeneSymbols(lol)
upp