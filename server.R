#server.R
server <- function(input, output){
  
  clean_source_data_filtered <- reactive({
    clean_source_data %>%
      filter(date <= input$dates)
  })

  output$source_sessions_plot <- renderPlot({
    ggplot(clean_source_data_filtered()) +
      aes(x= Source, y = sessions) +
      geom_bar(stat="identity",
               aes(fill = Source)) +
      labs(y = "Sessions",
           x = "Source",
           title = "Source Types by Number of Sessions")
      
  })
  output$source_courses_plot <- renderPlot({
    ggplot(clean_source_data_filtered()) +
      aes_string(x = "Source", y = input$course, fill = "Source")+
      geom_bar(stat="identity") +
      labs(y = "Goal Completions", x = "Source",
           title = "Source Types by Number of Goal Completions"
           )
  })
  
    }
  
