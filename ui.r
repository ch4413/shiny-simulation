library(shiny)
library(plotly)
library(markdown)
library(SimulationValues)

search_state <<- 0

navbarPage( theme = "bootstrap.css",
  title = "Simulation Values",
  tabPanel("View",
fluidPage(

  headerPanel("SimulatedValues in Action"),
  sidebarPanel(
    sliderInput('sampleSize', 'Sample Size', min = 1, max = 10000,
                value = 1000, step = 500, round = 0),
    selectInput("dist", "Distribution:",
                choices=c("Normal", "Poisson", "Binomial")),
    hr(),
    textInput("caption", "Additional Inputs", ""),
    hr(),
    includeMarkdown("substantReport.md")
  ),
  mainPanel(
    plotlyOutput('trendPlot'),
    actionButton("search", label = "Go"),
    downloadButton('downloadData', 'Download')
  )
)
)
)
