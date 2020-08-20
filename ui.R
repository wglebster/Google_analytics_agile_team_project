ui <- fluidPage(
  titlePanel("Events Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("dates",
                     label = "Date Range"
                     ),
      radioButtons("course",
                   label = "Select",
                   choices = list("Data Analysis", "Software Development"),
                   selected = "Data Analysis")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Source"),
        tabPanel("Landing"),
                  plotOutput("landing_cat_v_total_sessions"),
                  DT::dataTableOutput("top_10_other"),
                  DT::dataTableOutput("conversion_rate"),
                  
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

