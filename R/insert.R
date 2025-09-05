#' Insert entries into a CV
#'
#' Convert a list of CV entries into Quarto-style Markdown text.
#'
#' @param x A YAML-style list of CV entries. The following elements are
#' recognized for each entry:
#' * `title` (string)
#' * `start` (string)
#' * `end` (string)
#' * `years` (string or vector)
#' * `details` (string or vector)
#' * `notes` (string or vector)
#'
#' @returns None (invisible `NULL`).
#' @export
#'
#' @examples
#' data(cvdata)
#' insert(cvdata$education)
insert <- function(x) {
  for (i in 1:length(x)) {
    d <- x[[i]]
    cat(
      paste0(
        ":::{.columns}\n",
        ":::{.column style='width:80%; text-align:left;'}\n",
        if ("title" %in% names(d)) {
          paste0("**", d$title, "**  \n")
        },
        if ("details" %in% names(d)) {
          paste0(d$details, "  \n", collapse = "")
        },
        if ("notes" %in% names(d)) {
          paste0(
            "[",
            d$notes,
            "]{style='display:flex; color:gray; font-size:0.8em; margin: 0px auto;'}\n",
            collapse = ""
          )
        },
        ":::\n",
        ":::{.column style='width:20%; text-align:right;'}\n",
        if (all(c("start", "end") %in% names(d))) {
          paste0(d$start, "--", d$end, "\n")
        } else if ("start" %in% names(d)) {
          paste0(d$start, "\n")
        } else if ("years" %in% names(d)) {
          paste0(paste0(d$years, collapse = ", "), "\n")
        },
        ":::\n",
        ":::\n",
        "\n"
      )
    )
  }
}

#' Insert publications into a CV
#'
#' Convert a list of publications into a Quarto-style Markdown list. Several
#' alias functions are provided for other item types.
#'
#' @param x A YAML-style list of publications etc. The following elements are
#' recognized for each item:
#' - `citation` (string)
#' - `notes` (string or vector)
#'
#' @returns None (invisible `NULL`).
#' @export
#'
#' @examples
#' data(cvdata)
#' insert_publications(cvdata$publications)
insert_publications <- function(x) {
  for (i in 1:length(x)) {
    d <- x[[i]]
    cat(
      paste0(
        ":::{}\n",
        rev(1:length(x))[i], ". ",
        if ("citation" %in% names(d)) {
          paste0(d$citation, "  \n")
        },
        if ("notes" %in% names(d)) {
          paste0(
            "[",
            d$notes,
            "]{style='display:flex; color:gray; font-size:0.8em; margin: 0px auto;'}\n",
            collapse = ""
          )
        },
        ":::\n",
        "\n"
      )
    )
  }
}

#' @rdname insert_publications
#' @export
insert_code <- function(x) {
  insert_publications(x)
}

#' @rdname insert_publications
#' @export
insert_data <- function(x) {
  insert_publications(x)
}

#' @rdname insert_publications
#' @export
insert_presentations <- function(x) {
  insert_publications(x)
}

#' @rdname insert_publications
#' @export
insert_talks <- function(x) {
  insert_publications(x)
}

#' Insert a list into your CV
#' @description `insert_list()` converts list data into Quarto-style
#' Markdown text. Lists produced by this function can be unordered, numbered,
#' alphabetical, or without bullets.
#' @param data A list of one or more lists, where each sub-list contains
#' list data. See `data(cvdata)` for an example.
#' @param type Type of list to insert. Choose from among:
#' - `"u"`: unordered list
#' - `"1"`: numbered list
#' - `"a"`: alphabetical list
#' - `"n"`: no bullets
#' @details The following sub-list elements are recognized:
#' - `title` (string)
#' - `start` (string)
#' - `end` (string)
#' - `years` (string or vector; `start/end` takes precedent)
#' - `details` (string)
#' - `notes` (string or vector)
#' @note This function is currently known to provide undesirable output when
#' supplied `title` and/or `details` are long AND `start`/`end`/`years` are
#' provided. When using this function, one should ideally supply only short
#' `title` and `details`. If longer `title` and/or `details` are needed,
#' consider using [insert()].
#' @returns Markdown text to be rendered with Quarto.
#' @examples
#' data(cvdata)
#' teaching <- cvdata$teaching
#' insert_list(teaching)
#' @export
insert_list <- function(data, type = "u") {
  for (i in 1:length(data)) {
    d <- data[[i]]
    if (type == c("u")) {
      spaces <- "  "
    } else if (type %in% c("1", "a")) {
      spaces <- "   "
    } else if (type == "n") {
      spaces <- ""
    } else {
      stop('Choose list type from among "u", "1", "a", or "n"')
    }
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
