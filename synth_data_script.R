library(synthpop)
library(tidyverse)
# load original data
exit_pages <- read_csv("raw_data/exit_pages.csv")
goal_data <- read_csv("raw_data/goal_data.csv")
#source_and_landing <- read_csv("raw_data/source_and_landing.csv")

#synthesize data
View(goal_data)

exit_pages_URLs <- exit_pages$exitPagePath
data_size <- 20
synth_exit_pages <- tibble(
  date = exit_pages$date,
  exitPagePath = sample(exit_pages_URLs,  replace = TRUE),
  sessions = sample(exit_pages$sessions),
  users = sample(exit_pages$users),
  timeOnPage = sample(exit_pages$timeOnPage),
  goal13Completions = sample(exit_pages$goal13Completions),
  goal17Completions = sample(exit_pages$goal17Completions)
  )
write_csv(synth_exit_pages, "synth_raw_data/exit_pages.csv")

goal_data_URLs <- goal_data$goalPreviousStep1
data_size <- 20
synth_goal_data <- tibble(
  goal_data$date,
  goalPreviousStep1 = sample(goal_data_URLs, replace = TRUE),
  goal13Completions = sample(goal_data$goal13Completions),
  goal17Completions = sample(goal_data$goal17Completions)
)
write_csv(synth_goal_data, "synth_raw_data/goal_data.csv")
