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
  exit_pages_and_goals_data <- reactive({
    #browser()
    bind_rows(exit_pages, goals_data) %>%
      mutate(month = month(date, label = TRUE)) %>%
      filter(between(date, 
                     input$dates[1],
                     input$dates[2])) %>%
      filter(exitPagePath == "/events/") %>% 
      pivot_longer(c(6,7),
                   names_to = "course",
                   values_to = "completions_count") %>%
      mutate(course = ifelse(course == "goal13Completions", 
                             "Data Analysis", "Software Development")) %>%
      group_by(month, course) %>%
      summarise(completions_count = sum(completions_count))
  })
  output$event_booking_chart <- renderPlot({
    ggplot(exit_pages_and_goals_data()) +
      aes(x = month, 
          y = completions_count,
          fill = course) +
      geom_bar(position = "dodge", stat = "identity")+
      labs(title = "Event bookings by month",
           x = "Number of bookings",
           y = "Month")
  })
  
  
}

    


  
