library(shiny)

ui <- fluidPage(
  textInput(
    inputId = "email",
    label = "Digite o seu e-mail",
    value = ""
  ),
  actionButton("enviar", label = "Enviar"),
  actionButton("limpar", label = "Limpar filtro"),
  downloadButton("download", label = "Download")
)

server <- function(input, output, session) {

  observeEvent(input$enviar, {
    write(input$email, file = "emails.txt", append = TRUE)
  })

  observeEvent(input$limpar, {
    updateTextInput(
      session = session,
      inputId = "email",
      value = ""
    )
    # vc pode colocar várias funções update
    # no mesmo observeEvent
  })

  output$download <- downloadHandler(
    filename = "emails.txt",
    # filename = "mtcars.xlsx",
    content = function(file) {
      file.copy(from = "emails.txt", to = file)
      # writexl::write_xlsx(x = mtcars, path = file)
    }
  )

}

shinyApp(ui, server)
