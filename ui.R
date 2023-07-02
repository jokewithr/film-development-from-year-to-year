shinyUI(
  dashboardPage(
    title = "Film Dashboard",
    skin = "purple",
    dashboardHeader(title = "Movies Revenue"),
    dashboardSidebar(
      sidebarMenu(
        menuItem(text = "Overview", icon = icon("not-equal"), tabName = "page1"),
        menuItem(text = "Growth Graphic", icon = icon("chart-line"), tabName = "page2"),
        menuItem(text = "Data", icon = icon("table"), tabName = "page3")
      )
    ),
    dashboardBody(
      tabItems(
        # Plot 1
        tabItem(
          tabName = "page1",
          fluidPage(
            fluidRow(p(h3(strong("What parameters you can see in this plot:")))),
            fluidRow(
              valueBoxOutput("movietitle"),
              valueBoxOutput("revenue"),
              valueBoxOutput("imdbrating")
            ),
            fluidRow(
              box(
                width = 8,
                title = "Top 10 Film's Achievement",
                background = "purple",
                selectInput(
                  inputId = "year1",
                  label = "Select Year",
                  choices = film$year,
                  selected = "2018"
                ),
                plotlyOutput("plotversus")
              ),
              box(
                width = 4,
                title = "Caption",
                status = "danger",
                p("Based on the data we have, we can summarize that even the highest grossing movie isn't always the best rated movie. So what is the key? Marketing has always been the best key of a selling product. But what technique shall we use?")
              )
            )
          )
        ),
        tabItem(
          tabName = "page2",
          fluidPage(
            fluidRow(
              valueBoxOutput("topmovie"),
              valueBoxOutput("toprevenue"),
              valueBoxOutput("topyear")
            ),
            fluidRow(
              box(
                width = 12,
                title = "Revenue Growth over the Years",
                background = "purple",
                sliderInput(
                  inputId = "slideryear",
                  label = "Select Year",
                  min = min(film$year),
                  max = max(film$year),
                  value = max(film$year),
                  step = 1
                ),
                plotlyOutput("growth")
              )
            )
          )
        ),
        tabItem(
          tabName = "page3",
          fluidPage(dataTableOutput("dataframe"))
        )
      )
    )
  )
)
