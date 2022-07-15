library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  title = "Meu 1º dash",
  dashboardHeader(title = "Meu 1º dash!"),
  dashboardSidebar(),
  dashboardBody()
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
