library(shiny)
library(dplyr)

ui <- fluidPage(
  h2("Editando base de dados"),
  sidebarLayout(
    sidebarPanel(
      numericInput(
        "linha",
        label = "Escolha uma linha para remover",
        value = 1
      ),
      actionButton("remover", "Remover linha")
    ),
    mainPanel(
      tableOutput("tabela")
    )
  )
)

server <- function(input, output, session) {

  vr_mtcars <- reactiveVal(tibble::rownames_to_column(mtcars))

  observeEvent(input$remover, {

    nova_mtcars <- vr_mtcars() |>
      slice(-input$linha)

    vr_mtcars(nova_mtcars)

  })

  output$tabela <- renderTable({
    vr_mtcars()
  })


}

shinyApp(ui, server)
