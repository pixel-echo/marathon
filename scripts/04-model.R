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
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

### Model data ####
first_model <-
  stan_glm(
    formula = flying_time ~ length + width,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

sim_run_data_first_model_rstanarm <-
  stan_glm(
    formula = marathon_time ~ five_km_time + was_raining,
    data = sim_run_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5),
    prior_intercept = normal(location = 0, scale = 2.5),
    prior_aux = exponential(rate = 1),
    seed = 853
  )

beep()

saveRDS(
  sim_run_data_first_model_rstanarm,
  file = "sim_run_data_first_model_rstanarm.rds"
)

sim_run_data_first_model_rstanarm <-
  readRDS(file = "sim_run_data_first_model_rstanarm.rds")

prior_summary(sim_run_data_first_model_rstanarm)
