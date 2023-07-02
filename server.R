shinyServer(function(input, output) {
  output$plotversus <- renderPlotly({
    options(scipen = 999)
    plot1 <- film %>%
      filter(year == input$year1) %>%
      ggplot(aes(
        x = imdb_rating,
        y = worldwide_gross,
        text = glue("{title}\nStudio: {studio}\nRank: {rank_in_year}\nRating: {rating}\nWorldwide Grossing: ${format(worldwide_gross, digits = 3, big.mark = ',')}")
      )) +
      geom_point(aes(size = -rank_in_year, col = rank_in_year)) +
      scale_y_continuous(labels = dollar_format(suffix = "", accuracy = 10)) +
      labs(title = "Ranks vs Rating", x = "IMDB Rating", y = "Worldwide Gross") +
      theme(legend.position = "none")
    ggplotly(plot1, tooltip = "text")
  })
  
  output$movietitle <- renderInfoBox({
    valueBox(
      "MOVIE TITLE",
      subtitle = (strong("Titles of movies inside the plot")),
      icon = icon("film"),
      color = "purple"
    )
  })
  
  output$revenue <- renderInfoBox({
    valueBox(
      "REVENUE",
      subtitle = (strong("Revenue based on worldwide")),
      icon = icon("dollar-sign"),
      color = "purple"
    )
  })
  
  output$imdbrating <- renderInfoBox({
    valueBox(
      "IMDB RATING",
      subtitle = (strong("Ratings given consumers based on their satisfaction")),
      icon = icon("smile"),
      color = "purple"
    )
  })
  
  output$topmovie <- renderInfoBox({
    valueBox(
      "TOP MOVIE",
      subtitle = h4(strong("Avatar")),
      icon = icon("film"),
      color = "purple"
    )
  })
  
  output$toprevenue <- renderInfoBox({
    valueBox(
      "TOP REVENUE",
      subtitle = h4(strong("$ 2,749,064,328")),
      icon = icon("dollar-sign"),
      color = "purple"
    )
  })
  
  output$topyear <- renderInfoBox({
    valueBox(
      "YEAR",
      subtitle = h4(strong("2009")),
      icon = icon("calendar"),
      color = "purple"
    )
  })
  
  output$growth <- renderPlotly({
    forplot2 <- film %>%
      filter(rank_in_year == "1")
    forplot2 <- forplot2 %>%
      mutate(year = as.numeric(year))
    plot2 <- forplot2 %>%
      filter(year <= input$slideryear) %>%
      ggplot(aes(
        x = year,
        y = worldwide_gross,
        group = 1,
        text = glue("{title}\nStudio: {studio}\nYear: {year}\nRank: {rank_in_year}\nRating: {rating}\nWorldwide Grossing: ${format(worldwide_gross, digits = 3, big.mark = ',')}")
      )) +
      geom_line() +
      geom_point(aes(col = worldwide_gross)) +
      scale_color_gradient(low = "#2e0000", high = "#db0209") +
      scale_y_continuous(labels = dollar_format(suffix = "", accuracy = 10)) +
      labs(title = "Revenue Flow", x = "Year", y = "Revenue") +
      theme(legend.position = "none")
    ggplotly(plot2, tooltip = "text")
  })
  
  output$dataframe <- renderDataTable({
    filmdisp <- film
    filmdisp$worldwide_gross <- paste("$", filmdisp$worldwide_gross, sep = " ")
    filmdisp$worldwide_gross <- prettyNum(filmdisp$worldwide_gross, big.mark = ",", scientific = FALSE)
    datatable(filmdisp)
  })
})
