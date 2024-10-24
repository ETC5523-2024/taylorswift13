## code to prepare `taylor_all_songs` dataset goes here

taylor_all_songs <- read.csv("data-raw/taylor_all_songs.csv")
usethis::use_data(taylor_all_songs, overwrite = TRUE)
