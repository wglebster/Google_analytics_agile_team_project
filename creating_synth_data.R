library(synthpop)
library(tidyverse)

clean_source_data <- read.csv("clean_data/clean_source_data.csv")

view(clean_source_data)

syn_source_data <- syn(clean_source_data, visit.sequence = c("sessions", "goal13completions", "goal17completions"))

head(syn_source_data)

compare(clean_goal_prev_data, syn_goal_prev_data$syn)

view(syn_source_data$syn)

synth_source_data <- syn_source_data$syn

write_csv(synth_source_data, "clean_data/synth_source_data.csv")








clean_goal_prev_data <- read.csv("clean_data/clean_goal_prev_data.csv")

view(clean_goal_prev_data)

syn_goal_prev_data <- syn(clean_goal_prev_data, visit.sequence = c("goal_previous_step1", "goal13completions", "goal17completions"))

view(syn_goal_prev_data$syn)

synth_goal_prev_data <- syn_goal_prev_data$syn

write_csv(synth_goal_prev_data, "clean_data/synth_goal_prev_data.csv")