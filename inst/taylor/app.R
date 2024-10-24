# Load necessary libraries
library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(dplyr)
library(tidyr)
library(DT)
library(scales)
library(taylorswift13)

# Load the data (using data from the package)
data("taylor_album")
data("taylor_album_songs")
data("taylor_all_songs")

# UI
ui <- dashboardPage(
  dashboardHeader(title = "Taylor Swift Dashboard"),
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
        h2("Albums Overview"),
        p("Explore Taylor Swift's albums, their release dates, and critical reception."),
        fluidRow(
          box(
            title = "Album Releases Over Time",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            plotlyOutput("album_release_plot"),
            p("This scatter plot shows the release dates of Taylor Swift's albums. Each point represents an album, allowing you to see how her discography has evolved over time.")
          )
        ),
        fluidRow(
          box(
            title = "Album Ratings",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            dataTableOutput("album_ratings"),
            p("This table displays the Metacritic and user scores for each album, providing insight into critical and fan reception.")
          )
        )
      ),
      # Audio Features Tab
      tabItem(
        tabName = "audio",
        h2("Audio Features Analysis"),
        p("Analyze various audio features across Taylor Swift's albums."),
        fluidRow(
          box(
            title = "Audio Features Across Albums",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("audio_feature", "Select Audio Feature:",
                        choices = c("danceability", "energy", "loudness", "speechiness",
                                    "acousticness", "instrumentalness", "liveness", "valence", "tempo")),
            plotlyOutput("audio_feature_plot"),
            p("This bar chart compares the average selected audio feature across all albums. Select different features to see how they vary by album.")
          )
        ),
        fluidRow(
          box(
            title = "Audio Feature Descriptions",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            p("Danceability: Indicates how suitable a track is for dancing based on tempo, rhythm stability, beat strength, and overall regularity."),
            p("Energy: Represents a perceptual measure of intensity and activity. High energy tracks feel fast and loud."),
            p("Loudness: The overall loudness of a track in decibels (dB)."),
            p("Speechiness: Detects the presence of spoken words in a track."),
            p("Acousticness: Confidence measure of whether the track is acoustic."),
            p("Instrumentalness: Predicts whether a track contains no vocals."),
            p("Liveness: Detects the presence of an audience in the recording."),
            p("Valence: Describes the musical positiveness conveyed by a track."),
            p("Tempo: The speed or pace of a given piece, measured in beats per minute (BPM).")
          )
        )
      ),
      # Song Duration Tab
      tabItem(
        tabName = "duration",
        h2("Song Duration Analysis"),
        p("Examine the duration of songs across albums."),
        fluidRow(
          box(
            title = "Song Duration",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("duration_album", "Select Album:", choices = c("All Albums", unique(taylor_album_songs$album_name))),
            plotlyOutput("song_duration_plot"),
            p("This bar chart shows the duration of songs in the selected album or across all albums. You can identify longer or shorter tracks and compare song lengths.")
          )
        )
      ),
      # Song Comparison Tab
      tabItem(
        tabName = "compare",
        h2("Song Comparison"),
        p("Compare two songs based on their audio features."),
        fluidRow(
          box(
            title = "Select Songs to Compare",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("song1", "Select First Song:", choices = taylor_all_songs$track_name),
            selectInput("song2", "Select Second Song:", choices = taylor_all_songs$track_name),
            plotlyOutput("comparison_plot"),
            p("This chart compares the audio features of the two selected songs. Use it to analyze similarities and differences between them.")
          )
        )
      ),
      # Album Evolution Tab
      tabItem(
        tabName = "evolution",
        h2("Album Evolution"),
        p("Explore how Taylor Swift's music has evolved over time based on audio features."),
        fluidRow(
          box(
            title = "Evolution of Audio Features Across Albums",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("evolution_feature", "Select Audio Feature:",
                        choices = c("danceability", "energy", "loudness", "speechiness",
                                    "acousticness", "instrumentalness", "liveness", "valence", "tempo")),
            plotlyOutput("evolution_plot"),
            p("This line chart shows the change in the selected audio feature across albums over time. It helps visualize the evolution of Taylor Swift's musical style.")
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
        axis.text.x = element_text(color = "#B8396B",angle = 45, hjust = 1),
        axis.text.y = element_text(color = "#B8396B")
      )
    ggplotly(p)
  })

  output$album_ratings <- renderDataTable({
    taylor_album %>%
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

  # Song Duration
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
    features <- c("danceability", "energy", "speechiness", "acousticness",
                  "instrumentalness", "liveness", "valence", "tempo")
    custom_colors <- c("#B8396B", "#FFD1DC", "#D87A99", "#E89AB0", "#F0A1B5")
    song_features <- taylor_all_songs %>%
      filter(track_name %in% c(input$song1, input$song2)) %>%
      select(track_name, all_of(features)) %>%
      gather(key = "feature", value = "value", -track_name) %>%
      group_by(feature) %>%
      mutate(normalized_value = rescale(value)) %>%
      ungroup()

    p <- ggplot(song_features, aes(x = feature, y = normalized_value, fill = track_name)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Audio Feature Comparison (Normalized)", x = "Feature", y = "Normalized Value") +
      theme_minimal() +
      theme(
        plot.title = element_text(color = "#B8396B", face = "bold"),
        axis.title = element_text(color = "#B8396B"),
        axis.text = element_text(color = "#B8396B")
      )+
      scale_fill_manual(values = custom_colors)

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





