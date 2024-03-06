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

#### Test data ####

simulated_lead_data$simulated_year|> min() == 2014
simulated_lead_data$simulated_year |> max() == 2023
simulated_lead_data$simulated_lead_amount_ppm |> class() == "double"
simulated_lead_data$simulated_year |> class() == "integer"

