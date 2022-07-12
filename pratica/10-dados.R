library(shiny)
library(dplyr)

imdb <- readr::read_rds(here::here("dados/imdb.rds"))

ui <- fluidPage(
  sliderInput(
    inputId = "periodo",
    label = "Selecione um período",
    min = min(imdb$ano, na.rm = TRUE),
    max = max(imdb$ano, na.rm = TRUE),
    value = c(1990, 1999),
    sep = ""
  ),
  tableOutput(outputId = "tabela")
)

server <- function(input, output, session) {

  output$tabela <- renderTable({

    imdb |>
      filter(ano %in% input$periodo[1]:input$periodo[2]) |>
      slice_max(order_by = receita, n = 10) |>
      select(titulo, diretor, ano, orcamento, receita) |>
      mutate(
        orcamento = scales::dollar(orcamento),
        receita = scales::dollar(receita)
      )

  })

}

shinyApp(ui, server)
