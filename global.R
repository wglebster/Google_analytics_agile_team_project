#global.R
library(shiny)
library(tidyverse)


clean_source_data <- read_csv("clean_data/clean_source_data.csv") %>% 
  rename(Source = source)

  

#set input variables

source_sessions_plot <- function(x){
    ggplot(clean_source_data_filtered()) +
    aes(x= Source, y = sessions) +
    geom_bar(stat="identity", aes(fill = Source))
}


