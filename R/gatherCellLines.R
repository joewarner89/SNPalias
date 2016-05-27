library(readr)
library(dplyr)
library(tidyr)
matchcell <- read_csv("https://raw.githubusercontent.com/bhklab/DRUGNET/master/Curation/matching_cell.csv")
## remove NA column
matchcell <- matchcell[, -which(is.na(names(matchcell)))]
## subset variables that are not ID vars into object
verbosevars <- select(matchcell, Comment, COSMIC.tissueid)
## remove unwanted variables from data
matchcell <- select(matchcell, -Comment, -COSMIC.tissueid)

matchcell2 <- gather(matchcell, key = "idtype", value = "multi.cellid", 2:length(matchcell))
matchcell2 %>% select(unique.cellid, multi.cellid) -> matchcell2
matchcell2 <-  matchcell2[apply(matchcell2, 1, function(rows) { !duplicated(rows) })[2, ] ,]
matchcellF <- matchcell2[complete.cases(matchcell2),]
