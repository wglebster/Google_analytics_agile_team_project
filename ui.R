ui <- fluidPage(
  titlePanel("Events Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("dates",
                     label = "Date Range",
                     min = min(source_and_landing$date),
                     max = max(source_and_landing$date),
                     start = min(source_and_landing$date),
                     end = max(source_and_landing$date)
                     )),
      
  
    mainPanel(
      tabsetPanel(
        tabPanel("Source",
                 plotOutput("source_sessions_plot"),
                 plotOutput("source_courses_plot")
                 ),
        
        tabPanel("Landing", plotOutput("landing_cat_v_total_sessions"), 
                 br(), textOutput("top_10_other_text"), br(),
                 dataTableOutput("top_10_other"),
                 br(), textOutput("conversion_rate_text"), br(),
                 dataTableOutput("conversion_rate")),

        tabPanel("Previous to Goal"),
        
        tabPanel("Drop off/Exit",
                 plotOutput("event_booking_chart")
                 )
      )
    )
    
    
  )
)

