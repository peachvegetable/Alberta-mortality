#### Preamble ####
# Purpose: Simulates a dataset of death causes following a negative binomial distribution
# Author: Yihang Cai
# Date: 10 March 2024
# Contact: yihang.cai@mail.utoronto.ca
# Code is adapted from 'Telling Stories with Data' by Rohan Alexander


#### Workspace setup ####
library(tidyverse)
library(testthat)

#### Simulate data ####
# The dataset contains 5 death causes each year from 2000 to 2024
alberta_death_simulation <-
  tibble(
    cause = rep(x = c("Heart_attack", "Stroke", "Diabetes", "Cancer", "Accident"), times = 25),
    year = rep(x = 2000:2024, times = 5),
    deaths = rnbinom(n = 125, size = 20, prob = 0.1)
  )

# tests
# no missing values
test_that("No missing values in dataset", {
  expect_true(all(complete.cases(alberta_death_simulation)))
})

# Correct Number of Rows and Columns
test_that("Dataset has correct dimensions", {
  expect_equal(nrow(alberta_death_simulation), 125)
  expect_equal(ncol(alberta_death_simulation), 3)
})

# Correct Years Range
test_that("Years range from 2000 to 2024", {
  expect_equal(range(alberta_death_simulation$year), c(2000, 2024))
})

# test overdispersion
test_that("Deaths count distribution properties", {
  mean_deaths <- mean(alberta_death_simulation$deaths)
  var_deaths <- var(alberta_death_simulation$deaths)
  # For negative binomial distribution, variance should be greater than mean
  expect_true(var_deaths > mean_deaths)
})




