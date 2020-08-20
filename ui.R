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
        tabPanel("Landing", plotOutput("landing_cat_v_total_sessions"), 
                 br(), textOutput("top_10_other_text"), br(),
                            dataTableOutput("top_10_other"),
                 br(), textOutput("conversion_rate_text"), br(),
                            dataTableOutput("conversion_rate")),
                  
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

