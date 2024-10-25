#' Taylor Swift Albums
#'
#' A data frame listing Taylor Swift's albums.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{X}{Row identifier}
#'   \item{album_name}{Name of the album}
#'   \item{ep}{Indicates whether the album is an EP (Extended Play)}
#'   \item{album_release}{Release date of the album}
#'   \item{metacritic_score}{Metacritic aggregate score for the album}
#'   \item{user_score}{User-generated score for the album}
#' }
#' @examples
#' data(taylor_album)
#' head(taylor_album)
#' summary(taylor_album)
#' @docType data
#' @keywords datasets
"taylor_album"



#' Taylor Swift Album Songs
#'
#' A data frame containing details of songs from Taylor Swift's albums.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{X}{Row identifier}
#'   \item{album_name}{Name of the album the song belongs to}
#'   \item{ep}{Indicates whether the album is an EP (Extended Play)}
#'   \item{album_release}{Release date of the album}
#'   \item{track_number}{Track number of the song within the album}
#'   \item{track_name}{Title of the song}
#'   \item{artist}{Name of the artist}
#'   \item{featuring}{Featured artists on the track, if any}
#'   \item{bonus_track}{Indicates if the song is a bonus track}
#'   \item{promotional_release}{Indicates if the song was released for promotional purposes}
#'   \item{single_release}{Indicates if the song was released as a single}
#'   \item{track_release}{Release date of the individual track}
#'   \item{danceability}{Danceability score (0.0 to 1.0)}
#'   \item{energy}{Energy score (0.0 to 1.0)}
#'   \item{key}{Musical key the song is in (numeric representation)}
#'   \item{loudness}{Loudness of the track in decibels (dB)}
#'   \item{mode}{Mode of the track (0 = Minor, 1 = Major)}
#'   \item{speechiness}{Speechiness score (0.0 to 1.0)}
#'   \item{acousticness}{Acousticness score (0.0 to 1.0)}
#'   \item{instrumentalness}{Instrumentalness score (0.0 to 1.0)}
#'   \item{liveness}{Liveness score (0.0 to 1.0)}
#'   \item{valence}{Valence score (0.0 to 1.0)}
#'   \item{tempo}{Tempo of the track in beats per minute (BPM)}
#'   \item{time_signature}{Time signature of the track (e.g., 4 for 4/4)}
#'   \item{duration_ms}{Duration of the track in milliseconds}
#'   \item{explicit}{Indicates if the track contains explicit lyrics}
#'   \item{key_name}{Musical key name (e.g., C major)}
#'   \item{mode_name}{Mode name (e.g., Major or Minor)}
#'   \item{key_mode}{Combined key and mode information}
#' }
#' @examples
#' data(taylor_album_songs)
#' head(taylor_album_songs)
#' summary(taylor_album_songs)
#' @docType data
#' @keywords datasets
"taylor_album_songs"

#' All Taylor Swift Songs
#'
#' A comprehensive data frame of all Taylor Swift's songs, including related information.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{X}{Row identifier}
#'   \item{album_name}{Name of the album the song belongs to}
#'   \item{ep}{Indicates whether the album is an EP (Extended Play)}
#'   \item{album_release}{Release date of the album}
#'   \item{track_number}{Track number of the song within the album}
#'   \item{track_name}{Title of the song}
#'   \item{artist}{Name of the artist}
#'   \item{featuring}{Featured artists on the track, if any}
#'   \item{bonus_track}{Indicates if the song is a bonus track}
#'   \item{promotional_release}{Indicates if the song was released for promotional purposes}
#'   \item{single_release}{Indicates if the song was released as a single}
#'   \item{track_release}{Release date of the individual track}
#'   \item{danceability}{Danceability score (0.0 to 1.0)}
#'   \item{energy}{Energy score (0.0 to 1.0)}
#'   \item{key}{Musical key the song is in (numeric representation)}
#'   \item{loudness}{Loudness of the track in decibels (dB)}
#'   \item{mode}{Mode of the track (0 = Minor, 1 = Major)}
#'   \item{speechiness}{Speechiness score (0.0 to 1.0)}
#'   \item{acousticness}{Acousticness score (0.0 to 1.0)}
#'   \item{instrumentalness}{Instrumentalness score (0.0 to 1.0)}
#'   \item{liveness}{Liveness score (0.0 to 1.0)}
#'   \item{valence}{Valence score (0.0 to 1.0)}
#'   \item{tempo}{Tempo of the track in beats per minute (BPM)}
#'   \item{time_signature}{Time signature of the track (e.g., 4 for 4/4)}
#'   \item{duration_ms}{Duration of the track in milliseconds}
#'   \item{explicit}{Indicates if the track contains explicit lyrics}
#'   \item{key_name}{Musical key name (e.g., C major)}
#'   \item{mode_name}{Mode name (e.g., Major or Minor)}
#'   \item{key_mode}{Combined key and mode information}
#'   \item{lyrics}{Lyrics of the song}
#' }
#' @examples
#' data(taylor_all_songs)
#' head(taylor_all_songs)
#' summary(taylor_all_songs)
#' @docType data
#' @keywords datasets
"taylor_all_songs"


