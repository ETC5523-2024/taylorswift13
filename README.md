
<!-- README.md is generated from README.Rmd. Please edit that file -->

# taylorswift13 <a href="https://etc5523-2024.github.io/taylorswift13/"><img src="man/figures/logo.png" align="right" height="139" alt="taylorswift13 website" /></a>

[![pkgdown](https://img.shields.io/badge/pkgdown-website-blue)](https://ETC5523-2024.github.io/taylorswift13/)

## Description

**taylorswift13** is an R package designed to provide comprehensive data
analysis and visualization tools for Taylor Swift’s musical works. The
package includes detailed datasets on Taylor Swift’s albums and songs,
along with an interactive Shiny application that allows users to explore
various aspects of her discography, such as song characteristics, album
metrics, and lyrical content.

## Features

- **Comprehensive Datasets**: Access detailed information about Taylor
  Swift’s albums and songs, including metadata like release dates, track
  numbers, and musical features.
- **Interactive Shiny App**: Launch an interactive web application to
  visualize and analyze the data dynamically.
- **Vignettes**: Detailed guides and examples to help you get started
  with the package.
- **Easy Installation**: Install directly from GitHub using the
  `remotes` package.

## Installation

To install the **taylorswift13** package from GitHub, you need to have
the `remotes` package installed. If you haven’t installed it yet, do so
by running:

``` r
install.packages("remotes")
```

Then, install **taylorswift13** using:

``` r
remotes::install_github("snair1809/taylorswift13")
```

## Usage

### Loading the Package

First, load the package into your R session:

``` r
library(taylorswift13)
```

### Accessing the Data

The package includes three main datasets:

1.  **taylor_album**: Information about Taylor Swift’s albums.
2.  **taylor_album_songs**: Details of songs from each album.
3.  **taylor_all_songs**: Comprehensive data on all Taylor Swift’s
    songs.

#### Loading and Exploring Datasets

``` r
# Load the album data
data(taylor_album)
head(taylor_album)
summary(taylor_album)

# Load the album songs data
data(taylor_album_songs)
head(taylor_album_songs)
summary(taylor_album_songs)

# Load all songs data
data(taylor_all_songs)
head(taylor_all_songs)
summary(taylor_all_songs)
```

### Launching the Shiny App

Explore the interactive Shiny application included in the package:

``` r
# Launch the Shiny app
launch_app()
```

*This function launches the Shiny application, allowing you to
interactively explore Taylor Swift’s album and song data.*

### Vignettes

For detailed guides and examples, refer to the vignettes included with
the package:

``` r
# Access the main vignette
browseVignettes("taylorswift13")
```

## Example

Here’s a simple example of how you can visualize the distribution of
song energy across Taylor Swift’s albums using `ggplot2`:

``` r
library(ggplot2)

# Load the album songs data
data(taylor_album_songs)

# Plot energy distribution
ggplot(taylor_album_songs, aes(x = album_name, y = energy)) +
  geom_boxplot(fill = "steelblue") +
  theme_minimal() +
  labs(title = "Distribution of Song Energy Across Albums",
       x = "Album",
       y = "Energy Score")
```

## Data Documentation

### `taylor_album`

A data frame listing Taylor Swift’s albums.

**Columns:**

- `album_name`: Name of the album
- `ep`: Indicates whether the album is an EP (Extended Play)
- `album_release`: Release date of the album
- `metacritic_score`: Metacritic aggregate score for the album
- `user_score`: User-generated score for the album

### `taylor_album_songs`

A data frame containing details of songs from Taylor Swift’s albums.

**Columns:**

- `album_name`: Name of the album the song belongs to
- `ep`: Indicates whether the album is an EP (Extended Play)
- `album_release`: Release date of the album
- `track_number`: Track number of the song within the album
- `track_name`: Title of the song
- `artist`: Name of the artist
- `featuring`: Featured artists on the track, if any
- `bonus_track`: Indicates if the song is a bonus track
- `promotional_release`: Indicates if the song was released for
  promotional purposes
- `single_release`: Indicates if the song was released as a single
- `track_release`: Release date of the individual track
- `danceability`: Danceability score (0.0 to 1.0)
- `energy`: Energy score (0.0 to 1.0)
- `key`: Musical key the song is in (numeric representation)
- `loudness`: Loudness of the track in decibels (dB)
- `mode`: Mode of the track (0 = Minor, 1 = Major)
- `speechiness`: Speechiness score (0.0 to 1.0)
- `acousticness`: Acousticness score (0.0 to 1.0)
- `instrumentalness`: Instrumentalness score (0.0 to 1.0)
- `liveness`: Liveness score (0.0 to 1.0)
- `valence`: Valence score (0.0 to 1.0)
- `tempo`: Tempo of the track in beats per minute (BPM)
- `time_signature`: Time signature of the track (e.g., 4 for 4/4)
- `duration_ms`: Duration of the track in milliseconds
- `explicit`: Indicates if the track contains explicit lyrics
- `key_name`: Musical key name (e.g., C major)
- `mode_name`: Mode name (e.g., Major or Minor)
- `key_mode`: Combined key and mode information

### `taylor_all_songs`

A comprehensive data frame of all Taylor Swift’s songs, including
related information.

**Columns:**

*Same as `taylor_album_songs`.*

## License

This project is licensed under the MIT License - see the
[LICENSE](LICENSE) file for details.

## Author

**Shalini Nair**

- [GitHub](https://github.com/snair1809)
- [Email](snai0031@student.monash.edu)

## Acknowledgements

- Inspired by Taylor Swift’s extensive and impactful discography.
- Thanks to the open-source community for the tools and packages that
  made this project possible.

## References

- Thompson, W. J. (2024). *taylor: Lyrics and song data for Taylor
  Swift’s discography* (Version 3.1.0) \[R package\].
  <https://github.com/wjakethompson/taylor>.
