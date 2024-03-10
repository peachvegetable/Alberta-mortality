#### Preamble ####
# Purpose: Simulates a dataset of death causes following a negative binomial distribution
# Author: Yihang Cai
# Date: 10 March 2024
# Contact: yihang.cai@mail.utoronto.ca
# Code is adapted from 'Telling Stories with Data' by Rohan Alexander


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####
# The dataset contains 5 death causes each year from 2000 to 2024
alberta_death_simulation <-
  tibble(
    cause = rep(x = c("Heart_attack", "Stroke", "Diabetes", "Cancer", "Accident"), times = 25),
    year = rep(x = 2000:2024, times = 5),
    deaths = rnbinom(n = 125, size = 20, prob = 0.1)
  )

alberta_death_simulation



