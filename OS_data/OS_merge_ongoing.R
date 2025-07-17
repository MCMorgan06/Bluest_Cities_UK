# bind df by BUA22NM for OS layers

library(lifecycle)
library(readr)
library(dplyr)

# set the working directory to location of the files

# Verify the working directory has been set correctly
getwd()

setwd("")  

# Pull in data from directory and then assign new names

sw <- read_csv("surfacewater_200m_final_v1.csv", show_col_types = FALSE)
fs <- read_csv("foreshore_200m_final_v1.csv", show_col_types = FALSE)
tw <- read_csv("tidalwater_200m_final_v1.csv", show_col_types = FALSE)
bu <- read_csv("original_bua.csv", show_col_types = FALSE)

sw <- sw %>% rename(surface_water_area = area)
fs <- fs %>% rename(foreshore_area = area)
tw <- tw %>% rename(tidal_water_area = area)

sw <- sw %>% rename(name = BUA22NM)
fs <- fs %>% rename(name = BUA22NM)
tw <- tw %>% rename(name = BUA22NM)

sw <- sw %>% dplyr::select(name, surface_water_area)
fs <- fs %>% dplyr::select(name, foreshore_area)
tw <- tw %>% dplyr::select(name, tidal_water_area)

# bind by column BUA22NM
# Merge data frames 'df1', 'df2', and 'df3' by the column 'BUA22NM' and keep all rows
merged_data <- merge(sw, fs, by = "name", all = TRUE)
merged_data <- merge(merged_data, tw, by = "name", all = TRUE)
merged_data <- merge(merged_data, bu, by = "name", all = TRUE)

# export df
write_csv(merged_data, "OS_bind_final_200.csv")

