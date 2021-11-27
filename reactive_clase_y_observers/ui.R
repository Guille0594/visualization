library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Ejemplo de reactive"),
    sidebarLayout(
      sidebarPanel(
        sliderInput("n",
                    label="Tamaño de la muestra",
                    min=2,
                    max=500,
                    value=30
                    ),
        numericInput("mean",
                     label="Media",
                     value=0),
        numericInput("sd",
                     label="Desv. típica",
                     value=1,
                     min=0),
        actionButton("calc",
                     label="Calcular")
      ),
      mainPanel(
        plotOutput("hist"),
        verbatimTextOutput("summary")
      )
    )
  )
)









