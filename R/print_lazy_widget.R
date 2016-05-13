#' @importFrom knitr knit_print
#' @importFrom htmlwidgets saveWidget
#' @importFrom htmltools tags save_html
#' @importFrom digest digest
print_lazy_widget <- function(p, dir = "lazy_widgets", options = NULL) {

  out_dir <- file.path(dir, digest::digest(p))
  if(!file.exists(out_dir))
    dir.create(out_dir, recursive = TRUE)

  a <- htmlwidgets:::toHTML(p, standalone = FALSE, knitrOptions = options)
  htmltools::save_html(a, file = file.path(normalizePath(out_dir), "index.html"))

  # htmlwidgets::saveWidget(p, file = file.path(normalizePath(dir), "index.html"))

  res <- tags$div(
    style = sprintf("display: flex; width: %dpx; height: %dpx; overflow: hidden", p$width + 20, p$height + 20),
    tags$div(style = sprintf("background: white; position: absolute; top: 0px, left: 0px; width: %dpx; height: %dpx;", p$width + 20, p$height + 20)),
    tags$iframe(
      class = "widget-lazyload lazy-loading",
      width = p$width + 20,
      height = p$height + 20,
      frameborder = "0",
      webkitallowfullscreen = "",
      mozallowfullscreen = "",
      allowfullscreen = "",
      sandbox = "allow-forms allow-scripts allow-popups allow-same-origin allow-pointer-lock",
      "data-src" = sprintf("%s/index.html", out_dir)
    )
  )
  knitr::knit_print(res, options = options)
}
