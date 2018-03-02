library(shiny)
library(stringr)
library(tidyr)
library(dplyr)
library(tidytext)
library(gsubfn)

shinyServer(function(input, output) {
    chk <- reactive({
        if (input$userInput == "")
            return(NULL)
    })
    
    if (!is.null(chk)) {
    a <- reactive({ findLast(input$userInput) })
    output$word <- renderText({a()})
    
    b <- reactive({ findLastWords(input$userInput) })
    output$words <- renderTable({b()})
    }
  
})
