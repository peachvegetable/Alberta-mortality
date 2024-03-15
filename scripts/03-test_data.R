#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(testthat)

#### Test data ####
alberta_data <- read.csv("data/analysis_data/analysis_data.csv")

# no missing values
test_that("No missing values in dataset", {
  expect_true(all(complete.cases(alberta_data)))
})

# Correct Number of Rows and Columns
test_that("Dataset has correct dimensions", {
  expect_equal(nrow(alberta_data), 662)
  expect_equal(ncol(alberta_data), 5)
})

# Correct Years Range
test_that("Year range is as expected", {
  filtered_years <- alberta_data$calendar_year[!is.na(alberta_data$calendar_year)]
  expect_equal(range(filtered_years), c(2001, 2022))
})

# Test that the 'cause' column is of type character
test_that("Cause column is character", {
  expect_true(is.character(alberta_data$cause))
})

# Test that the 'calendar_year' column is of type integer and non-negative
test_that("Calendar_year column is integer and non-negative", {
  expect_true(all(sapply(alberta_data$calendar_year, is.integer) | sapply(alberta_data$calendar_year, is.numeric)))
  expect_true(all(alberta_data$calendar_year >= 0))
})

# Test that the 'total_deaths' column is integer and non-negative
test_that("Total_deaths column is numeric and non-negative", {
  expect_true(is.integer(alberta_data$total_deaths))
  expect_true(all(alberta_data$total_deaths >= 0))
})
