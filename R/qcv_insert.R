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
#' @seealso [qcv_insert_pubs](), [qcv_insert_talks](), [qcv_insert_list]()
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
      cat(paste0("[", d$notes, "]{style='display:flex; color:gray; font-size:0.8em; margin: 0px auto;'}\n", collapse = ""))
    }
    cat(":::\n")
    cat(":::{.column style='width:20%; text-align:right;'}\n")
    if (all(c("start", "end") %in% names(d))) {
      cat(paste0(d$start, " - ", d$end, "\n"))
    } else if ("start" %in% names(d)) {
      cat(paste0(d$start, "\n"))
    } else if ("years" %in% names(d)) {
      cat(paste0(paste0(d$years, collapse = ", "), "\n"))
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
#' @seealso [qcv_insert](), [qcv_insert_talks](), [qcv_insert_list]()
#'
#' @export
qcv_insert_pubs <- function(data) {
  # Loop through each element of data
  for (i in 1:length(data)) {
    # Get focal element
    d <- data[[i]]
    # Generate output text
    cat(paste0(
      ":::{}\n",
      rev(1:length(data))[i], ". ",
      if (length(d$authors) > 1) {
        paste0(paste0(d$authors, collapse = ", "), ". ")
      } else {
        paste0(d$authors, ". ")
      },
      paste0("(", d$year, "). "),
      d$title,
      if (!substr(d$title, nchar(d$title), nchar(d$title)) %in% c("?", "!")) {
        ". "
      } else {
        " "
      },
      paste0("*", d$publication, "*, "),
      d$volume, ", ",
      d$pages, ". ",
      if ("doi" %in% names(d)) {
        paste0("[https://doi.org/", d$doi, "](https://doi.org/", d$doi, ")  \n")
      } else {
        "  \n"
      },
      ":::\n",
      "\n"
    ))
  }
}

#' Insert talks into your CV
#'
#' @description `qcv_insert_talks` converts a structured list (typically
#' imported from a YAML file) into Quarto-style markdown text (including HTML/CSS
#' where necessary) to be rendered as a list of talks. Note that the code
#' chunk in which this function is run should be given the `output: asis` option.
#'
#' @param data A list in the format expected by the `qcvutils` package. See
#' `data(qcvexample)` for an example.
#'
#' @returns Markdown text to be rendered with Quarto.
#'
#' @examples
#' data(qcvexample)
#' talks <- qcvexample$talks
#' qcv_insert_talks(talks)
#'
#' @seealso [qcv_insert](), [qcv_insert_pubs](), [qcv_insert_list]()
#'
#' @export
qcv_insert_talks <- function(data) {
  # Loop through each element of data
  for (i in 1:length(data)) {
    # Get focal element
    d <- data[[i]]
    # Generate output text
    cat(paste0(
      ":::{}\n",
      rev(1:length(data))[i], ". ",
      if (length(d$authors) > 1) {
        paste0(paste0(d$authors, collapse = ", "), ". ")
      } else {
        paste0(d$authors, ". ")
      },
      paste0("(", d$date, "). "),
      d$title,
      if (!substr(d$title, nchar(d$title), nchar(d$title)) %in% c("?", "!")) {
        ". "
      } else {
        " "
      },
      d$context, ".\n",
      ":::\n",
      "\n"
    ))
  }
}

#' Insert a list into your CV
#'
#' @description `qcv_insert_list` converts a structured list (typically imported
#' from a YAML file) into Quarto-style markdown text (including HTML/CSS
#' where necessary) to be rendered as a CV section. Note that the code chunk in
#' which this function is run should be given the `output: asis` option.
#'
#' @param data A list in the format expected by the `qcvutils` package. See
#' `data(qcvexample)` for an example.
#' @param type Type of list to insert. Choose from among:
#' - `"u"`: unordered list
#' - `"1"`: numbered list
#' - `"a"`: alphabetical list
#' - `"n"`: no bullets
#'
#' @returns Markdown text to be rendered with Quarto.
#'
#' @examples
#' data(qcvexample)
#' teaching <- qcvexample$teaching
#' qcv_insert_list(teaching)
#'
#' @seealso [qcv_insert](), [qcv_insert_pubs](), [qcv_insert_talks]()
#'
#' @export
qcv_insert_list <- function(data, type = "u") {
  # Loop through each element of data
  for (i in 1:length(data)) {
    # Get focal element
    d <- data[[i]]
    # Set up spaces for details and notes
    if (type == c("u")) {
      spaces <- "  "
    } else if (type %in% c("1", "a")) {
      spaces <- "   "
    } else if (type == "n") {
      spaces <- ""
    } else {
      stop('Choose list type from among "u", "1", "a", or "n"')
    }
    # Generate output text
    cat(paste0(
      if (type == "u") {
        "* "
      } else if (type == "1") {
        "1. "
      } else if (type == "a") {
        "a. "
      },
      d$title,
      if ("details" %in% names(d)) {
        paste0(", ", d$details)
      },
      if (all(c("start", "end") %in% names(d))) {
        paste0(" [", d$start, " - ", d$end, "]{style='float:right;'}  \n")
      } else if ("start" %in% names(d)) {
        paste0(" [", d$start, "]{style='float:right;'}  \n")
      } else if ("years" %in% names(d)) {
        paste0(" [", paste0(d$years, collapse = ", "), "]{style='float:right;'}  \n")
      } else {
        "  \n"
      },
      if ("notes" %in% names(d)) {
        paste0(spaces, "[", d$notes, "]{style='display:flex; color:gray; font-size:0.8em; margin: 0px 20% 0px auto;'}\n", collapse = "")
      }
    ))
  }
}
