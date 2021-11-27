library(shiny)
library(ggplot2)
library(mvtnorm)

##############################################################################
##############################################################################

ui <- fluidPage(
    titlePanel("Plot reactiva"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("n",
                        label="Tamaño de la muestra",
                        min = 2,
                        max = 500,
                        value = 30),
            
            sliderInput("corr",
                        label = "Correlación",
                        min = -1,
                        max = 1, 
                        value = 0,
                        step = 0.05),
            actionButton("generate", label = "Generar"),
            actionButton("add", label = "Añadir un punto"),
            
        ),
        mainPanel(
          plotOutput("dist", click = "addclick")
        )
    )
)

##############################################################################
##############################################################################

server <- function(input, output) {
  
  miscosicas <- reactiveValues()
  
  observeEvent(input$generate, {
    sigma <- matrix(c(1, input$corr, input$corr, 1), nrow = 2)
    miscosicas$df <- data.frame(rmvnorm(input$n, sigma = sigma, method = "chol" ))
  })
  
  observeEvent(input$add, {
    miscosicas$df <- rbind(miscosicas$df, runif(2, min = -2, max = 2))
    
  })
  
  observeEvent(input$addclick, {
    miscosicas$df <- rbind(miscosicas$df, c(input$addclick$x, input$addclick$y))
  })
  
  output$dist <- renderPlot({
    req(miscosicas$df)
    ggplot(miscosicas$df) + geom_point(aes(x=X1, y=X2))
    
  })
}

shinyApp(ui = ui, server = server)
