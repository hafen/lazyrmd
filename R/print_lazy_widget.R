#' @importFrom knitr knit_print
#' @importFrom htmlwidgets saveWidget
#' @importFrom htmltools tags save_html
#' @importFrom digest digest
#' @importFrom jsonlite toJSON
print_lazy_widget <- function(p, dir = "lazy_widgets", options = NULL) {

  if (is.null(p$height))
    p$height <- 540

  if (is.null(p$width))
    p$width <- 500

  if (!file.exists(dir))
    dir.create(dir, recursive = TRUE)

  to_html <- getFromNamespace("toHTML", "htmlwidgets")
  a <- to_html(p, standalone = FALSE, knitrOptions = options)

  # remove but store class so we can add it in when lazy rendering
  cls <- ""
  ind <- which(sapply(a[[1]], function(x)
    htmltools::tagHasAttribute(x, "class")))
  if (length(ind) == 1) {
    cls <- a[[1]][[ind]]$attribs$class
    a[[1]][[ind]]$attribs$class <- "lazy-widget"
    a[[1]][[ind]] <- htmltools::tagAppendChild(a[[1]][[ind]],
      htmltools::div(class = "lazy-loading"))
    a[[1]][[ind]] <- htmltools::tagAppendChild(a[[1]][[ind]],
      htmltools::div(class = "lazy-loading-text", "lazy loading..."))
  }

  # store id and script contents so we can add it in when lazy rendering
  ind <- which(sapply(a, function(x) {
    atr <- htmltools::tagGetAttribute(x, "type")
    length(atr) > 0 && atr == "application/json"
  }))
  id <- htmltools::tagGetAttribute(a[[ind[1]]], "data-for")
  # append id to script tag so we can access it to apply script content
  sid <- paste0(id, "-script")
  a[[ind[1]]] <- htmltools::tagAppendAttributes(a[[ind[1]]], id = sid)

  script_content <- a[[ind]]$children[[1]]
  a[[ind]]$children <- ""

  filename <- paste0(id, ".jsonp")

  id2 <- gsub("htmlwidget-", "", id)
  cat(paste0("cb", id2, "(",
    jsonlite::toJSON(
      list(class = cls, id = id, sid = sid, script = script_content),
      auto_unbox = TRUE), ")"),
    file = file.path(normalizePath(dir), filename))

  a <- htmltools::attachDependencies(
    a,
    list(
      html_dependency_jquery(),
      html_dependency_lazyload()
    ),
    append = TRUE
  )

  knitr::knit_print(a, options = options)
}
