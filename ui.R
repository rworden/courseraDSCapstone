library(shiny)
# Define UI for application that draws a histogram
bootstrapPage(fluidPage(
  
  # Application title
  titlePanel("Word Predictions"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        textInput("userInput","input",placeholder="put text here")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       textOutput("words")
    )
  )
))
