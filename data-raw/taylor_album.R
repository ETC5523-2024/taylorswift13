## code to prepare `taylor_album` dataset goes here

taylor_album <- read.csv("data-raw/taylor_albums.csv")
usethis::use_data(taylor_album, overwrite = TRUE)
