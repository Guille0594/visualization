# UI Y SERVER, HOY JUNTOS
# shini ui y server cuando estan separados. App cuando estan juntos con ui
# y server. Luego, a rellenar. Entramos en pagina fluida: nos satamos el panel
# Cuando es un fichero lo guardamos en UI. Ene ste caso queremos que funcione
# pulsando el botón, no solo con slide.

# Selected = "norm" quiere decir que por defecto nos saque norm, aunque no es 
# necesario. 

# El gaussiana = esenombre, no tiene impacto, es para mi como programador 
# acordarme. 

library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("nbins", label= "Tamañno muestral", min=5, max=500, value= 5),
      selectInput("Distribucion", label= "Distribucion",
                     choices = list ("Gaussiana" = "norm",
                                     "Uniform"= "unif",
                                     "Poisson" = "pois",
                                     "Gamma" = "gamma"
                              ),
                     selected = "norm"),
      actionButton("mostrar", label = "Mostrar la distribución")
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
)
 

# Recordar que si no  ponemos la función no va a tirar. Ponerla solo con input
# output primero para ver que va tirando. La parte dificil es rellenar en la 
# funcion el plotoutput. Empezamos haciendo la normal para que sea fácil. En
# R es rnorm. Nbins porque es lo que hemos escrito arriba.

# Hasta ahora los inputs han sido para algo, aquí no tenemos por qué. Aquí
# conectamos mostrar con hist. Shiny dentro del render coge el texto y mira
# los inputs, como solo has puesto mostrar, lo afecta. 

# No queremos que el input n afecte, lo aislamos con isolate: entonces lo que 
# hay dentro lo aisla, lo va a usar, pero no dispara el cambio. Pero sigue
# usando el valor. Tamaño muestral no afecta porque esta en un isolate,
# pero tenemos que dispararlo con el botón.

# coges r distribucion, esi es norm lo guardas en rdistribucion, si es 
# unif lo guardas en r distribucion, así funciona el switch. 

server <- function(input, output){
  
  output$hist <- renderPlot({
    input$mostrar
    
    rdistribucion <- switch(isolate(input$Distribucion),
                            "norm"= rnorm,
                            "unif"= runif)
    
    x <- rdistribucion(isolate(input$nbins))
    
    hist(x)
    
  })
  
}

shinyApp(ui, server)










