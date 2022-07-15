library(shiny)
library(dplyr)
library(ggplot2)

dados <- readr::read_rds(here::here("dados/pkmn.rds"))

ui <- navbarPage(
  title = "navBar Layout",
  theme = shinythemes::shinytheme("cyborg"),
  tabPanel(
    title = "Página 1",
    titlePanel("Título da página 1"),
    hr(),
    p("Mauris placerat sem efficitur nisi mattis imperdiet. Maecenas pharetra, est rutrum lobortis posuere, sapien mi feugiat nibh, et aliquam ante sapien in nisl. Curabitur mollis arcu aliquam dolor pretium semper. Sed condimentum purus in massa tristique, vitae vehicula quam placerat. Fusce odio massa, semper ut porta in, gravida sed nibh. In at eros id sem luctus hendrerit. Vivamus enim quam, condimentum sed elementum eget, ultrices commodo orci. Nulla sit amet diam quis ex pharetra rhoncus. Nam mollis lectus ac felis hendrerit mollis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla porta ut libero sed dictum. Cras auctor risus at arcu aliquam euismod. Aenean nec sodales lorem, sit amet elementum velit. Pellentesque eu erat eu sem tempor fringilla. Vivamus pulvinar sed."),
    hr(),
    fluidRow(
      column(
        width = 4,
        selectInput(
          inputId = "variavel1",
          label = "Selecione uma variável",
          choices = names(mtcars)
        )
      ),
      column(
        width = 4,
        selectInput(
          inputId = "variavel2",
          label = "Selecione um pkmn",
          choices = c("ataque", "defesa", "velocidade")
        )
      ),
      column(
        width = 4,
        selectInput(
          inputId = "variavel3",
          label = "Selecione uma variável",
          choices = names(mtcars)
        )
      )
    ),
    fluidRow(
      column(
        width = 6,
        plotOutput("grafico1")
      ),
      column(
        width = 6,
        plotOutput("grafico2")
      )
    )
  ),
  tabPanel(
    title = "Página 2",
    titlePanel("Título da página 2"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "variavel4",
          label = "Selecione uma variável",
          choices = names(mtcars)
        ),
        selectInput(
          inputId = "variavel5",
          label = "Selecione uma variável",
          choices = names(mtcars)
        )
      ),
      mainPanel(
        plotOutput("grafico3"),
        plotOutput("grafico4")
      )
    )
  ),
  navbarMenu(
    title = "Outras páginas",
    tabPanel(
      title = "Página 3",
      titlePanel("Título da página 3")
    ),
    tabPanel(
      title = "Página 4",
      titlePanel("Título da página 4")
    )
  )
)

server <- function(input, output, session) {

  # Página 1

  output$grafico1 <- renderPlot({
    plot(x = mtcars[[input$variavel1]], y = mtcars$mpg)
  })

  output$grafico2 <- renderPlot({
    plot(x = dados[[input$variavel2]], y = dados$hp)
  })

  # Página 2

  output$grafico3 <- renderPlot({
    plot(x = mtcars[[input$variavel4]], y = mtcars$mpg)
  })

  output$grafico4 <- renderPlot({
    plot(x = mtcars[[input$variavel5]], y = mtcars$mpg)
  })

}

shinyApp(ui, server)
