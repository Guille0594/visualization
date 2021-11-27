# Llaves. Se pueden poner siempre, esto no falla:
{}

# Siempre contienen dentro una expresión, que es un valor:
{5}

# Normalmente las usamos poniendo varias lineas. Devuelve el último.
# La llave no es mas que un agrupador de expresiones en el cual se devuelve
# la última. Ahora entendermos lo de los if

{
  5
  3
}


# A ver que pasa sin llave. Una función acepta una cosa, así el render plot
# solo aceptaría una cosa. Salvo que sepas poner todo en una linea, no podrías.
# La llave va a devolver lo último, el histograma, que es lo que queremos 
# renderizar. Coge la última y lo devuelve. 

renderPlot({
  x <- rnorm(5)
  hist(x)
})

# Los fucntion son igual. Las llaves devuelven el último, va a multiplicar
# por 2. Tienen la palabra clave return para devolver lo que quieras cuando 
# quieras. 

miFuncion <- function(x){
  x * 2
}

miFuncion(8)


# Ahora vamos a ver el if. Si es true devuelve la expresion que va justo despues 
# Si x = 2, guarda la X. Si ejecutamos esto sin llaves:

if (2==2){
  x <- 2
  print(x*2)
  }

### A ver que pasa aqui abajo. Guarda x =1, como el otro es false, pasa. La 
# llave es un aglomerador de expresiones. No imprime nada porque no se cumple
# la expresión. Los renders son funciones que esperan expresiones. 

# Si el If solo tienen una línea, no hacen falta. Empaquetan varias lineas
# en una sola expresión. 

x <- 1
if ( 2 == 3)
  x <- 2
print(x * 2)



x <- 1
if ( 2 == 3) {
  x <- 2
print(x * 2)
}



