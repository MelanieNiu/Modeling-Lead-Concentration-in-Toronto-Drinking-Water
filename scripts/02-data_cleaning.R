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
library(lubridate)

#### Clean data ####
raw_data <- read.csv("inputs/data/raw_lead_data.csv")
head(raw_data)


downtown_toronto = c("M5A","M5W","M5L", "M5S", "M5K", "M5J", "M5H", "M5G", "M5E", "M5C", "M5B", "M5T", "M4Y", "M4X", "M4W", "M5V", "M5X", "M6G")
east_toronto = c("M4E", "M4M", "M4L","M4K", "M4J","M3K")
west_toronto = c("M6H", "M6J", "M6P", "M6R", "M6S","M8V")
central_toronto = c("M4V", "M5R", "M5N", "M4T", "M4N", "M4P", "M4R", "M4S")

winter_month = c("12", "1", "2")
summer_month = c("6", "7", "8")
spring_month = c("3","4", "5")
fall_month = c("9", "10", "11")

cleaned_data <- 
  raw_data |>
  janitor::clean_names()

cleaned_data |>
  mutate(year = year(cleaned_data$sample_date), month = month(cleaned_data$sample_date)) 

cleaned_data$region <- ifelse(cleaned_data$partial_postal_code %in% downtown_toronto, "downtown toronto", 
                               ifelse(cleaned_data$partial_postal_code %in% east_toronto, "east toronto", 
                                      ifelse(cleaned_data$partial_postal_code %in% west_toronto, "west toronto","central toronto")))
cleaned_data|>
  mutate(lead_amount_ppm = case_when(
    lead_amount_ppm == "<0.00005" ~ as.numeric("0.00005"),
    lead_amount_ppm!= "<0.00005" ~ as.numeric(Lead.Amount..ppm.)))|>
  select(sample_date, lead_amount_ppm, year) |>
  tidyr::drop_na()




raw_lead_data <- na.omit(raw_lead_data)
#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")

