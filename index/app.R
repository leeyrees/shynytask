#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(Stat2Data)
library(tidyverse)
dataPanel <- tabPanel("Data",
                      selectInput(
                          inputId = "selCereal",
                          label = "Select the type of Cereal",
                          multiple = TRUE,
                          choices = Cereal %>% select(Cereal) %>% unique %>% arrange
                      ),
                      tableOutput("data")
)
data("Cereal")

# Define UI for application that draws a histogram
ui <- navbarPage("shiny App",
                 dataPanel
)


# Define server logic required to draw a histogram
server <- function(input, output) { 
    output$data <- renderTable(Cereal %>% filter(Cereal %in% input$selCereal))
}

# Run the application 
shinyApp(ui = ui, server = server)
