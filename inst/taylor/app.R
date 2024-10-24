
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(taylorswift13)

# Load the data
data("taylor_album")
data("taylor_album_songs")
data("taylor_all_songs")

# Dashboard UI
ui <- dashboardPage(
  dashboardHeader(title = "Taylor Swift Discography Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Albums Overview", tabName = "albums", icon = icon("music")),
      menuItem("Song Analysis", tabName = "songs", icon = icon("headphones")),
      menuItem("All Songs", tabName = "all_songs", icon = icon("list"))
    )
  ),
  dashboardBody(
    tabItems(
      # Albums Overview Tab
      tabItem(
        tabName = "albums",
        fluidRow(
          box(
            title = "Number of Albums by Release Date",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            plotOutput("albums_year_plot")
          ),
          box(
            title = "Album List",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            tableOutput("album_table")
          )
        )
      ),
      # Song Analysis Tab
      tabItem(
        tabName = "songs",
        fluidRow(
          box(
            title = "Select an Album",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            selectInput("selected_album", "Album", choices = unique(taylor_album_songs$album_name))
          ),
          box(
            title = "Song Durations",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            plotOutput("song_duration_plot")
          )
        )
      ),
      # All Songs Tab
      tabItem(
        tabName = "all_songs",
        fluidRow(
          box(
            title = "Search for a Song",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            textInput("song_search", "Enter Song Name:")
          ),
          box(
            title = "Song Details",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            tableOutput("song_details")
          )
        )
      )
    )
  )
)

# Server Logic
server <- function(input, output) {
  # Albums Plot
  output$albums_year_plot <- renderPlot({
    ggplot(taylor_album, aes(x = album_release)) +
      geom_bar(fill = "lightblue") +
      labs(title = "Number of Albums Released by Date", x = "Release Date", y = "Count")
  })

  # Albums Table
  output$album_table <- renderTable({
    taylor_album %>%
      select(album_name, album_release, metacritic_score, user_score)
  })

  # Song Duration Plot
  output$song_duration_plot <- renderPlot({
    filtered_songs <- taylor_album_songs %>%
      filter(album_name == input$selected_album)

    ggplot(filtered_songs, aes(x = track_number, y = duration_ms)) +
      geom_col(fill = "coral") +
      labs(title = paste("Song Durations in", input$selected_album),
           x = "Track Number", y = "Duration (ms)")
  })

  # Search Song Details
  output$song_details <- renderTable({
    taylor_all_songs %>%
      filter(grepl(input$song_search, track_name, ignore.case = TRUE))
  })
}

# Run the application
shinyApp(ui = ui, server = server)


