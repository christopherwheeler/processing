# Row binding STIC data from same site in different folders
library(tidyverse)

setwd("C:/Users/Christopher/Desktop/R_Directory/processing/test")

filelist <- list.files(recursive=TRUE)

list_of_all_sites <- c("SFM01_2", "SFM05_2", "02M08_2")

list_of_all_dataframes <- map(
  list_of_all_sites,
  ~ list.files(pattern = .x, recursive = TRUE) %>%
    map_df(read_csv)
)

names(list_of_all_dataframes) <- list_of_all_sites

list2env(list_of_all_dataframes,envir=.GlobalEnv)

