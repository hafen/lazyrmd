#' Provide HTML dependencies for lazyhtml R Markdown format
#'
#' @export
html_dependency_recliner <- function() {
  htmltools::htmlDependency(
    name = "recliner",
    version = "0.2.2",
    src = system.file("deps/recliner", package = "lazyrmd"),
    script = c("recliner.min.js", "onload.js"),
    stylesheet = "recliner.css"
  )
}

#' Format for converting from R Markdown to an HTML document with lazy loading of graphics
#'
#' @param \ldots parameters passed to \code{\link[rmarkdown]{html_document}}
#' @importFrom rmarkdown html_document html_dependency_jquery
#' @export
#' @examples
#' if (interactive()) browseURL("https://github.com/hafen/lazyrmd#usage")
lazyhtml_document <- function(...) {
  dots <- list(...)
  dots$extra_dependencies <- c(dots$extra_dependencies,
    list(html_dependency_jquery(), html_dependency_recliner()))

  do.call(rmarkdown::html_document, dots)
}
