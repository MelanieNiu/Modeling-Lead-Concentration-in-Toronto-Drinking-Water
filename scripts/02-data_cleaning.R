#### Preamble ####
# Purpose: Cleans the raw non regulated lead data
# Author: Yuchao Niu
# Date: 25 Jan 2024
# Contact: yc.niu@utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####
raw_lead_data <- read_csv("STA302 projects/Term Paper 3/inputs/data/raw_lead_data.csv")

## Clean Column Names
cleaned_data <-
  raw_lead_data |>
  janitor::clean_names() |>
  rename(
    postal_code = partial_postal_code,
    lead_concentration_ppb = lead_amount_ppm
  ) |>
  mutate(sample_date = as.Date(sample_date)) |>
  filter(year(sample_date) != 2014) |>
  select(
    sample_date,
    postal_code,
    lead_concentration_ppb
  ) |>
  na.omit()

cleaned_data <- cleaned_data |>
  mutate(lead_concentration_ppb = str_remove(lead_concentration_ppb, "<")) |>
  mutate(lead_concentration_ppb = as.numeric(lead_concentration_ppb)) |>
  mutate(postal_code = str_replace(postal_code, "m2l", "M2L")) 

head(cleaned_data)

### Create variables season and region

downtown_toronto = c("M5A","M5W","M5L", "M5S", "M5K", "M5J", "M5H", "M5G", "M5E", "M5C", "M5B", "M5T", "M4Y", "M4X", "M4W", "M5V", "M5X", "M6G")
east_toronto = c("M4E", "M4M", "M4L","M4K", "M4J","M3K")
west_toronto = c("M6H", "M6J", "M6P", "M6R", "M6S","M8V")
central_toronto = c("M4V", "M5R", "M5N", "M4T", "M4N", "M4P", "M4R", "M4S")

# winter_month = c("12", "1", "2")
# summer_month = c("6", "7", "8")
# spring_month = c("3","4", "5")
# fall_month = c("9", "10", "11")
# 
# cleaned_data <- cleaned_data |>
#   mutate(year = year(sample_date), month = month(sample_date))
# 
# 
# cleaned_data$region <- ifelse(cleaned_data$postal_code %in% downtown_toronto, "downtown toronto", 
#                               ifelse(cleaned_data$postal_code %in% east_toronto, "east toronto", 
#                                      ifelse(cleaned_data$postal_code %in% west_toronto, "west toronto","central toronto")))
# 
# cleaned_data$season <- ifelse(cleaned_data$month %in% winter_month, "winter", 
#                               ifelse(cleaned_data$month %in% summer_month, "summer", 
#                                      ifelse(cleaned_data$month %in% spring_month, "spring","fall")))


#### Save data ####
write_csv(cleaned_data, "STA302 projects/Term Paper 3/outputs/data/analysis_data.csv")

head(cleaned_data)