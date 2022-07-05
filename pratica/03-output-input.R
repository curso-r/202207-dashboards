library(shiny)

ui <- fluidPage(
  "App com input e output (interatividade)",
  selectInput(
    inputId = "variavel_x",
    label = "Selecione uma variável para o eixo X",
    choices = names(mtcars),
    selected = "wt"
  ),
  selectInput(
    inputId = "variavel_y",
    label = "Selecione uma variável para o eixo Y",
    choices = names(mtcars),
    selected = "mpg"
  ),
  plotOutput(outputId = "grafico")
)

server <- function(input, output, session) {

  output$grafico <- renderPlot({

    plot(y = mtcars[[input$variavel_y]], x = mtcars[[input$variavel_x]])

  })

}

shinyApp(ui, server)
