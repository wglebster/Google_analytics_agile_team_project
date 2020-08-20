#server.R
server <- function(input, output){
  
  clean_landing_data_filtered <- reactive({
    landing_category_col %>%
      filter(date <= input$dates)
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
    
    }
  
