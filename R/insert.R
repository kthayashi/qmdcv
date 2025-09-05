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

#' Insert a list into a CV
#'
#' Convert a list of CV entries into a Quarto-style Markdown list.
#'
#' @param x A YAML-style list of CV entries. The following elements are
#' recognized for each entry:
#' * `title` (string)
#' * `start` (string)
#' * `end` (string)
#' * `years` (string or vector)
#' * `notes` (string or vector)
#' @param type The type of list to insert. Choose from among:
#' - `"u"`: unordered
#' - `"1"`: numbered
#' - `"a"`: alphabetical
#' - `"n"`: no bullets
#'
#' @note This function can produce suboptimal results upon render when the
#' supplied `title` and/or `details` are long AND dates (`start`, `end`,
#' `years`) are supplied. When using this function, it is safest to supply only
#' short `title` and `details`. If longer `title` or `details` are desired,
#' consider using [insert()].
#'
#' @returns None (invisible `NULL`).
#' @export
#'
#' @examples
#' data(cvdata)
#' insert_list(cvdata$teaching)
insert_list <- function(x, type = "u") {
  stopifnot(
    length(type) == 1,
    type %in% c("u", "1", "a", "n")
  )
  for (i in 1:length(x)) {
    d <- x[[i]]
    if (type == c("u")) {
      spaces <- "  "
    } else if (type %in% c("1", "a")) {
      spaces <- "   "
    } else if (type == "n") {
      spaces <- ""
    }
    cat(
      paste0(
        if (type == "u") {
          "* "
        } else if (type == "1") {
          "1. "
        } else if (type == "a") {
          "a. "
        },
        d$title,
        if (all(c("start", "end") %in% names(d))) {
          paste0(" [", d$start, "--", d$end, "]{style='float:right;'}  \n")
        } else if ("start" %in% names(d)) {
          paste0(" [", d$start, "]{style='float:right;'}  \n")
        } else if ("years" %in% names(d)) {
          paste0(" [", paste0(d$years, collapse = ", "), "]{style='float:right;'}  \n")
        } else {
          "  \n"
        },
        if ("notes" %in% names(d)) {
          paste0(
            spaces,
            "[",
            d$notes,
            "]{style='display:flex; color:gray; font-size:0.8em; margin: 0px 20% 0px auto;'}\n",
            collapse = ""
          )
        }
      )
    )
  }
}
