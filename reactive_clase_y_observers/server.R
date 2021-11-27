library(shiny)

shinyServer(function(input, output) {
  
  observeEvent(input$calc, {
    print("Prioridad 0")
    showNotification("Has calculado una nueva distribución")
  }, priority=0)
  
  observeEvent(input$calc, {
    print("Prioridad 1")
    showNotification("Has calculado una nueva distribución")
  }, priority=1)
  
  x <- eventReactive(input$calc, {
    rnorm(input$n, mean=input$mean, sd=input$sd)
  })
  
  output$hist <- renderPlot({
    hist(x())
  })
  
  # renderPrint es un tipo de renderText
  # que devuelve de forma directa el resultado
  # que aparece en consola
  output$summary <- renderPrint({
    summary(x())
  })
})






