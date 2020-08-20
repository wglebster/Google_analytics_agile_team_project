#server.R
server <- function(input, output){
  
  clean_source_data_filtered <- reactive({
    clean_source_data %>%
      filter(date <= input$dates)
  })
  
  clean_goal13_prev_data_filtered <- reactive({
    clean_goal_prev_data %>%
      filter(date <= input$dates) %>% 
      filter(goal13completions > 0) %>% 
      group_by(goal_previous_step1) %>% 
      summarise(count = n()) %>%
      arrange(desc(count)) %>% 
      head(10)
  })
  
  clean_goal17_prev_data_filtered <- reactive({
    clean_goal_prev_data %>%
      filter(date <= input$dates) %>% 
      filter(goal17completions > 0) %>% 
      group_by(goal_previous_step1) %>% 
      summarise(count = n()) %>%
      arrange(desc(count)) %>% 
      head(10)
  })

  output$source_sessions_plot <- renderPlot({
    ggplot(clean_source_data_filtered()) +
      aes(x= source, y = sessions) +
      geom_bar(stat="identity",
               aes(fill = source)) +
      labs(y = "Sessions",
           x = "Source",
           title = "Source Types by Number of Sessions") +
      + 
      theme(legend.position = "none")
      
  })
  
  output$source_courses_plot <- renderPlot({
    ggplot(clean_source_data_filtered()) +
      aes_string(x = "source", y = input$course, fill = "source")+
      geom_bar(stat="identity") +
      labs(y = "Goal Completions", x = "Source",
           title = "Source Types by Number of Goal Completions"
           ) + theme(legend.position = "none")
  })
  
  output$source_sessions_plot <- renderPlot({
    ggplot(clean_source_data_filtered()) +
      aes(x= source, y = sessions) +
      geom_bar(stat="identity",
               aes(fill = source)) +
      labs(y = "Sessions",
           x = "Source",
           title = "Source Types by Number of Sessions") +
    theme(legend.position = "none")
  
  })
  
  output$prev_g13_plot <- renderPlot({
    ggplot(clean_goal13_prev_data_filtered()) +
      aes(x= goal_previous_step1, y = count) +
      geom_bar(stat="identity", aes(fill = goal_previous_step1))+
      coord_flip()+
      theme(legend.position = "none")+
      labs(y = "Number of Goal Completions",
           x = "Page previous to Goal Completion",
           subtitle = "Top 10 Pages Previous to Goal Completion by Number of Completions",
           title = "Data Analysis")
      
  })
  
  
  output$prev_g17_plot <- renderPlot({
    ggplot(clean_goal17_prev_data_filtered()) +
      aes(x= goal_previous_step1, y = count) +
      geom_bar(stat="identity", aes(fill = goal_previous_step1))+
      coord_flip() +
      theme(legend.position = "none")+
      labs(y = "Number of Goal Completions",
           x = "Page previous to Goal Completion",
           subtitle = "Top 10 Pages Previous to Goal Completion by Number of Completions",
           title = "Software Development")
    
  })
  
}
  
