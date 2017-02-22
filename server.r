library(shiny)
library(plotly)
library(SimulationValues)


## Download handler
downloadSample <- function(filename, data) {
  downloadHandler(
    filename = function() {
      paste(filename, '.csv', sep='')
    },
    content = function(file) {
      write.csv(data, file)
    }
  )
}

function(session, input, output) {
  observe({
    if(input$search != search_state){
        if (input$caption == "")  {
          foo <- eval(parse(text = paste("sim_values(n = input$sampleSize,dist = input$dist)")))
          xx <- data.frame(values = foo)
          }
        else {
          if ((length(grep(pattern = ".=\\s*[0-9]+$", input$caption)))) {
            foo <- eval(parse(text = paste("sim_values(n = input$sampleSize,dist = input$dist,",input$caption,")")))
            xx <- data.frame(values = foo)
          }
        }

  output$trendPlot <- renderPlotly({
    # if ((length(grep(pattern = ".=\\s*[0-9]+$", input$caption))) == 0 || input$caption != "") {
    #   output$trendPlot <- renderPlotly(ggplot() + ggtitle("Invalid Additional Input. Please correct this."))
    # }
    # else {
    m <- ggplot(xx, aes(x=values)) + geom_histogram(aes(fill = ..count..), bins = 30)

    ggplotly(m)
   # }
  })
  output$downloadData <- downloadSample(filename = "dataSample", data = xx)
  search_state <<-input$search
    }
    else {
      output$trendPlot <- renderPlotly(ggplot() + ggtitle("No data available"))
    }
  })

}
