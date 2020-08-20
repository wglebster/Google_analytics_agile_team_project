ui <- fluidPage(tags$div(class="header",
                        img(src = "cropped-CodeClan-Logo-White-2019-01-1.png")),
                        theme = "styles.css",
  titlePanel("Events Dashboard"),
  
  sidebarLayout(
    sidebarPanel(width = 3, 
      dateRangeInput("dates",
                     "Date Range",
                     min = min(source_and_landing$date),
                     max = max(source_and_landing$date),
                     start = min(source_and_landing$date),
                     end = max(source_and_landing$date)),
      ),

    mainPanel(
      tabsetPanel(
        tabPanel("Source", 
                 br(),
                 plotOutput("source_sessions_plot"),
                 br(),
                 radioButtons("course",
                              label = "Select Course",
                              choices = c("Data Analysis" = "goal13completions",
                                          "Software Development" = "goal17completions"),
                              selected = "goal13completions"), 
                 br(),
                 plotOutput("source_courses_plot")),
      
      tabPanel("Landing", br(),
               plotOutput("landing_cat_v_total_sessions"), 
                 br(),
                 textOutput("top_10_other_text"), 
                br(),
                 dataTableOutput("top_10_other"),
                 br(), 
                 textOutput("conversion_rate_text"),
                 br(),
                 dataTableOutput("conversion_rate")
               ),
        
        tabPanel("Previous to Goal",
                 br(),
                 plotOutput("prev_g13_plot"),
                 br(),
                 plotOutput("prev_g17_plot"),
                 ),
        
      tabPanel("Drop off/Exit",
               br(),
               plotOutput("event_booking_chart"),
               br(),
               plotOutput("top10_session_terminated")
              )

                 )
      )
    )

)




