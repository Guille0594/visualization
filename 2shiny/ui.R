library(shiny)
library(ggplot2)

# Vamos a crear ahora con dos inputs, seleccionando dos ejes.

variables <- list(
  "Engine displacement, in liters" = "displ",
  "Number of cylinderas" = "cyl",
  "city miles per gallon" = "cty",
  "highway miles per galon" = "hwy"
)

shinyUI(
  fluidPage(
    titlePanel("Shiny 2: visualizacion"),
    sidebarLayout(
      sidebarPanel(
        selectInput("varx", label="Elige variable X", choices= variables),
        selectInput("vary", label="Elige variable Y", choices=variables),
        checkboxInput("facet", label="Facetado por fabricante")
        ),
      mainPanel(
        textOutput("subtitle"), 
        plotOutput("graph")
      )
    )
    
  )
  
)