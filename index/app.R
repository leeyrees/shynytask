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
require("shinyjs")
data("Cereal")

infoPanel<- tabPanel(title = "About this Shiny",
                     mainPanel(p("In this shiny app we will present the data of the data set Cereal.
                                 This data set contains four variables: the brand of the Cereal, 
                                 the calories per serving, grams of sugar per serving and grams of fiber per serving.
                                 We will be able to explore the data by selecting one or more brands and see their characteristics, 
                                 as well as see the data graphically.")))
                     
dataPanel <- tabPanel("Data",fluidPage( sidebarLayout(sidebarPanel(
                      selectInput(
                          inputId = "selCereal",
                          label = "Select the type of Cereal",
                          multiple = TRUE,
                          choices = Cereal %>% select(Cereal) %>% unique %>% arrange,
                          selected = 0
                      )),
                      mainPanel(
                          p("Here we can select what brands of cereals we want to see."),
                          tableOutput("data")
                          )),
                      
))
plotPanel <- tabPanel("Histogram",
                      sidebarLayout(position = "right",
                                sidebarPanel(
                                selectInput("var", label = h3("Select the variable"), 
                                    choices = c("Calories","Sugar","Fiber"),
                                                    selected = 1),
                                        sliderInput("n_bins", label = h3("Number of bins"), min = 1, 
                                                    max = 20, value = 5)
                                    ), # sidebarPanel
                                    mainPanel(
                                        p("In this histogram, we can select one out of the three continous variables
                                          and plot it in a histogram, being able to select the number of bins as well."),
                                        plotOutput(outputId = "plot")
                                    ) # mainPanel
                      ) # sidebarLayout
) #  tabPanel

plot2Panel <- tabPanel("Scatterplot",
                      sidebarLayout(position = "right",
                                    sidebarPanel(
                                        selectInput("var1", label = h3("Select the first variable"), 
                                                    choices = c("Calories","Sugar","Fiber"),
                                                    selected = "Calories"),
                                        selectInput("var2", label = h3("Select the second variable"), 
                                                    choices = c("Calories","Sugar","Fiber"),
                                                    selected = "Sugar")
                    
                                    ), # sidebarPanel
                                    mainPanel(
                                        p("In this section we can select two variables in order to visualize the relation among them."),
                                        plotOutput(outputId = "plot2")
                                    ) # mainPanel
                      ) # sidebarLayout
) #  tabPanel                  



# Define UI for application that draws a histogram
ui <- navbarPage("shiny App",
                 theme = shinytheme("united"),
                 infoPanel,
                 dataPanel,
                 plotPanel,
                 plot2Panel
)


# Define server logic required to draw a histogram
server <- function(input, output) { 
    output$data <- renderTable(Cereal %>% filter(Cereal %in% input$selCereal))
    output$plot = renderPlot({
        ggplot(data = Cereal, aes_string(x = input$var)) +
            geom_histogram(bins = input$n_bins, fill = "mediumturquoise", color="grey97") +
            theme_bw()
    })
    output$plot2 = renderPlot({
        ggplot(data = Cereal, aes_string(x = input$var1, y = input$var2)) +
        geom_point(shape=18, color="mediumturquoise", size = 3) + theme_bw() 
            
        
    })
}


# Run the application 
shinyApp(ui = ui, server = server)
