library(shiny)

fluidPage(
  titlePanel("Regression Simulator"),
  sidebarLayout(
    sidebarPanel(
      plotOutput("plot1", click = "plot_click"),
      br(),
      "The line of best fit is:",
      br(),
      div(style = "color: blue", strong(textOutput("line_text"))),
      br(),
      "and the correlation is:",
      div(style = "color: blue", strong(textOutput("corr_text"))),
      br(),
      downloadButton("save_button", "Export Data"),
      actionButton("reset_button", "Reset Points"),
      br(),
      br(),
      div(style = "font-size: 12px; color: grey; text-align: right",
          em("Made by Timothy K. Book."),
          br(),
          em("See more applets at timothykbook.wix.com/home")
      )
    ),
    mainPanel(
      tableOutput("my_data_table")
    )
  )
)