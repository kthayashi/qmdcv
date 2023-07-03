#' Insert a CV entry
#'
#' @description `qcv_insert` converts a structured list (typically imported
#' from a YAML file) into literal markdown text and HTML code to be rendered
#' with Quarto. Note that the code chunk in which this function is run should
#' be given the `output: asis` option.
#'
#' @param data A list in the format expected by the `qcvutils` package. See
#' `data(qcvexample)` for an example.
#'
#' @returns Literal markdown text and HTML code to be rendered with Quarto
#'
#' @examples
#' data(qcvexample)
#' edu <- qcvexample$education
#' qcv_insert(edu)
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
        cat(paste0("**", d$title, "**  \n"))
        cat(paste0(d$details, "  \n", collapse = ""))
        if ("notes" %in% names(d)) {
          cat("[", paste0(d$notes, "]{style='color:gray; font-size:0.8em; vertical-align:top;'}  \n", collapse = ""))
        }
      cat(":::\n")
      cat(":::{.column style='width:20%; text-align:right;'}\n")
        cat(paste0(d$start, " - ", d$end, "\n"))
      cat(":::\n")
    cat("::::::\n")
    cat("\n")
  }
}
