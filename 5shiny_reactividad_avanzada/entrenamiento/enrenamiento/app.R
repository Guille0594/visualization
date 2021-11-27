library(shiny)
library(tidyverse)

###############################################################################

ui <- fluidPage(
  titlePanel("Klustering Iris"),
  sidebarLayout(
    sidebarPanel(
      
      selectInput("specie", label = "Select the species",choices = variables),
      
      selectInput("petal", label = "Select Petal in X", choices = variables2),
      
      selectInput("sepal", label = "Select Sepal in Y", choices = variables3),
    ),
    mainPanel(
      plotOutput("cluster"),
      verbatimTextOutput("summary")
      
    )
  )
)
###############################################################################

server <- function(input, output) {
  
  output$cluster <- renderPlot({
    ggplot(iris) + geom_point(aes(x=input$petal, y=input$sepal, color=Species))
  })
}

###############################################################################

shinyApp(ui = ui, server = server)

###############################################################################

variables <- list("Setosa" = "Setosa",
                  "Versicolor" = "Versicolor",
                  "Virginica" = "Virginica") 

variables2 <- list("Petal Length" = iris$Petal.Length,
                   "Petal Width" = iris$Petal.Width)

variables3 <- list("Sepal Length" = iris$Sepal.Length,
                   "Sepal Width" = iris$Sepal.Width)
