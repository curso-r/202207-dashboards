library(shiny)

caixa <- function(texto = "Curso-R"){
  div(texto, style = "background: purple; height: 100px; color: white; font-size: 24px; text-align: center;")
}

ui <- fluidPage(
  fluidRow(
    column(width = 2, caixa("1")),
    column(width = 4, caixa("2")),
    column(width = 6, caixa("3"))
  ),
  br(),

  fluidRow(
    column(width = 1, caixa("4")),
    column(width = 3, offset = 8, caixa("5"))
  ),
  br(),
  fluidRow(
    column(width = 1, caixa("6")),
    column(width = 1, caixa("7")),
    column(width = 1, caixa("8")),
    column(width = 1, caixa("9")),
    column(width = 1, caixa("10")),
    column(width = 1, caixa("11")),
    column(width = 1, caixa("12")),
    column(width = 1, caixa("13")),
    column(width = 1, caixa("14")),
    column(width = 1, caixa("15")),
    column(width = 1, caixa("16")),
    column(width = 1, caixa("17"))
  )

)

server <- function(input, output, session) {

}

shinyApp(ui, server)
