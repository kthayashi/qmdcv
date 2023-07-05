#' Insert entries into your CV
#'
#' @description `qcv_insert` converts a structured list (typically imported
#' from a YAML file) into Quarto-style markdown text (including HTML/CSS
#' where necessary) to be rendered as a CV section. Note that the code chunk in
#' which this function is run should be given the `output: asis` option.
#'
#' @param data A list in the format expected by the `qcvutils` package. See
#' `data(qcvexample)` for an example.
#'
#' @returns Markdown text to be rendered with Quarto.
#'
#' @examples
#' data(qcvexample)
#' edu <- qcvexample$education
#' qcv_insert(edu)
#'
#' @seealso [qcv_insert_pubs]()
#'
#' @export
qcv_insert <- function(data) {
  # Loop through each element of data
  for (i in 1:length(data)) {
    # Get focal element
    d <- data[[i]]
    # Generate output text
    cat("::::::{.columns}\n")
    cat(":::{.column style='width:80%; text-align:left;'}\n")
    if ("title" %in% names(d)) {
      cat(paste0("**", d$title, "**  \n"))
    }
    if ("details" %in% names(d)) {
      cat(paste0(d$details, "  \n", collapse = ""))
    }
    if ("notes" %in% names(d)) {
      cat("[", paste0(d$notes, "]{style='display:flex; color:gray; font-size:0.8em; margin: 0px auto;'}  \n", collapse = ""))
    }
    cat(":::\n")
    cat(":::{.column style='width:20%; text-align:right;'}\n")
    if (all(c("start", "end") %in% names(d))) {
      cat(paste0(d$start, " - ", d$end, "\n"))
    } else if ("start" %in% names(d)) {
      cat(paste0(d$start, "\n"))
    }
    cat(":::\n")
    cat("::::::\n")
    cat("\n")
  }
}

#' Insert publications into your CV
#'
#' @description `qcv_insert_pubs` converts a structured list (typically
#' imported from a YAML file) into Quarto-style markdown text (including HTML/CSS
#' where necessary) to be rendered as a list of publications. Note that the code
#' chunk in which this function is run should be given the `output: asis` option.
#'
#' @param data A list in the format expected by the `qcvutils` package. See
#' `data(qcvexample)` for an example.
#'
#' @details This function currently only works for journal articles.
#'
#' @returns Markdown text to be rendered with Quarto.
#'
#' @examples
#' data(qcvexample)
#' pubs <- qcvexample$publications$articles
#' qcv_insert_pubs(pubs)
#'
#' @seealso [qcv_insert]()
#'
#' @export
qcv_insert_pubs <- function(data) {
  # Loop through each element of data
  for (i in 1:length(data)) {
    # Get focal element
    d <- data[[i]]
    # Generate output text
    cat(paste0(
      "<div>\n",
      rev(1:length(data))[i], ". ",
      paste0(d$authors, collapse = ", "), ". ",
      paste0("(", d$year, "). "),
      d$title, ". ",
      paste0("*", d$publication, "*, "),
      d$volume, ", ",
      d$pages, ". ",
      if ("doi" %in% names(d)) {
        paste0("DOI: [", d$doi, "](", d$doi, ")  \n")
      } else {
        "  \n"
      },
      "</div>\n",
      "\n"
    ))
  }
}
