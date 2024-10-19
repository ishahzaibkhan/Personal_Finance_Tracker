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

df <- df %>% 
  mutate(Total_income = sum(df$Amount))
# Reviewing spending by category
df %>% 
  group_by(Category) %>% 
  summarise(spendings = sum(Amount))

# Calculating the saving per month
monthly_savings <- df %>%
  group_by(Month) %>% 
  filter(Category == "Savings") %>% 
  summarise(Monthly_savings = sum(Amount))

df <- df %>% 
  left_join(monthly_savings)

total_savings <- df %>% 
  filter(Category == "Savings") %>% 
  summarise(total_savings = sum(Amount))

monthly_spending <- df %>% 
  group_by(Month) %>% 
  summarise(Monthly_spending = mean(Monthly_income) - mean(Monthly_savings))

df <- df %>% 
  left_join(monthly_spending)

ggplot(monthly_savings, aes(x = as.factor(Month), y = Monthly_savings)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Monthly Savings", x = "Month", y = "Saving")

ggplot(monthly_spending, aes(x = as.factor(Month), y = Monthly_spending)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Monthly Spendings", x = "Month", y = "Spendings")

ggplot(df) +
  geom_line(aes(x = Month, y = Monthly_savings, color = "Savings")) +
  geom_line(aes(x = Month, y = Monthly_spending, color= "Spendings")) +
  labs(title = "Monthly Savings", x = "Month", y = "Saving") +
  scale_x_continuous(breaks = 1:12)
