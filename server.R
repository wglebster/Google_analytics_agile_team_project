#server.R
server <- function(input, output){

  clean_landing_data_filtered <- reactive({
    landing_category_col %>%
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
  
  output$landing_cat_v_total_sessions <- renderPlot ({
    ggplot(clean_landing_data_filtered()) + 
      aes(x = landing_category, y = sessions) +
      labs(x = "Landing Page Primary Category",
           y = "Total Number of Sessions",
           title = "\nTotal Number of Session by Primary Location Category") +
      geom_col() +
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
  })
  
  output$top_10_other <- renderDataTable({
    clean_landing_data_filtered() %>%
      filter(landing_category == "other") %>%
      group_by(landing_page_path) %>%
      summarise(total_sessions = sum(sessions)) %>%
      arrange(desc(total_sessions)) %>%
      head(100)
  })
  
  output$conversion_rate <- renderDataTable({
    clean_landing_data_filtered() %>%
      group_by(landing_category) %>%
      summarise(total_sessions = sum(sessions), DA_goal = sum(goal13completions), PSD_goal = sum(goal17completions)) %>%
      mutate(DA_con_rate = round((DA_goal/total_sessions) * 100, digits = 2), 
             PSD_con_rate = round((PSD_goal/total_sessions) * 100, digits = 2)) %>% 
      arrange(desc(DA_con_rate)) %>%
      head(10)
  })
  
  output$top_10_other_text <- renderText(c("Having explored the top URL branches for landing pages we will have a quick look at the other landing pages that contain are contained within the 'other' grouping."))
  
  output$conversion_rate_text <- renderText(c("Now let's look at the conversion rate, comparing the landing pages against the desired goal (Data Analytics and Software Development Goals)"))
  
  
  clean_source_data_filtered <- reactive({
    clean_source_data %>%
      filter(date <= input$dates)
  })
 
  
  exit_pages_and_goals_data <- reactive({
    #browser()

      bind_rows(exit_pages, goals_data) %>%
      mutate(month = month(date, label = TRUE)) %>%
      filter(between(date, 
                     input$dates[1],
                     input$dates[2])) %>%
      #filter(exitPagePath == "/events/") %>%
      pivot_longer(c(6,7),
                   names_to = "course",
                   values_to = "completions_count") %>%
      mutate(course = ifelse(course == "goal13Completions", 
                             "Data Analysis",
                             "Software Development")) %>%
      mutate(month = month(date, label = TRUE)) %>%
      filter(between(date, 
                     input$dates[1],
                     input$dates[2]))
  })
  
  output$event_booking_chart <- renderPlot({
    exit_pages_and_goals_data() %>%
      group_by(month, course) %>%
      summarise(completions_count = sum(completions_count)) %>%
    ggplot() +
      aes(x = month, 
          y = completions_count,
          fill = course) +
      geom_bar(position = "dodge", stat = "identity")+
      labs(title = "Event bookings by month",
           x = "Month",
           y = "Number of bookings") +
      theme(legend.position = c(0.09,0.9))
  })
  output$top10_session_terminated <- renderPlot({
    exit_pages_and_goals_data() %>%
      group_by(exitPagePath) %>%
      summarise(terminated_sessions = sum(sessions)) %>%
      arrange(desc(terminated_sessions)) %>%
      mutate(exitPagePath = fct_reorder(exitPagePath, terminated_sessions)) %>%
      head(10) %>%
      ggplot() +
      aes(x = exitPagePath,
          y = terminated_sessions) +
      geom_bar(stat = "identity") +
      coord_flip() +
      labs(title = "Top 10 pages where session was terminated",
           x = "Page URL",
           y = "Number of terminated sessions")
  })

}
  

  
  
