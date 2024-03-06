#### Preamble ####
# Purpose: Downloads and saves the data from [OpenToronto]
# Author: Yuchao Niu
# Date: 21 January, 2024
# Contact: yc.niu@utoronto.ca
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
install.packages("opendatatoronto")
library(opendatatoronto)
library(tidyverse)

#### Download data ####


raw_lead_data <- 
  read.csv(
    file = "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/8171f7ab-364e-46a7-8a62-08f073ca6d96/resource/4b141457-e2a5-43e9-b5a4-25629419521d/download/Non%20Regulated%20Lead%20Samples.csv"
  )

head(raw_lead_data) ##[Do I need to comment on this?]

#### Save data from the Toronto Opendata website  ####
write.csv(x = raw_lead_data, "inputs/data/raw_lead_data.csv") 



