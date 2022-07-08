library(shiny)

ui <- fluidPage(
  textInput("texto_entrada", label = "Digite um texto", value = ""),
  textOutput("texto_saida")
)

server <- function(input, output, session) {

  texto_digitado <- reactive({
    print("rodando o reactive")
    input$texto_entrada
  })

  output$texto_saida <- renderText({
    print("rodando o render")
    input$texto_entrada
  })


}

shinyApp(ui, server)
