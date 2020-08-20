ui <- fluidPage(
  titlePanel("Events Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("dates",
                     label = "Date Range"
                     ),
      radioButtons("course",
                   label = "Select Course",
                     choices = c("Data Analysis" = "goal13completions",
                                 "Software Development" = "goal17completions"),
                   selected = "goal13completions")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Source",
                 plotOutput("source_sessions_plot"),
                 plotOutput("source_courses_plot")
                 ),
        
        
        
        tabPanel("Landing"),
        tabPanel("Previous to Goal",
                 plotOutput("prev_g13_plot"),
                 plotOutput("prev_g17_plot"),
                 ),
        
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

