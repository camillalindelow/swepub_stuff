#CHL 180212
#Skriptet läser in normaliserade swepub-filer från UlfDB (databas skapad av Ulf Kronman på KB 2017-2018), kombinerar dem och skapar tibbles som kan användas för inläsning

library(tidyverse)

#kombinera tsv-filer separerade på år, erhållna via Python-skript i Gitlab/swepub_django
#Directory list:
DIRS <- Sys.getenv("R_SWEPUB_DATA") #directory masked with environmental variable set in .Renviron

if(dir.exists(DIRS) == FALSE) 
  stop("Error: the expected directory was not found")

swepub.data.dirs <- list.dirs(DIRS, full.names=TRUE, recursive = FALSE)

for(i in 1:length(swepub.data.dirs))  {
  swepub.datafiles <- list.files(swepub.data.dirs[i], pattern = "*.tsv", full.names=TRUE,
                                 recursive = FALSE, include.dirs = FALSE)
  name_file <- str_c(swepub.data.dirs[i], ".tsv")
  df <- lapply( swepub.datafiles, function(x) read_tsv(x))
  x <- df[[1]]
  for(i in 2:length(df)){
    x <- bind_rows(x,df[[i]])
    write_tsv(x, name_file)
  }
}