ui <- fluidPage(tags$div(class="header",
                        img(src = "cropped-CodeClan-Logo-White-2019-01-1.png")),
                        theme = "styles.css",
  titlePanel("Events Dashboard"),
  
  sidebarLayout(
    sidebarPanel(width = 3, 
      dateRangeInput("dates",
                     label = "Date Range",
                     min = min(source_and_landing$date),
                     max = max(source_and_landing$date),
                     start = min(source_and_landing$date),
                     end = max(source_and_landing$date)
                     ),
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Source",
                 radioButtons("course",
                              label = "Select Course",
                              choices = list("Data Analysis", "Software Development"),
                              selected = "Data Analysis",
                              inline = TRUE)),
        tabPanel("Landing"),
        tabPanel("Previous to Goal"),
        tabPanel("Drop off/Exit",
                 plotOutput("event_booking_chart"),
                 plotOutput("top10_session_terminated")
                 )
      )
    )
    
    
  )
)

