# SEGUNDO SHINNY: Usando dos ficheros. Este es server y el otro es ui. 

library(shiny)
library(ggplot2)

# una vez que metemos el input varx ya deberia cambiar algo. Lo que hacemos con 
# paste es concatenar, y en un output usamos dos inputs del usuario. Ahí no hay
# limite de lo que podamos hacer dentro del rendertext o el renderplot. 

# hacemos otro output. Hacemos la grafica en ggplot en la consola para no 
# cagarla. 

# Por ultimo añadimos un checkbox que seleccione fabricante

shinyServer(
  function(input, output){
    
    output$subtitle <- renderText({
      paste("Este es un gráfico entre la variable", input$varx,
            "y la variable", input$vary)
    })
    
    output$graph <- renderPlot({
      
      if (input$facet) {
      ggplot(mpg) + geom_point(aes_string(x=input$varx, y=input$vary)) +
        facet_wrap(~manufacturer)
      } else {
        ggplot(mpg) + geom_point(aes_string(x = input$varx, y = input$vary))
      }
      
    })
  }
)


