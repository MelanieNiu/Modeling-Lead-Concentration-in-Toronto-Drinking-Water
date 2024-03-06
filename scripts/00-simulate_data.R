#### Preamble ####
# Purpose: Simulates the City of Toronto Non Regulated Lead Sample Dataset
# Author: Yuchao Niu
# Date: 25 January 2024
# Contact: yc.niu@utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(853)

#### Simulate the testing year between 2014 and 2023, the region of testing from east, west, central and downtown####
#### Simulate the testing month from winter, summer, spring and fall, simulate the lead concentration in ppm ####

simulated_lead_data <-
  tibble(
    sim_year =
      sample(c(2014:2023),size = 13000, replace = TRUE),
    sim_lead_amount_ppm =
      runif(n = 13000, min = 1e-10 , max = 1e-2),
    sim_season = sample(c("winter", "summer","spring","fall"),size = 13000, replace = TRUE),
    sim_region = sample(c("east", "west", "central","downtown"),size = 13000, replace = TRUE)
  )
head(simulated_lead_data)

