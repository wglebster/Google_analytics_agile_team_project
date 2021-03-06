#global.R
library(shiny)
library(tidyverse)
library(lubridate)
library(forcats)
library(janitor)
library(data.table)

clean_source_data <- read_csv("clean_data/clean_source_data.csv") 
clean_goal_prev_data <- read_csv("clean_data/clean_goal_prev_data.csv")
landing_data <- read_csv("raw_data/source_and_landing.csv") 
source_and_landing <- read_csv("raw_data/source_and_landing.csv")
goals_data <- read_csv("raw_data/goal_data.csv") 
exit_pages <- read_csv("raw_data/exit_pages.csv")

clean_landing_data <- landing_data %>% 
  select(date, landingPagePath, sessions, goal13Completions, goal17Completions) %>% 
  clean_names()

landing_category_col<- clean_landing_data %>%
  mutate(landing_category = case_when(
    str_detect(landing_page_path, "about-us") ~ "about",
    str_detect(landing_page_path, "admissions") ~ "admissions",
    str_detect(landing_page_path, "blog") ~ "blog",
    str_detect(landing_page_path, "courses") ~ "courses",
    str_detect(landing_page_path, "events") ~ "events",
    str_detect(landing_page_path, "pre-course-work") ~ "pre-course-work",
    str_detect(landing_page_path, "[Ee]dinburgh") ~ "edinburgh",
    str_detect(landing_page_path, "[Gg]lasgow") ~ "glasgow",
    str_detect(landing_page_path, "[Ii]nverness") ~ "inverness",
    str_detect(landing_page_path, "webinar") ~ "webinar",
    str_detect(landing_page_path, "[a-z]") ~ "other",
    TRUE ~ "homepage"))

landing_cat_v_total_sessions <- landing_category_col %>% 
  ggplot() +
  aes(x = landing_category, y = sessions, fill = landing_category) +
  labs(x = "Landing Page Primary Category",
       y = "Total Number of Sessions",
       title = "\nTotal Number of Session by Primary Location Category") +
  geom_col() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))

top_10_other <- landing_category_col %>% 
  filter(landing_category == "other") %>% 
  group_by(landing_page_path) %>% 
  summarise(total_sessions = sum(sessions)) %>% 
  arrange(desc(total_sessions)) %>% 
  slice(1:10)

landing_category_col %>% 
  group_by(landing_category) %>% 
  summarise(total_sessions = sum(sessions), goal_13_total = sum(goal13completions), goal_17_total = sum(goal17completions)) %>% 
  mutate(goal_13_cr = goal_13_total/total_sessions, goal_17_cr = goal_17_total/total_sessions) %>% 
  arrange(desc(goal_13_cr))


goal_13_returns <- landing_category_col %>% 
  filter(goal13completions >= 0) %>% 
  group_by(landing_category) %>% 
  summarise(total_goal_sessions = sum(goal13completions)) %>% 
  arrange(desc(total_goal_sessions))


goal_17_returns <- landing_category_col %>% 
  filter(goal17completions >= 0) %>% 
  group_by(landing_category) %>% 
  summarise(total_goal_sessions = sum(goal17completions)) %>% 
  arrange(desc(total_goal_sessions))

