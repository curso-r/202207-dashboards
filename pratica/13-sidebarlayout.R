library(shiny)
library(dplyr)

dados <- readr::read_rds(here::here("dados/pkmn.rds"))

ui <- fluidPage(
  titlePanel("Shiny de Pokemons!"),
  # h1("Shiny de Pokemons!", style = "font-size: 50pt;"),
  sidebarLayout(
    # position = "right",
    sidebarPanel(
      # width = 6,
      selectInput(
        inputId = "pokemon",
        label = "Selecione um Pokemon",
        choices = unique(dados$pokemon)
      )
    ),
    mainPanel(
      # width = 6,
      fluidRow(
        column(
          width = 4,
          offset = 4,
          uiOutput("imagem_pkmn")
        )
      )
    )
  )
)

server <- function(input, output, session) {

  output$imagem_pkmn <- renderUI({

    id <- dados |>
      filter(pokemon == input$pokemon) |>
      pull(id) |>
      stringr::str_pad(width = 3, sid = "left", pad = "0")

    url <- glue::glue(
      "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/{id}.png"
    )

    img(src = url, width = "100%")

  })

}

shinyApp(ui, server)
