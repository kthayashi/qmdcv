#' Read example CV data
#'
#' @param ... Potential arguments passed to [yaml::read_yaml()].
#'
#' @returns A list containing example CV data.
#' @export
read_example <- function(...) {
  rlang::check_installed("yaml")
  file <- system.file("example.yaml", package = "qmdcv")
  yaml::read_yaml(file, ...)
}

#' Write example CV data
#'
#' @param to Path to a single destination file or directory. "" indicates output
#' to the console.
#' @param ... Potential arguments passed to [file.copy()].
#'
#' @returns
#' When outputting to the console: none (invisible `NULL`).
#'
#' When writing to a file or directory: `TRUE` or `FALSE` indicating whether
#' the operation succeeded.
#' @export
write_example <- function(to = "", ...) {
  stopifnot(length(to) == 1)
  file <- system.file("example.yaml", package = "qmdcv")
  if (to == "") {
    cat(readLines(file), sep = "\n")
  } else {
    invisible(file.copy(from = file, to = to, ...))
  }
}
