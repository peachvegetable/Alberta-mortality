#### Preamble ####
# Purpose: Cleans the dataset from Alberta government opendata
# Author: Yihang Cai
# Date: 10 March 2024
# Contact: yihang.cai@mail.utoronto.ca
# Code is adapted from 'Telling Stories with Data' by Rohan Alexander

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####
# clean the dataset by truncating the full cause of death
cleaned_data <- read_csv("data/raw_data/raw_data.csv",
                     col_types = cols(
                       `Calendar Year` = col_integer(),
                       Cause = col_character(),
                       Ranking = col_integer(),
                       `Total Deaths` = col_integer()
                     )
) |>
  clean_names() |>
  add_count(cause) |>
  mutate(cause = str_trunc(cause, 30)
         )

cleaned_data <- cleaned_data[!is.na(alberta_data$calendar_year), ]

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
