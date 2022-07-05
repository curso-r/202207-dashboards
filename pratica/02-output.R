library(shiny)
library(ggplot2)

ui <- fluidPage(
  "Um gráfico de dispersão",
  plotOutput(outputId = "grafico", width = "50%", height = "600px"),
  plotOutput(outputId = "grafico2", width = "50%", height = "600px"),
  "Um texto qualquer"
)

server <- function(input, output, session) {

  output$grafico <- renderPlot({

    mtcars |>
      ggplot() +
      geom_point(aes(x = wt, y = mpg))

  })

  output$grafico2 <- renderPlot({

    mtcars |>
      ggplot() +
      geom_point(aes(x = hp, y = mpg))

  })

}

shinyApp(ui, server)
