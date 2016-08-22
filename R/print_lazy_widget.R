#' @importFrom knitr knit_print
#' @importFrom htmlwidgets saveWidget
#' @importFrom htmltools tags save_html
#' @importFrom digest digest
print_lazy_widget <- function(p, dir = "lazy_widgets", options = NULL) {

  if (is.null(p$height))
    p$height <- 540

  if (is.null(p$width))
    p$width <- 500

  if (!file.exists(dir))
    dir.create(dir, recursive = TRUE)

  filename <- paste0(digest::digest(p), ".html")


  to_html <- getFromNamespace("toHTML", "htmlwidgets")
  a <- to_html(p, standalone = FALSE, knitrOptions = options)
  htmltools::save_html(a, file = file.path(normalizePath(dir), filename))

  # htmlwidgets::saveWidget(p, file = file.path(normalizePath(dir), "index.html"))

  res <- htmltools::tags$div(
    style = sprintf("display: flex; width: %dpx; height: %dpx; overflow: hidden",
      p$width + 20, p$height + 20),
    htmltools::tags$div(
      style = sprintf(
        "background: white; position: absolute; top: 0px, left: 0px; width: %dpx; height: %dpx;",
        p$width + 20,
        p$height + 20
      )
    ),
    htmltools::tags$iframe(
      class = "widget-lazyload lazy-loading",
      width = p$width + 20,
      height = p$height + 20,
      frameborder = "0",
      webkitallowfullscreen = "",
      mozallowfullscreen = "",
      allowfullscreen = "",
      sandbox = "allow-forms allow-scripts allow-popups allow-same-origin allow-pointer-lock",
      "data-src" = file.path(dir, filename)
    )
  )
  res <- htmltools::attachDependencies(
    res,
    list(
      html_dependency_jquery(),
      html_dependency_recliner()
    )
  )
  knitr::knit_print(res, options = options)
}
