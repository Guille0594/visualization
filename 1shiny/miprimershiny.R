library(shiny)

# Vemos la estructura basica. shinyApp es el centro de todo.
# server es un poco aprenderlo de memoria, es ua funcion que acepta dos cosas
# cuyo contenido no tiene nada
# en ui un monton de cosas que va a ver el usuario. Es una página web que está 
# en local, y se puede subir a un servidor.

# fluid page es el padre, espacio y vamos metiendo hijos. TitlePanel no tiene 
# hijos porque en sus paréntesis no hay nada. Ahora hacemos un hermano a 
# title panel, tiene que estar dentro de fluid page. Recordemos que son 
# parametros, y como tal van separados por comas. Los hermanos deberían estar
# a la misma altura. El siguiente es sidebarLayout. Este layout es el de la barra
# lateral. Haremos una estructura que va a tener barra lateral y parte central.

# Luego metemos sliderinput y plotoutput, los hijos de sliderlayout. Vamos 
# rellenando slider input despues de leer la ayuda. 

# Hacemos lo mismo con el output. hist en este caso. Ahí, ya nos debe dejar 
# abrir el slider y hacer cosas con el.  

#######

# Ahora nos falta conectar ambas cosas, que se hara en el server puesto que ya no 
# estamos hablando de interfaz. Si queremos practicar shinny ir a las diapos 
# a las que tiene un arbol a la derecha e intentar escribirlo de 0. 

# Pasamos a escribir la funcion abajo. El hist es un plot output, y es el mismo
# el de plotout y el de la funcion. Tenemos que poner siempre render, el que 
# corresponda con el output, que en este caso es un plot. 

# dentro del output pondremos input$ para que se conecten. En este caso es 
# input$nbins, y ya estarían conectados. 

# Hasta aquí la funcionalidad más básica de Shiny, un input y un output. 

ui  <- fluidPage(
  titlePanel('Master Data Science'),
  sidebarLayout(
    sidebarPanel(
      sliderInput("nbins",
                  label= "Number of bins",
                  min = 1,
                  max = 50,
                  value = 25
                  )
    ),
    mainPanel(
      plotOutput("hist")
      )
    )
)

server <- function(input, output){
  
  output$hist <- renderPlot({
    hist(faithful$waiting, breaks = input$nbins)
  })
}

shinyApp(ui, server)





