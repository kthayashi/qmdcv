#' Insert entries into your CV
#' @description `insert()` converts a list of CV entry data into Quarto-style
#' Markdown text.
#' @param data A list of one or more lists, where each sub-list contains CV
#' entry data. See `data(example_data)` for an example.
#' @details The following sub-list elements are recognized:
#' - `title` (string)
#' - `start` (string)
#' - `end` (string)
#' - `years` (string or vector; `start/end` takes precedent)
#' - `details` (string or vector)
#' - `notes` (string or vector)
#' @returns Markdown text to be rendered with Quarto.
#' @examples
#' data(example_data)
#' edu <- example_data$education
#' insert(edu)
#' @seealso [insert_pubs()], [insert_talks()], [insert_list()]
#' @export
insert <- function(data) {
  for (i in 1:length(data)) {
    d <- data[[i]]
    cat(paste0(
      "::::::{.columns}\n",
      ":::{.column style='width:80%; text-align:left;'}\n",
      if ("title" %in% names(d)) {
        paste0("**", d$title, "**  \n")
      },
      if ("details" %in% names(d)) {
        paste0(d$details, "  \n", collapse = "")
      },
      if ("notes" %in% names(d)) {
        paste0("[", d$notes, "]{style='display:flex; color:gray; font-size:0.8em; margin: 0px auto;'}\n", collapse = "")
      },
      ":::\n",
      ":::{.column style='width:20%; text-align:right;'}\n",
      if (all(c("start", "end") %in% names(d))) {
        paste0(d$start, " - ", d$end, "\n")
      } else if ("start" %in% names(d)) {
        paste0(d$start, "\n")
      } else if ("years" %in% names(d)) {
        paste0(paste0(d$years, collapse = ", "), "\n")
      },
      ":::\n",
      "::::::\n",
      "\n"
    ))
  }
}

#' Insert publications into your CV
#' @description `insert_pubs()` converts a list of publication data into
#' Quarto-style Markdown text. This function only supports journal articles at
#' present.
#' @param data A list of one or more lists, where each sub-list contains
#' publication data. See `data(example_data)` for an example.
#' @details The following sub-list elements are recognized:
#' - `authors` (string or vector)
#' - `year` (string)
#' - `title` (string)
#' - `publication` (string)
#' - `volume` (string)
#' - `pages` (string)
#' - `doi` (string)
#' @returns Markdown text to be rendered with Quarto.
#' @examples
#' data(example_data)
#' pubs <- example_data$publications$articles
#' insert_pubs(pubs)
#' @seealso [insert()], [insert_talks()], [insert_list()]
#' @export
insert_pubs <- function(data) {
  for (i in 1:length(data)) {
    d <- data[[i]]
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
#' @description `insert_talks()` converts a structured list into Quarto-style
#' Markdown text to be rendered as a list of talks.
#' @param data A list in the format expected by the `qmdcv` package. See
#' `data(example_data)` for an example.
#' @details Note: the code chunk in which this function is run should be given
#' the option `output: asis`
#' @returns Markdown text to be rendered with Quarto.
#' @examples
#' data(example_data)
#' talks <- example_data$talks
#' insert_talks(talks)
#' @seealso [insert()], [insert_pubs()], [insert_list()]
#' @export
insert_talks <- function(data) {
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
#' @description `insert_list()` converts a structured list into Quarto-style
#' Markdown text to be rendered as a list.
#' @param data A list in the format expected by the `qmdcv` package. See
#' `data(example_data)` for an example.
#' @param type Type of list to insert. Choose from among:
#' - `"u"`: unordered list
#' - `"1"`: numbered list
#' - `"a"`: alphabetical list
#' - `"n"`: no bullets
#' @details This function is currently known to provide undesirable output when
#' supplied `title` and/or `details` are long AND `start`/`end`/`years` are
#' provided. When using this function, one should ideally supply only short
#' `title` and `details`. If longer `title` and/or `details` are needed,
#' consider using [insert()].
#' @details Note: the code chunk in which this function is run should be given
#' the option `output: asis`
#' @returns Markdown text to be rendered with Quarto.
#' @examples
#' data(example_data)
#' teaching <- example_data$teaching
#' insert_list(teaching)
#' @seealso [insert()], [insert_pubs()], [insert_talks()]
#' @export
insert_list <- function(data, type = "u") {
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
