library(shiny)
library(dplyr)

ui <- fluidPage(
  h1("Resultado do sorteio de uma amostra"),
  sliderInput(
    inputId = "tamanho_amostra",
    label = "Selecione o tamanho da amostra",
    min = 1,
    max = 1000,
    value = 100,
    step = 10
  ),
  plotOutput(outputId = "grafico"),
  textOutput(outputId = "texto_com_resultado")
)

server <- function(input, output, session) {


  output$grafico <- renderPlot({

    set.seed(1)
    amostra <- sample(x = 1:10, size = input$tamanho_amostra, replace = TRUE)

    amostra |>
      table() |>
      barplot()

  })



  output$texto_com_resultado <- renderText({

    set.seed(1)
    amostra <- sample(x = 1:10, size = input$tamanho_amostra, replace = TRUE)

    numero <- tibble::tibble(
      amostra = amostra
    ) |>
      count(amostra, name = "freq") |>
      slice_max(order_by = freq, n = 1, with_ties = FALSE) |>
      pull(amostra)


    #paste("O número mais sorteado foi", numero)
    glue::glue("O número mais sorteado foi {numero}.")

  })

}

shinyApp(ui, server)
