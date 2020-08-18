library(googleAnalyticsR)
library(tidyverse)
library(lubridate)

home_location <- Sys.getenv("HOME")
credentials_location <- paste0(home_location,"/ga_credentials.R")
source(credentials_location)

options(googleAuthR.client_id = ga_client_id,
        googleAuthR.client_secret = ga_client_secret)
account_list <- ga_account_list()

my_ga_id <- account_list %>%
  filter(websiteUrl == "https://codeclan.com", viewName == "All Web Site Data") %>%
  select(viewId) %>%
  pull()

#good to go
source_and_landing <- google_analytics(my_ga_id, 
                                       max = -1,
                            date_range = c("2020-03-01", "2020-08-18"),
                            dimensions = c("date",
                                           "source",
                                           "landingPagePath",
                                           "exitPagePath"
                                           ),
                            metrics = c("sessions",
                                        "users",
                                        "timeOnPage",
                                        "goal13Completions", 
                                        "goal17Completions"
                                        )
                            )

exit_pages <- google_analytics(my_ga_id, 
                              max = -1,
                              date_range = c("2020-03-01", "2020-08-18"),
                              dimensions = c("date",
                                              "exitPagePath"
                              ),
                              metrics = c("sessions",
                                          "users",
                                          "timeOnPage",
                                          "goal13Completions", 
                                          "goal17Completions"
                                          )
)
  
#good to go
goal_data <- google_analytics(my_ga_id,
                              max = -1,
                              date_range = c("2020-03-01", "2020-08-18"),
                              dimensions = c("date" 
                                            ,"goalPreviousStep1"),
                              metrics = c("goal13Completions" 
                                         ,"goal17Completions"
                                        )
                            )

write_csv(source_and_landing, "raw_data/source_and_landing.csv")
write_csv(exit_pages, "raw_data/exit_pages.csv")
write_csv(goal_data, "raw_data/goal_data.csv")

# View(source_and_landing)
# View(exit_pages)
# View(goal_data)


