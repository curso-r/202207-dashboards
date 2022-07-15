library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  title = "Meu 1º dash",
  dashboardHeader(title = "Meu 1º dash!"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        text = "Página 1",
        tabName = "pag1"
      ),
      menuItem(
        "Página 2",
        tabName = "pag2"
      ),
      menuItem(
        "Página 3",
        tabName = "pag3"
      ),
      menuItem(
        "Outras páginas",
        menuSubItem(
          "Página 4",
          tabName = "pag4"
        ),
        menuSubItem(
          "Página 5",
          tabName = "pag5"
        ),
        menuSubItem(
          "Página 6",
          tabName = "pag6"
        )
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "pag1",
        h2("Título da página 1"),

      ),
      tabItem(
        tabName = "pag2",
        h2("Título da página 2")
      ),
      tabItem(
        tabName = "pag3",
        h2("Título da página 3")
      ),
      tabItem(
        tabName = "pag4",
        h2("Título da página 4")
      ),
      tabItem(
        tabName = "pag5",
        h2("Título da página 5")
      ),
      tabItem(
        tabName = "pag6",
        h2("Título da página 6")
      )
    )
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
