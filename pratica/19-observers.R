library(shiny)
library(dplyr)

dados <- readr::read_rds(here::here("dados/pkmn.rds"))

ui <- fluidPage(
  titlePanel("Shiny de Pokemons!"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "geracao",
        label = "Selecione a geração",
        choices = unique(dados$id_geracao)
      ),
      selectInput(
        inputId = "pokemon",
        label = "Selecione um Pokemon",
        choices = c("Carregando..." = "")
      )
    ),
    mainPanel(
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


  observe({

    opcoes <- dados |>
      filter(id_geracao == input$geracao) |>
      pull(pokemon) |>
      unique()

    updateSelectInput(
      session = session,
      inputId = "pokemon",
      choices = opcoes
    )

  })

  output$imagem_pkmn <- renderUI({

    # req(input$pokemon)
    validate(need(
      isTruthy(input$pokemon),
      # input$pokemon == "", # poderia ser apenas assim
      "A imagem está sendo carregada..."
    ))

    Sys.sleep(3)

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
