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
#' @param \ldots parameters passed to rmarkdown's function matching the parameter \code{rmarkdown}
#' @param lazyrmd_render_fn function used to compile the document.  Paired with the \code{lazyrmd_render_package} parameter, it defaults to \code{\link[rmarkdown]{html_document}}.
#' @param lazyrmd_render_package package used to look for the \code{lazyrmd_render_fn}.
#' @import rmarkdown
#' @export
#' @examples
#' if (interactive()) browseURL("https://github.com/hafen/lazyrmd#usage")
lazy_render <- function(
  ...,
  lazyrmd_render_fn = "html_document",
  lazyrmd_render_package = "rmarkdown"
) {
  dots <- list(...)
  # dots$extra_dependencies <- c(dots$extra_dependencies,
  #   list(html_dependency_jquery(), html_dependency_recliner()))

  fn_to_render <- get(lazyrmd_render_fn, envir = loadNamespace(lazyrmd_render_package))
  do.call(fn_to_render, dots)
}
