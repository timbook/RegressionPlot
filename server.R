library(shiny)
library(ggplot2)

function(input, output) {
  
  xy = reactiveValues(
    x = NULL,
    y = NULL
  )
  
  observeEvent(input$plot_click, {
    if(input$plot_click$x >= 0 & input$plot_click$x <= 10 &
       input$plot_click$y >= 0 & input$plot_click$y <= 10){
      xy$x = c(xy$x, input$plot_click$x)
      xy$y = c(xy$y, input$plot_click$y)
    }
  })
  
  observeEvent(input$reset_button, {
    xy$x = NULL
    xy$y = NULL
  })
  
  
  output$plot1 <- renderPlot({
    if(length(xy$x) < 1){
      df_points = data.frame(x = -1, y = -1)
      df_lin = data.frame(x_lin = c(-2, -1),
                          y_lin = c(-2, -1))
    }
    else{
      m = lm(xy$y ~ xy$x)
      b0 = coef(m)[1]
      b1 = coef(m)[2]
      x_lin = seq(0, 10, 0.01)
      y_lin = b0 + x_lin * b1
      df_points = data.frame(x = xy$x, y = xy$y)
      df_lin = data.frame(x_lin = x_lin, y_lin = y_lin)
    }
    ggplot(df_points, aes(x, y)) + 
      geom_point(size = 2) + 
      geom_line(data = df_lin, aes(x_lin, y_lin), color = "red", size = 1.5) +
      theme_bw() + 
      xlab(NULL) + 
      ylab(NULL) +
      xlim(0,10) + 
      ylim(0,10)
  })
  
  output$line_text <- renderText({
    if(length(xy$x) < 2){
      "Please enter more points!"
    }
    else{
      m = lm(xy$y ~ xy$x)
      b0 = coef(m)[1]
      b1 = coef(m)[2]
      paste0("y = ", round(b0,2), " + ", round(b1,2), "x")
    }
  })
  
  output$corr_text <- renderText({
    if(length(xy$x) < 2){
      "Please enter more points!"
    }
    else{
      cor(xy$x, xy$y) 
    }
  })
  
  output$my_data_table <- renderTable(data.frame(x = xy$x, y = xy$y))
  
  output$save_button <- downloadHandler(
    function() "my_data.csv",
    function(file) write.csv(data.frame(x = xy$x, y = xy$y), "my_data.csv", row.names = FALSE)
  )
  
}