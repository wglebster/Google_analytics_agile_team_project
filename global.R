#global.R
library(shiny)
library(tidyverse)


clean_source_data <- read_csv("clean_data/clean_source_data.csv")

#set input variables

source_sessions_plot <- function(x){
  clean_source_data %>%
    filter(date == x)
    ggplot() +
    aes(x= source, y = sessions) +
    geom_bar(stat="identity", aes(fill = source))
}


# source_courses_plot <- function(x){
#   clean_source_data %>%
#     filter(date == input$dates,
#            goal13completions == input$goal13completions,
#            goal17completions == input$goal17completions) %>% 
#     ggplot() +
#     aes(x= source, y = sessions) +
#     geom_bar(stat="identity", aes(fill = source))
# }