library(shiny)
library(stringr)
library(tidyr)
library(dplyr)
library(tidytext)
library(gsubfn)
a<-outputChoice("you doing today")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$words <- renderText(a)

  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
