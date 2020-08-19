library(tidyverse)
library(ggplot2)


landing_data <- read_csv("raw_data/source_and_landing.csv")

view(landing_data)

landing_data %>% 
  group_by(landingPagePath) %>% 
  ggplot() +
  aes(x = landingPage, y = date) +
  geom_col()




ggplot(
  aes(x = , 
      y = )) +
  geom_bar()
