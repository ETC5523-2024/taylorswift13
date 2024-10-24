# Load necessary libraries
library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(dplyr)
library(tidyr)
library(DT)
library(taylorswift13)

# Load the data
data("taylor_album")
data("taylor_album_songs")
data("taylor_all_songs")

# UI
ui <- dashboardPage(
  dashboardHeader(title = "Taylor Swift"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Albums Overview", tabName = "albums", icon = icon("music")),
      menuItem("Audio Features", tabName = "audio", icon = icon("headphones")),
      menuItem("Song Duration", tabName = "duration", icon = icon("clock")),
      menuItem("Song Comparison", tabName = "compare", icon = icon("exchange-alt")),
      menuItem("Album Evolution", tabName = "evolution", icon = icon("chart-area"))
    )
  ),
  dashboardBody(
    tags$head(
      # Link to external styles.css file
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),
    tabItems(
      # Albums Overview Tab
      tabItem(
        tabName = "albums",
        fluidRow(
          box(
            title = "Album Releases Over Time",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            plotlyOutput("album_release_plot")
          )
        ),
        fluidRow(
          box(
            title = "Album Ratings",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            dataTableOutput("album_ratings")
          ),
          box(
            title = "Album Details",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            selectInput("selected_album_overview", "Select Album:", choices = unique(taylor_album$album_name)),
            tableOutput("album_details")
          )
        )
      ),
      # Audio Features Tab
      tabItem(
        tabName = "audio",
        fluidRow(
          box(
            title = "Audio Features Across Albums",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("audio_feature", "Select Audio Feature:",
                        choices = c("danceability", "energy", "loudness", "speechiness", "acousticness",
                                    "instrumentalness", "liveness", "valence", "tempo")),
            plotlyOutput("audio_feature_plot")
          )
        )
      ),
      # Song Duration Tab
      tabItem(
        tabName = "duration",
        fluidRow(
          box(
            title = "Song Duration Analysis",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("duration_album", "Select Album:", choices = c("All Albums", unique(taylor_album_songs$album_name))),
            plotlyOutput("song_duration_plot")
          )
        )
      ),
      # Song Comparison Tab
      tabItem(
        tabName = "compare",
        fluidRow(
          box(
            title = "Select Songs to Compare",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("song1", "Select First Song:", choices = taylor_all_songs$track_name),
            selectInput("song2", "Select Second Song:", choices = taylor_all_songs$track_name),
            plotlyOutput("comparison_plot")
          )
        )
      ),
      # Album Evolution Tab
      tabItem(
        tabName = "evolution",
        fluidRow(
          box(
            title = "Evolution of Audio Features Across Albums",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("evolution_feature", "Select Audio Feature:",
                        choices = c("danceability", "energy", "loudness", "speechiness", "acousticness",
                                    "instrumentalness", "liveness", "valence", "tempo")),
            plotlyOutput("evolution_plot")
          )
        )
      )
    )
  )
)

# Server
server <- function(input, output) {
  # Albums Overview
  output$album_release_plot <- renderPlotly({
    p <- ggplot(taylor_album, aes(x = album_release, y = album_name)) +
      geom_point(color = "#B8396B", size = 3) +
      labs(title = "Album Releases Over Time", x = "Release Date", y = "Album") +
      theme_minimal() +
      theme(
        plot.title = element_text(color = "#B8396B", face = "bold"),
        axis.title = element_text(color = "#B8396B"),
        axis.text = element_text(color = "#B8396B")
      )
    ggplotly(p)
  })

  output$album_ratings <- renderDataTable({
    taylor_album %>%
      select(Album = album_name, Release_Date = album_release, Metacritic_Score = metacritic_score, User_Score = user_score)
  })

  output$album_details <- renderTable({
    taylor_album %>%
      filter(album_name == input$selected_album_overview) %>%
      select(Album = album_name, Release_Date = album_release, Metacritic_Score = metacritic_score, User_Score = user_score)
  })

  # Audio Features
  output$audio_feature_plot <- renderPlotly({
    feature <- input$audio_feature
    avg_features <- taylor_album_songs %>%
      group_by(album_name) %>%
      summarize(average = mean(.data[[feature]], na.rm = TRUE))

    p <- ggplot(avg_features, aes(x = reorder(album_name, average), y = average, fill = album_name)) +
      geom_bar(stat = "identity") +
      coord_flip() +
      labs(title = paste("Average", feature, "by Album"), x = "Album", y = paste("Average", feature)) +
      theme_minimal() +
      theme(
        legend.position = "none",
        plot.title = element_text(color = "#B8396B", face = "bold"),
        axis.title = element_text(color = "#B8396B"),
        axis.text = element_text(color = "#B8396B")
      )

    ggplotly(p)
  })

  # Song Duration Tab
  output$song_duration_plot <- renderPlotly({
    if (input$duration_album == "All Albums") {
      duration_data <- taylor_album_songs
    } else {
      duration_data <- taylor_album_songs %>%
        filter(album_name == input$duration_album)
    }

    p <- ggplot(duration_data, aes(x = reorder(track_name, duration_ms), y = duration_ms / 1000, fill = album_name)) +
      geom_bar(stat = "identity") +
      coord_flip() +
      labs(title = "Song Duration (in seconds)", x = "Song", y = "Duration (seconds)") +
      theme_minimal() +
      theme(
        legend.position = "none",
        plot.title = element_text(color = "#B8396B", face = "bold"),
        axis.title = element_text(color = "#B8396B"),
        axis.text = element_text(color = "#B8396B")
      )

    ggplotly(p)
  })

  # Song Comparison
  output$comparison_plot <- renderPlotly({
    song_features <- taylor_all_songs %>%
      filter(track_name %in% c(input$song1, input$song2)) %>%
      select(track_name, danceability, energy, speechiness, acousticness, instrumentalness, liveness, valence, tempo) %>%
      gather(key = "feature", value = "value", -track_name)

    p <- ggplot(song_features, aes(x = feature, y = value, fill = track_name)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Audio Feature Comparison", x = "Feature", y = "Value") +
      theme_minimal() +
      theme(
        plot.title = element_text(color = "#B8396B", face = "bold"),
        axis.title = element_text(color = "#B8396B"),
        axis.text = element_text(color = "#B8396B")
      )

    ggplotly(p)
  })

  # Album Evolution
  output$evolution_plot <- renderPlotly({
    feature <- input$evolution_feature
    feature_data <- taylor_album_songs %>%
      group_by(album_release, album_name) %>%
      summarize(average = mean(.data[[feature]], na.rm = TRUE)) %>%
      arrange(album_release)

    p <- ggplot(feature_data, aes(x = album_release, y = average, color = album_name, group = album_name)) +
      geom_line(size = 1) +
      geom_point(size = 2) +
      labs(title = paste("Evolution of", feature, "Across Albums"), x = "Release Date", y = paste("Average", feature)) +
      theme_minimal() +
      theme(
        plot.title = element_text(color = "#B8396B", face = "bold"),
        axis.title = element_text(color = "#B8396B"),
        axis.text = element_text(color = "#B8396B"),
        legend.title = element_text(color = "#B8396B"),
        legend.text = element_text(color = "#B8396B")
      )

    ggplotly(p)
  })
}

# Run the application
shinyApp(ui = ui, server = server)



