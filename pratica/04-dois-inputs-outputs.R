library(shiny)

ui <- fluidPage(
  "App com input e output (interatividade)",
  selectInput(
    inputId = "variavel_1",
    label = "Selecione uma variável para o grafico 1",
    choices = names(mtcars),
    selected = "wt"
  ),
  plotOutput(outputId = "grafico_1"),
  selectInput(
    inputId = "variavel_2",
    label = "Selecione uma variável para o gráfico 2",
    choices = names(mtcars),
    selected = "mpg"
  ),
  plotOutput(outputId = "grafico_2")
)

server <- function(input, output, session) {

  output$grafico_1 <- renderPlot({

    plot(y = mtcars$mpg, x = mtcars[[input$variavel_1]])
    print("Renderizando output 1")

  })

  output$grafico_2 <- renderPlot({

    plot(y = mtcars$mpg, x = mtcars[[input$variavel_2]])
    print("Renderizando output 2")

  })

}

shinyApp(ui, server)
