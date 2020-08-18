ui <- fluidPage(
  titlePanel("Events Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("date",
                     label = "Date Range"
                     ),
      # radioButtons("course",
      #              label = "Select Course",
      #              choices = list("Data Analysis", "Software Development"),
      #              selected = "Data Analysis")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Source",
                 plotOutput("source_sessions_plot")),
        
        
        
        tabPanel("Landing"),
        tabPanel("Previous to Goal"),
        tabPanel("Drop off/Exit",
                 radioButtons("goal_or_not",
                              label = "Select",
                              choices = list("Event clicked", "Event NOT clicked"),
                              selected = "Event clicked",
                              inline = TRUE)
                 )
      )
    )
    
    
  )
)

