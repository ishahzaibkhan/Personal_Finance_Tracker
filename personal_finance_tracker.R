# importing libraries with tidyverse including ggplot2, dplyr, tidyr, readr, purrr, tibble, stringr, and forcats
library(tidyverse)
library(skimr)

# importing personal finance file
df <- read.csv("./Personal_Finance_Dataset.csv")

# Getting the overview of the dataset
skim(df)
glimpse(df)

# Extracting month and year from the date for grouping
df <- df %>%
  mutate(Month = month(Date))

# Calculating monthly income and keeping all months
df <- df %>%
  group_by(Month) %>%
  mutate(Monthly_income = sum(Amount))

# Reviewing spending by category
df %>% 
  group_by(Category) %>% 
  summarise(spendings = sum(Amount))

# Calculating the saving per month
df %>%
  group_by(month(Date)) %>% 
  filter(Category == "Savings") %>% 
  summarise(savings = sum(Amount))

total_savings <- df %>% 
  filter(Category == "Savings") %>% 
  summarise(total_savings = sum(Amount))

# total_spending <- total_income - total_savings


