# Cargamos las librerías necesarias para este shiny:

library(shiny)
library(ggplot2)
library(dplyr)

##############################################################################

# Creamos la lista de variables que irán al input:

variables <- list("Fabricante" = "manufacturer",
                  "Clase" = "class",
                  "Transmisión" = "trans")

# El padre fluidPage con sus hijos titlePanel y sidebarLayout. Dentro de este
# último vendrán sidebarPanel para la elección de variables y pulsado del 
# botón de eliminar, y el panel principal con nuestra gráfica y el resumen.

ui <- fluidPage(
  titlePanel("Ejercicio 3: reactividad avanzada"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variable",
                  label = "Elige variable",
                  choices = variables, 
                  selected = "Fabricante"),
      
      # uiOutput porque queremos después generar otro, en función de lo que el 
      # usuario seleccione en el selecInput de arriba. Entonces en server 
      # meteremos un renderUi para esto. 
      
      uiOutput("variables"),
      
      # Creación del motón de eliminar subconjuntos:
      
      actionButton("delete",
                   label = "Borrar subconjunto")
    ),
     
    mainPanel(
      plotOutput("plot"),
      verbatimTextOutput("summary"),
    )
  )
  
)

##############################################################################

server <- function(input, output) {
  
  # En primar lugar usamos la función Switch. Creamos un reactive para indicar
  # que, al seleccionar la varibale manufacturer, despliegue los valores de la
  # columna manufacturer de la tabla mpg, y lo mismo con class y trans:
  
  variables2 <- reactive({
    
    switch(input$variable, 
           'manufacturer' = unique(mpg$manufacturer),
           'class' = unique(mpg$class),
           'trans' = unique(mpg$trans))
  
  })
  
  # Creamos un input con renderUI para añadir en otro box donde el usuario puede 
  # seleccionar una variable, con lo especificado en el reactive anterior. Lo 
  # que he comentado arriba en el ui, al crear el uiOutput.
  
  output$variables <- renderUI({
    
    selectInput('category',
                label = 'Elige un valor para eliminar',
                choices = variables2())
  })
  
  # Creamos una lista miplot que es donde vamos a guardar las observaciones.
  # Le asignamos el valor del df mpg, y después añadimos un observador:
  
  miplot <- reactiveValues()
  miplot$df <- mpg
  
  # Este observador, va a hacer algo cada vez que el usuario pulse delete. 
  # Lo que va a hacer es, transformar nuestro df. Se va a quedar con las 
  # variables que sean distintas a las que el usuario a pulsado.
  
  observeEvent(input$delete, {
    miplot$df <- miplot$df[miplot$df[ , input$variable] != input$category, ]
  })
  
  # ggplot para crear nuestra gráfica, donde le pasamos nuestra lista a la 
  # que el observador va a ir afectando miplot$df.
  
  output$plot <- renderPlot({
    ggplot(miplot$df) + geom_point(aes(x=displ, y=cty, color=manufacturer))
  })
  
  # Por último, queremos que aparezca un summary con lo que el usuario está 
  # viendo en pantalla. Así, con renderPrint y nuestro container de antes 
  # miplot$f, puesto que renderprint básicamente devuelve de forma directa el 
  # resultado que aparece en consola. 
  
  output$summary <- renderPrint({
    summary(miplot$df)
  })
}

  # Línea de código para que la aplicación corra:

shinyApp(ui = ui, server = server)