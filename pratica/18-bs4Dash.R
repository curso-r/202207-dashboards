library(shiny)
library(bs4Dash)
library(dplyr)
library(ggplot2)

dados <- readr::read_rds(here::here("dados/credito.rds"))

ui <- dashboardPage(
  dashboardHeader(title = "Análise de crédito"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        "Informações gerais",
        tabName = "info_gerais",
        icon = icon("info-circle")
      ),
      menuItem(
        "Perfil demográfico",
        tabName = "perfil_demografico",
        icon = icon("address-card")
      ),
      menuItem(
        "Perfil financeiro",
        tabName = "perfil_financeiro"
      )
    ),
    img(src = "logo.png", width = "70%", style = "display: block; margin: auto; margin-top: 200px;")
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "info_gerais",
        h2("Informações gerais"),
        hr(style = "border-top: 1px solid black;"),
        fluidRow(
          valueBoxOutput("numero_clientes", width = 4),
          valueBoxOutput("prop_clientes_bons", width = 4),
          valueBoxOutput("media_valor_emprestimo", width = 4)
        ),
        br(),
        fluidRow(
          tabBox(
            width = 12,
            tabPanel(
              title = "Idade",
              plotOutput("grafico_idade")
            ),
            tabPanel(
              title = "Tipo de moradia",
              plotOutput("grafico_moradia")
            ),
            tabPanel(
              title = "Estado civil",
              plotOutput("grafico_estado_civil")
            )
          )
        )
      ),
      tabItem(
        tabName = "perfil_demografico",
        h2("Perfil demográfico"),
        hr(style = "border-top: 1px solid black;"),
        fluidRow(
          box(
            width = 12,
            title = "Filtros",
            fluidRow(
              column(
                width = 4,
                sliderInput(
                  "idade",
                  label = "Selecione o intervalo de idade",
                  min = min(dados$idade, na.rm = TRUE),
                  max = max(dados$idade, na.rm = TRUE),
                  value = c(25, 40)
                )
              ),
              column(
                width = 4,
                shinyWidgets::pickerInput(
                  "moradia",
                  label = "Selecione o tipo de moradia",
                  choices = sort(unique(dados$moradia)),
                  multiple = TRUE,
                  selected = "alugada",
                  options = shinyWidgets::pickerOptions(
                    actionsBox = TRUE,
                    selectAllText = "Selecionar todas",
                    deselectAllText = "Deselecionar todas"
                  )
                )
              ),
              column(
                width = 4,
                selectInput(
                  "estado_civil",
                  label = "Selecione o estado civil",
                  choices = sort(unique(dados$estado_civil))
                )
              )
            )
          )
        ),
        fluidRow(
          column(
            width = 8,
            plotOutput("grafico_perfil_demografico")
          ),
          column(
            width = 4,
            fluidRow(
              infoBoxOutput(
                "perfil_demo_media_valor_emprestimo",
                width = 12
              ),
              infoBoxOutput(
                "perfil_demo_media_tempo_emprestimo",
                width = 12
              )
            )
          )
        )
      )
    )
  )
)

server <- function(input, output, session) {


  # Informações gerais ------------------------------------------------------

  output$numero_clientes <- renderValueBox({
    num <- nrow(dados)

    valueBox(
      value = num,
      subtitle = "Número de clientes",
      icon = icon("user-friends"),
      color = "lightblue"
    )

  })

  output$prop_clientes_bons <- renderValueBox({

    prop <- dados |>
      count(status) |>
      mutate(prop = n / sum(n)) |>
      filter(status == "bom") |>
      pull(prop) |>
      scales::percent(accuracy = 0.1)

    valueBox(
      value = prop,
      subtitle = "Porcentagem de clientes bons",
      icon = icon("thumbs-up"),
      color = "success"
    )

  })

  output$media_valor_emprestimo <- renderValueBox({

    media <- dados |>
      summarise(media = mean(valor_emprestimo, na.rm = TRUE)) |>
      pull(media) |>
      round()

    valueBox(
      value = media,
      subtitle = "Empréstimo solicitado médio",
      icon = icon("money-bill"),
      color = "orange"
    )

  })

  output$grafico_idade <- renderPlot({

    dados |>
      ggplot(aes(x = idade)) +
      geom_histogram() +
      theme_minimal()

  })

  output$grafico_moradia <- renderPlot({

    dados |>
      tidyr::drop_na(moradia) |>
      ggplot(aes(x = moradia)) +
      geom_bar()  +
      theme_minimal()

  })

  output$grafico_estado_civil <- renderPlot({

    dados |>
      tidyr::drop_na(estado_civil) |>
      ggplot(aes(x = estado_civil)) +
      geom_bar()  +
      theme_minimal()

  })


  # Perfil demográfico ------------------------------------------------------

  base_filtrada <- reactive({

    tab <- dados |>
      filter(
        idade %in% input$idade[1]:input$idade[2],
        estado_civil == input$estado_civil,
        moradia == input$moradia
      )

    validate(need(
      nrow(tab) > 0,
      "Não existe nenhum cliente com essas características..."
    ))

    tab

  })

  output$grafico_perfil_demografico <- renderPlot({

    base_filtrada() |>
      count(status) |>
      mutate(prop = n / sum(n) * 100) |>
      ggplot(aes(x = status, y = prop)) +
      geom_col() +
      coord_cartesian(ylim = c(0, 100))


  })

  output$perfil_demo_media_valor_emprestimo <- renderInfoBox({

    valor <- base_filtrada() |>
      summarise(
        media = mean(valor_emprestimo, na.rm = TRUE)
      ) |>
      pull(media) |>
      round() |>
      scales::dollar()

    infoBox(
      title = "Valor de empréstimo solicitado médio",
      value = valor,
      icon = icon("dollar-sign"),
      color = "success",
      fill = TRUE
    )

  })

  output$perfil_demo_media_tempo_emprestimo <- renderInfoBox({

    valor <- base_filtrada() |>
      summarise(
        media = mean(tempo_emprestimo, na.rm = TRUE)
      ) |>
      pull(media) |>
      round() |>
      paste("meses")

    infoBox(
      title = "Tempo de empréstimo solicitado médio",
      value = valor,
      icon = icon("business-time"),
      color = "purple",
      fill = TRUE
    )

  })

}

shinyApp(ui, server)
