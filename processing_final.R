# Final part of STIC procesing
#=================================================================================================
# First we need to convert SN file names to site file names






#==================================================================================================
# list of all possible site names
# loop through that list
# use search op to look in filelist, what are all the files that have that string in it
# stringr
# str_detect

list_of_all_sites <- c("SFM01_1", "SFM01_2")

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
