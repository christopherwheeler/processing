# Final part of STIC procesing
library(tidyverse)
library(cowplot)
#=================================================================================================
# First we need to convert SN file names to site file names


# NEED NEED NEED NEED NEED NEED NEED 



#==================================================================================================
# list of all possible site names
# loop through that list
# use search op to look in filelist, what are all the files that have that string in it
# stringr
# str_detect


setwd("C:/Users/Christopher/Desktop/R_Directory/processing/test")

filelist <- list.files(recursive=TRUE)

filelist

list_of_all_sites <- c("SFM01_2", "SFM05_2", "02M08_2")

#as is, this is only doing the first one in the list (02M08_2)

for (s in list_of_all_sites){
  i_files <- which(str_detect(filelist, s))
  
  for (index in i_files){
    df_index <- read_csv(filelist[index])
    
    if (index == i_files[1]){
      df_site <- df_index
    } else {
      df_site <- bind_rows(df_site, df_index)
    }
    
  }
  
  # make sure it is arranged by date
  df_site <- arrange(df_site, datetime)
  
  # output file name
  path_to_output <- "STIC_SFM01_1_YYYYMMDD-YYYYMMDD.csv"
  
  # save
  write_csv(df_site, path_to_output)
}



head(df_site)

ggplot(df_site, aes(x = datetime, y = temperature)) + 
  geom_line() + 
  geom_smooth(color = "red") + 
  theme_cowplot()
  
