library(shiny)

dados <- readr::read_rds(here::here("dados/pkmn.rds"))



ui <- fluidPage(
  titlePanel("Shiny de Pokemons!"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "pokemon",
        label = "Selecione um Pokemon",
        choices = unique(dados$pokemon)
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

  # PARA CONTINUAR: CONECTAR E APARECER A FOTO DO POKEMON!

}

shinyApp(ui, server)
