#server.R
server <- function(input, output){
  clean_source_data <- reactive({
    clean_source_data %>%
      filter(date <= input$date)
  })
  output$medal_plot <- renderPlot({
    
    source_sessions_plot(input$date)
    
  })
    }
  
