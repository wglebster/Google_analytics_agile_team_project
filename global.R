#global.R
library(shiny)
library(tidyverse)
library(lubridate)
library(forcats)

#pull data

####################Gleb's code##################

source_and_landing <- read_csv("raw_data/source_and_landing.csv")
goals_data <- read_csv("raw_data/goal_data.csv") 
exit_pages <- read_csv("raw_data/exit_pages.csv")

####################End Gleb's code##################
