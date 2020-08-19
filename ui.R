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
                     ),

      radioButtons("course",
                   label = "Select Course",
                   choices = list("Data Analysis", "Software Development"),
                   selected = "Data Analysis")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Source"),
        tabPanel("Landing"),
        tabPanel("Previous to Goal"),
        tabPanel("Drop off/Exit",
                 plotOutput("event_booking_chart"),
                 plotOutput("top_10_before_event_booking"),
                 plotOutput("top10_session_terminated")
                 )
      )
    )
    
    
  )
)

