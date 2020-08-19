#global.R
library(shiny)
library(tidyverse)
library(lubridate)

#pull data

#Gleb's code

source_and_landing <- read_csv("raw_data/source_and_landing.csv")
goals_data <- read_csv("raw_data/goal_data.csv") 
exit_pages <- read_csv("raw_data/exit_pages.csv")


exit_pages_and_goals_data <- bind_rows(exit_pages, goals_data) %>%
  mutate(month = month(date, label = TRUE)) %>%
  pivot_longer(c(6,7),
               names_to = "course",
               values_to = "completions_count") %>%
  mutate(course = ifelse(course == "goal13Completions",
                                  "Data Analysis", "Software Development")) %>%
  group_by(month,exitPagePath) %>%
  summarise(terminated_sessions = sum(sessions))

View(exit_pages_and_goals_data)
all_exit_pages <- c(unique(exit_pages_and_goals_data$exitPagePath))
all_goal_prev_step1 <- c(unique(exit_pages_and_goals_data$goalPreviousStep1))





#End Gleb's code
