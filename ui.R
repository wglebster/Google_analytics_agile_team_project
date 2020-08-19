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
      #Gleb added checkbox Input instead of radio buttons
      # checkboxGroupInput("course",
      #                    label = "Select Course",
      #                    list("Data Analysis", "Software Development"),
      #                    selected = "Data Analysis")
      #),
      radioButtons("course",
                   label = "Select Course",
                     choices = c("goal13completions",
                                 "goal17completions"),
                   selected = "goal13completions")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Source",
                 plotOutput("source_sessions_plot"),
                 plotOutput("source_courses_plot")
                 ),
        
        
        
        tabPanel("Landing"),
        tabPanel("Previous to Goal"),
        tabPanel("Drop off/Exit",
                 # ,
                 # radioButtons("goal_or_not",
                 #              label = "Select",
                 #              choices = list("Event clicked", "Event NOT clicked"),
                 #              selected = "Event clicked",
                 #              inline = TRUE)
                 plotOutput("event_booking_chart")
                 )
      )
    )
    
    
  )
)

