#global.R
library(shiny)
library(tidyverse)
library(CodeClanData)
library(lubridate)

#pull data

#Gleb's code

source_and_landing <- read_csv("raw_data/source_and_landing.csv")
goals_data <- read_csv("raw_data/goal_data.csv") 
exit_pages <- read_csv("raw_data/exit_pages.csv")

#exit_pages_and_goals_data is a combined dataframe of goals_data & exit_pages, 
#it contains total of 13616 rows. 
exit_pages_and_goals_data <- bind_rows(exit_pages,
                                       goals_data) %>%
  mutate(month = month(date, label = TRUE)) %>%
  filter(exitPagePath == "/events/") %>% #the filter is applied to check if the exit page was the
#/events/ page, if goalXXCompletions are 0 for either goal, it means that the session was
# terminated witout booking an event. 
  pivot_longer(c(6,7),
               names_to = "goal_completion",
               values_to = "completions_count")

ggplot(exit_pages_and_goals_data) +
   aes(x = month, 
       y = completions_count,
       fill = goal_completion) +
       # group = completions_count, 
        
      
  geom_bar(position = "dodge", stat = "identity")


#End Gleb's code
