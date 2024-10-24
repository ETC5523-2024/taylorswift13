## code to prepare `taylor_album_songs` dataset goes here

taylor_album_songs <- read.csv("data-raw/taylor_album_songs.csv")
taylor_album_songs <- taylor_album_songs |> subset( select = -lyrics)
usethis::use_data(taylor_album_songs, overwrite = TRUE)
