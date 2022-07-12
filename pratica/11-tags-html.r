library(shiny)

ui <- fluidPage(
  h1('Esse talvez seja o nosso primeiro "app" bonito'),
  hr(),
  h3("Sobre este app"),
  p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ut suscipit justo. Donec pellentesque, nulla sed imperdiet laoreet, justo est feugiat justo, congue commodo arcu metus at urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque euismod vel ex et efficitur. Vestibulum tempus scelerisque ligula, quis semper est auctor in. Ut fringilla ipsum vel sem ultrices molestie. Maecenas ac vulputate purus. Mauris vel erat at urna scelerisque congue."),
  p(
    "Mauris placerat sem efficitur nisi mattis imperdiet. Maecenas pharetra, est rutrum lobortis posuere, sapien mi feugiat nibh, et aliquam ante sapien in nisl. Curabitur mollis arcu aliquam dolor pretium semper. Sed condimentum purus in massa tristique, vitae vehicula quam placerat. Fusce odio massa, semper ut porta in, gravida sed nibh. In at eros id sem luctus hendrerit. Vivamus enim quam, condimentum sed elementum eget, ultrices commodo orci. Nulla sit amet diam quis ex pharetra rhoncus. Nam mollis lectus ac felis hendrerit mollis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla porta ut libero sed dictum. Cras auctor risus at arcu aliquam euismod. Aenean nec sodales lorem, sit amet elementum velit. Pellentesque eu erat eu sem tempor fringilla. Vivamus pulvinar sed.",
    style = "color: orange;"
  ),
  br(),
  p(
    "Você pode ver o código deste app",
    a(
      href = "https://github.com/curso-r/202207-dashboards",
      "neste repositório do Github",
      .noWS = c("after"),
      target = "_blank"
    ),
    "."
  ),
  hr(),
  img(src = "logo.png", width = "25%", style = "display: block; margin: auto;"),
  br(),
  fluidRow(
    column(
      width = 2,
      offset = 5,
      img(src = "logo.png", width = "100%")
    )
  ),
  br(),
  a(
    href = "https://github.com/azeloc",
    style = "float: right",
    img(src = "https://avatars.githubusercontent.com/u/14807413?v=4", width = "50%")
  )

)

server <- function(input, output, session) {

}

shinyApp(ui, server)
