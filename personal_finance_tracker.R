# importing libraries with tidyverse including ggplot2, dplyr, tidyr, readr, purrr, tibble, stringr, and forcats
library(tidyverse)
library(skimr)

# importing personal finance file
df <- read.csv("./Personal_Finance_Dataset.csv")

# Getting the overview of the dataset
skim(df)
glimpse(df)

# Calculating the monthly income
monthly_income <- df %>%
  filter(month(Date) == 1) %>% 
  summarise(Income = sum(Amount)) %>% 

# Calculating the total income
total_income <- df %>% 
  summarise(total_income = sum(Amount))
  
# Reviewing spending by category
df %>% 
  group_by(Category) %>% 
  summarise(spendings = sum(Amount))

# Calculating the saving per month
df %>%
  group_by(month(Date)) %>% 
  filter(Category == "Savings") %>% 
  summarise(savings = sum(Amount)) %>% 

total_savings <- df %>% 
  filter(Category == "Savings") %>% 
  summarise(total_savings = sum(Amount))

total_spending <- total_income - total_savings

