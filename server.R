#server.R
server <- function(input, output){
  
  clean_landing_data_filtered <- reactive({
    browser()
    clean_landing_data %>%
      filter(date <= input$dates)
  })
  
  output$landing_cat_v_total_sessions <- renderPlot ({
    filter(input$dates) %>%
    ggplot(clean_landing_data_filtered()) + 
      aes(x = landing_category, y = sessions, fill = landing_category) +
      labs(x = "Landing Page Primary Category",
           y = "Total Number of Sessions",
           title = "\nTotal Number of Session by Primary Location Category") +
      geom_col() +
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
  })
  
  output$top_10_other <- renderTable({
    filter(input$dates) %>%
    filter(landing_category == "other") %>% 
      group_by(landing_page_path) %>% 
      summarise(total_sessions = sum(sessions)) %>% 
      arrange(desc(total_sessions)) %>% 
      head(10)
  })
  
  output$conversion_rate <- renderTable({
    filter(between(date, 
                   input$dates[1],
                   input$dates[2])) %>%
    group_by(landing_category) %>% 
      summarise(total_sessions = sum(sessions), goal_13_total = sum(goal13completions), goal_17_total = sum(goal17completions)) %>% 
      mutate(goal_13_cr = round((goal_13_total/total_sessions) * 100, digits = 2), goal_17_cr = round((goal_17_total/total_sessions) * 100, digits = 2))
  })
    }
  
