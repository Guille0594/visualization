# Render UI, aquí haremos interfaces dinámicas.
# Hueco para una interfaz se llama uioutput, es un cacho de interfaz
# simplemente rellenamos lo que queramos meter. Empezamos con la normal
# En render ui, hay que hacer interfaz porque en render plot hay que hacer
# una gráfica, asi de simple. 

# Podremos tener varios uioutputs. 

library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("n", label= "Tamañno muestral", min=5, max=500, value= 5),
      selectInput("distribucion", label= "distribucion",
                  choices = list ("Gaussiana" = "norm",
                                  "Uniform"= "unif",
                                  "Poisson" = "pois",
                                  "Gamma" = "gamma"
                  ),
                  selected = "norm"),
      actionButton("mostrar", label = "Mostrar la distribución"),
        # HUECO DE PARAMETROS
      uiOutput("parametros")
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
)


#####################################################################

# Vamos a hacer que sea dinamico el renderui. 

# Las llaves: ese if solo lleva paréntesis porque es una única expresion.
# Si fueran dos expresiones si haría falta
# Si las ponemos no pasaría nada.
# Else if van después de un if. If y else if son una expresión, así que 
# podríamos quitarlos también. Pones las llaves, y ya está. 


# Vamos a guradarnos la distribucion directamente, en vez de la función 
# que genera distribuciones.

# el segundo parametro de rnorm es la media. La media que queremos usar es 
# la que ha introducido el usuario, por eso input$mean. El renderui se 
# inyecta en el sitio que le he marcado antes. 

# Usamos la funcion req. Require, es una especie de control, Si la media está
# sigues, sino, paras. 

# El if, con el req solicito que exista la media y si no existe me detengo. 

server <- function(input, output){
  
  output$hist <- renderPlot({
    input$mostrar
    
    n <- isolate(input$n)
    distribucion <- isolate(input$distribucion)
    
    if (distribucion == "norm"){
      mean <- isolate(input$mean)
      req(mean)
      x <- rnorm(n, mean)
    }
 
    hist(x)
    
  })
  
  output$parametros <- renderUI({
    
    if (input$distribucion == "norm")
      tagList(
      numericInput("mean", 
                 label ="media", 
                 value = 5)
      )
    else if(input$distribucion == "unif")
      numericInput("min",
                   label = "valor minimo",
                   value = 5)
    
      
  })
  
}

shinyApp(ui, server)







