library(tidyverse)
library(ggplot2)


landing_data <- read_csv("raw_data/source_and_landing.csv")

view(landing_data)

clean_landing_data <- landing_data %>% 
  select(date, landingPagePath, sessions) %>% 
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
    str_detect(landing_page_path, "glasgow") ~ "glasgow",
    str_detect(landing_page_path, "inverness") ~ "inverness",
    str_detect(landing_page_path, "[a-z]") ~ "other",
    TRUE ~ "homepage"))
  
  
  group_by(landingPagePath) %>% 
  ggplot() +
  aes(x = landingPage, y = date) +
  geom_col()




