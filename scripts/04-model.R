#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("STA302 projects/Term Paper 3/outputs/data/analysis_data.csv")

### Model data ####

test_model_1 <-
  stan_glm(
    log(lead_concentration_ppb) ~ season,
    data = analysis_data
  )

summary(test_model_1)

test_model_2 <-
  lm(
    lead_concentration_ppb ~ region,
    data = analysis_data
  )

summary(test_model_2)

## Plotting lead concentration vs. season

base_plot <- 
  analysis_data |>
  ggplot(aes(x = season, y = lead_concentration_ppb)) +
  geom_point(alpha = 0.5) +
  labs(
    x = "Season",
    y = "Lead concentration (ppb)"
  ) +
  theme_classic()

# Panel (a)
base_plot

# Panel (b)
base_plot +
  geom_smooth(
    method = "lm",
    se = FALSE,
    color = "black",
    linetype = "dashed",
    formula = "y ~ x"
  )

# Panel (c)
base_plot +
  geom_smooth(
    method = "lm",
    se = TRUE,
    color = "black",
    linetype = "dashed",
    formula = "y ~ x"
  )

## Diagnostics

#plot (a) distribution of residuals
residuals <- resid(test_model_1)
ggplot(data.frame(residuals), aes(x = residuals)) +
  geom_histogram(binwidth = 0.1, colour = "black", fill = "grey") +
  theme_classic() +
  labs(y = "Number of occurrences", x = "Log transformed residuals for Season")


# Plot (b) residuals by seasons
ggplot(analysis_data, aes(x = season, y = residuals)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dotted", color = "grey") +
  theme_classic() +
  labs(y = "Residuals", x = "Season")


# Plot (c) residuals by lead concentration
ggplot(analysis_data, aes(x = marathon_time, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dotted", color = "grey") +
  theme_classic() +
  labs(y = "Residuals", x = "lead concentration (ppb)")

# # Plot d)
# # Calculate fitted values from the model
# fitted_values <- fitted(test_model_1)
# 
# # Add these fitted values to your dataframe
# analysis_data$.fitted <- fitted_values
# ggplot(analysis_data, aes(x = season, y = .fitted)) +
#   geom_point() +
#   geom_smooth(method = "lm", se = FALSE, color = "blue") +  # Add a linear model line without standard error
#   theme_classic() +
#   labs(y = "Fitted Lead Concentration (ppb)", x = "Season")

# Check Assumptions



#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)



