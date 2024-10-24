
#' Launch the Taylor Swift Dashboard App
#'
#' This function launches the Shiny dashboard for exploring Taylor Swift's albums and songs.
#'
#' @export
launch_app <- function() {
  app_dir <- system.file("taylor", package = "taylorswift13")
  if (app_dir == "") {
    stop("Could not find the Shiny app directory. Try re-installing the package.", call. = FALSE)
  }
  shiny::runApp(app_dir, display.mode = "normal")
}

