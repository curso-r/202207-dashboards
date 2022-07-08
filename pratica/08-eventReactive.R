library(shiny)

ui <- fluidPage(
  h1("Formulário"),
  textInput(
    inputId = "nome",
    label = "Digite o seu nome",
    value = ""
  ),
  numericInput(
    inputId = "idade",
    label = "Digite a sua idade",
    value = 30
  ),
  textInput(
    inputId = "estado",
    label = "Digite o estado onde nasceu",
    value = ""
  ),
  actionButton(inputId = "enviar", label = "Enviar dados"),
  tableOutput(outputId = "tabela"),
  tableOutput(outputId = "tabela")
)

server <- function(input, output, session) {

  tabela_com_dados_envidados <- eventReactive(input$enviar, {
    tibble::tibble(
      nome = input$nome,
      idade = input$idade,
      estado = input$estado
    )
  })

  output$tabela <- renderTable({
    tabela_com_dados_envidados()
  })

}

shinyApp(ui, server)
