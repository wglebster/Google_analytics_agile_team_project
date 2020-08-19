#server.R
server <- function(input, output){
  ################Gleb's code############
  
  exit_pages_and_goals_data <- reactive({
    #browser()
     bind_rows(exit_pages, goals_data) %>%
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
      theme(legend.position = c(0.13,0.9))
  })
  output$top10_session_terminated <- renderPlot({
    exit_pages_and_goals_data() %>%
      group_by(exitPagePath) %>%
      summarise(terminated_sessions = sum(sessions)) %>%
      arrange(desc(terminated_sessions)) %>%
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
  output$top_10_before_event_booking <- renderPlot({
    exit_pages_and_goals_data() %>%
      group_by(goalPreviousStep1) %>%
      summarise(completions_count = sum(completions_count)) %>%
      arrange(desc(completions_count)) %>%
      head(10) %>%
      ggplot() +
      aes(x = goalPreviousStep1,
          y = completions_count) +
      geom_bar(stat = "identity")+
      coord_flip()+
      labs(title = "Top 10 visited pages before an Event booking",
           x = "Page URL",
           y = "Number of Event bookings")
  })
  
  ################End Gleb's code############
  
}
  
