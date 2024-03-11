#### Preamble ####
# Purpose: Generates models of the dataset
# Author: Yihang Cai
# Date: 10 March 2024
# Contact: yihang.cai@mail.utoronto.ca
# Code is adapted from 'Telling Stories with Data' by Rohan Alexander


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(dplyr)

#### Read data ####
alberta_cod <- read_csv("data/analysis_data/analysis_data.csv")

### Model data ####
# Identify causes of death that have been recorded in each of the 22 years before 2022
causes_in_all_years <- alberta_cod |>
  group_by(cause) |>
  summarize(count_years = n_distinct(calendar_year)) |>
  filter(count_years == 22) |>
  ungroup() |>
  select(cause)

# Find the top five causes of death in 2022 from those that have been present in all previous years
alberta_cod_top_five <- alberta_cod |>
  filter(calendar_year == 2022, cause %in% causes_in_all_years$cause) |>
  slice_max(order_by = desc(ranking), n = 5) |>
  pull(cause)

# Filter the original 'alberta_cod' dataset to include only the top five causes
alberta_cod <- alberta_cod |>
  filter(cause %in% alberta_cod_top_five)

# Generate the poisson model
poisson_model <-
  stan_glm(
    total_deaths ~ cause,
    data = alberta_cod,
    family = poisson(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 777
  )

# Generate the negative binomial model
neg_binomial_model <-
  stan_glm(
    total_deaths ~ cause,
    data = alberta_cod,
    family = neg_binomial_2(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 777
  )

#### Save model ####
saveRDS(
  poisson_model,
  file = "models/poisson_model.rds"
)

saveRDS(
  neg_binomial_model,
  file = "models/neg_binomial_model.rds"
)
