# importing libraries with tidyverse including ggplot2, dplyr, tidyr, readr, purrr, tibble, stringr, and forcats
library(tidyverse)
library(skimr)

# importing personal finance file
df <- read.csv("./Personal_Finance_Dataset.csv")

# Getting the overview of the dataset
skim(df)
glimpse(df)

# Creating the month feature
df <- df %>%
  mutate(month = month(Date))
