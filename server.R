#server.R
server <- function(input, output){
  
  clean_landing_data <- reactive({
    clean_landing_data %>%
      filter(date <= input$dates)
  })
  
  output$landing_sessions_plot <- renderPlot ({
    ggplot(landing_category_col()) + 
      aes(x = landing_category, y = sessions, fill = landing_category) +
      labs(x = "Landing Page Primary Category",
           y = "Total Number of Sessions",
           title = "\nTotal Number of Session by Primary Location Category") +
      geom_col() +
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
  })
  
  output$landing_category_col <- renderTable({
    filter(landing_category == "other") %>% 
      group_by(landing_page_path) %>% 
      summarise(total_sessions = sum(sessions)) %>% 
      arrange(desc(total_sessions)) %>% 
      slice(1:10)
  })
  
  output$landing_category_col
    }
  
