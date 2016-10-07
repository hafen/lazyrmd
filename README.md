# lazyrmd [![Build Status](https://travis-ci.org/hafen/lazyrmd.svg?branch=master)](https://travis-ci.org/hafen/lazyrmd)


The lazyrmd R package provides an R Markdown html output format that enables plot outputs in the document to be lazily loaded.  It is useful for large R Markdown documents with many plots, as it allows for a fast initial page load, deferring the loading of individual graphics to the time that the user navigates near them.

## Installation

```r
options(repos = c(tessera = "http://packages.tessera.io",
  getOption("repos")))
install.packages("lazyrmd")
```

or

```r
devtools::install_github("hafen/lazyrmd")
```

## Usage

To enable lazy loading, you need to do two things in your R Markdown document:

1. Change your output format from `html_document` to `lazyrmd::lazy_render` in the front-matter of your document, e.g.:

    ```yaml
    ---
    title: "Lazy Loading Test"
    author: "Ryan Hafen"
    output: lazyrmd::lazy_render
    ---
    ```

    Note that the `lazyrmd::lazy_render` is a wrapper around `rmarkdown` so all front-matter options for `rmarkdown::html_document` are valid for `lazyrmd::lazy_render`.

2. Add `lazy=TRUE` to any chunk whose output is an htmlwidget that you would like to have load lazily, e.g.:

        ```{r, lazy=TRUE}
        library(rbokeh)
        figure(width = 800) %>%
          ly_points(date, Freq, data = flightfreq,
            hover = list(date, Freq, dow), size = 5) %>%
          ly_abline(v = as.Date("2001-09-11"))
        ```

    The output of this block will not be part of the page load when viewing the resulting html document.  Instead, a blank space for the plot will be held and when the user gets close to the point in the document at which they will be viewing the plot, it will be loaded into the page.

## How it works

Currently the package only works for htmlwidget output, but adding support for lazy loading of raster graphics should be very straightforward.

For htmlwidgets, this package overrides the `knit_print.htmlwidget` method in the htmlwidgets package.  If the user has not specified that the output should be lazily loaded with `lazy=TRUE`, it passes the plot on to this default method.  However, if `lazy=TRUE` has been specified, a utility function, `print_lazy_widget()` is called which saves out the output of the plot as an independent html file and returns a placeholder for the plot.  Javascript code is automatically embedded in the html page that will cause the plot to load based on the page scrolling actions of the user.

Note that this approach is not possible with standalone html output - we must store the plots separately.  Otherwise, we would defeat the purpose of why this package was created.

For adding support for raster graphics output, I just need to get a little more acquainted with the `knit_print` method for these and the rest will be easy.

## Acknowledgements

This package uses the very lightweight [recliner.js](http://sourcey.com/recliner/) library to handle lazy loading.
