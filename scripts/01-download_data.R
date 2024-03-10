#### Preamble ####
# Purpose: Downloads the dataset from Alberta government opendata
# Author: Yihang Cai
# Date: 10 March 2024
# Contact: yihang.cai@mail.utoronto.ca
# Code is adapted from 'Telling Stories with Data' by Rohan Alexander


#### Workspace setup ####
library(tidyverse)
library(readr)

#### Download data ####
# read the raw csv file to alberta_cod
alberta_cod <-
  read_csv(
    "https://open.alberta.ca/dataset/03339dc5-fb51-4552-97c7-853688fc428d/resource/3e241965-fee3-400e-9652-07cfbf0c0bda/download/deaths-leading-causes.csv",
    skip = 2
  )


#### Save data ####
# save the raw data
write_csv(alberta_cod, "data/raw_data/raw_data.csv") 

         
