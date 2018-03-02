library(shiny)
library(shinythemes)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
    theme = shinytheme("superhero"),
    titlePanel("Word Predictions"),
    
    sidebarLayout(
    sidebarPanel(
        textInput("userInput",label=NULL,placeholder="Put text here"),
        p(),
        h3("Background"),
        p("The data analyzed here come from three sources, are sampled, and stats...")
        ),
    
    mainPanel(
        tags$style(type="text/css",
                   ".shiny-output-error { visibility: hidden; }",
                   ".shiny-output-error:before { visibility: hidden; }"),
        h3("Single Word Prediction:"),
        fluidRow(
            column(width=6, textOutput("word"))
        ),
        h3("Multiple Word Choices:"),
        fluidRow(
            column(width=6, tableOutput("words"))
            )
        )
    )
    )
)
