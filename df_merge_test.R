data_dir <- "konza_stics_round_1"

fs::dir_ls(data_dir)

length(data_dir)

stic_files <- fs::dir_ls(data_dir, regexp = "\\.csv$")

### using the map_dfr function from tidyverse to loop in individual csvs and bind rows
stic_files <- stic_files %>% 
  map_dfr(read_csv)

#==============================================================================
# Merging Datframes with same name from two different folders (test)

library(tidyverse)

df <- map_dfr(1:2, ~ read_csv(glue::glue("test{.x}/20821654.csv")))

filenames <- list.files(pattern = 'abc\\.csv', recursive = TRUE)

result <- purrr::map_df(filenames, read.csv, .id = 'id')


#==============================================================================
data_dir <- "test1"
fs::dir_ls(data_dir)
test_1_files <- fs::dir_ls(data_dir, regexp = "\\.csv$")

data_dir_2 <- "test2"
fs::dir_ls(data_dir_2)
test_2_files <- fs::dir_ls(data_dir_2, regexp = "\\.csv$")


mapply(compare.Files, test_1_files, test_1_files)


?compare.files
?do.call

#=============================================================================
library(tidyverse)


setwd("C:/Users/cwhee/Desktop/R_Directory/STICr/test")

filelist <- list.files(recursive=TRUE)

filelist

lst1 <- lapply(split(filelist, basename(filelist)), function(x) do.call(cbind, lapply(x, 
        function(y) read_csv(y, header = TRUE, string))))


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
