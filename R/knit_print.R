#' A custom knitr print method for htmlwidgets
#'
#' @param x an R object to be printed
#' @param \ldots additional arguments passed to the htmlwidgets \code{knit_print} method
#' @param options knitr options
#'
#' @export
#' @importFrom utils getFromNamespace
knit_print.htmlwidget <- function (x, ..., options = NULL) {
  if (!is.null(options$lazy) && options$lazy) {
    print_lazy_widget(x, options = options)
  } else {
    print_widget <- getFromNamespace("knit_print.htmlwidget", "htmlwidgets")
    print_widget(x, ..., options = options)
  }
}

# #' @export
# knit_print.ggplot <- function(x, ..., options = NULL) {
#   if (!is.null(options$lazy) && options$lazy) {
#     knitr:::knit_print.default(x, ..., options = options)
#   } else {
#     knitr:::knit_print.default(x, ..., options = options)
#   }
# }

# # p <- qplot(mpg, wt, data = mtcars, colour = I("red"))
# # a <- knitr:::knit_print.default(p)

# #' @export
# hook_plot_md <- function(x, options) {
#   message("wootywoot")
# }
