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
library(ggcorrplot)
library(shinythemes)
data("Cereal")
corr = cor(Cereal[,2:4])
infoPanel<- tabPanel(title = "About this Shiny",
                     mainPanel(p("In this shiny app we will present the data of the data set Cereal.
                                 This data set contains four variables: the brand of the Cereal, 
                                 the calories per serving, grams of sugar per serving and grams of fiber per serving.
                                 We will be able to explore the data by selecting one or more brands and see their characteristics, 
                                 as well as see the data graphically.")))
                     
dataPanel <- tabPanel("Data",
                      selectInput(
                          inputId = "selCereal",
                          label = "Select the type of Cereal",
                          multiple = TRUE,
                          choices = Cereal %>% select(Cereal) %>% unique %>% arrange
                      ),
                      tableOutput("data")
)
plotPanel <- tabPanel("Plot",
                      plotOutput("plot")
)


# Define UI for application that draws a histogram
ui <- navbarPage("shiny App",
                 theme = shinytheme("united"),
                 infoPanel,
                 dataPanel,
                 plotPanel
)


# Define server logic required to draw a histogram
server <- function(input, output) { 
    output$data <- renderTable(Cereal %>% filter(Cereal %in% input$selCereal))
    
}

# Run the application 
shinyApp(ui = ui, server = server)
