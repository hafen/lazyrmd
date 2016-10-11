## Comments

Made some minor updates to extend the functionality and some updates to fix vignette display issues on CRAN.  Thank you for your time!

There two vignette rendering warnings at https://cran.rstudio.com/web/checks/check_results_lazyrmd.html , but these are warnings caused by knitr.  (I am following rstudio's instructions on how to render a html_document here: http://rmarkdown.rstudio.com/package_vignette_format.html)

Best,
Ryan


## R CMD check results
#### Test environments and R CMD check results

Test Environments
* travis-ci - ubuntu 12.04 (on travis-ci, x86_64-pc-linux-gnu), R 3.3.1
  * 0 errors | 0 warnings | 0 notes

* local OS X install (x86_64-apple-darwin13.4.0), R 3.3.1
  * 0 errors | 0 warnings | 1 note
    * checking CRAN incoming feasibility ... NOTE
    Maintainer: ‘Ryan Hafen <rhafen@gmail.com>’

    License components with restrictions and base license permitting such:
      MIT + file LICENSE
    File 'LICENSE':
      YEAR: 2016
      COPYRIGHT HOLDER: Ryan Hafen, Barret Schloerke, jQuery Foundation, Sourcey

* win-builder (devel and release)
  * 0 errors | 0 warnings | 1 note
    * checking CRAN incoming feasibility ... NOTE
    Maintainer: ‘Ryan Hafen <rhafen@gmail.com>’

    License components with restrictions and base license permitting such:
      MIT + file LICENSE
    File 'LICENSE':
      YEAR: 2016
      COPYRIGHT HOLDER: Ryan Hafen, Barret Schloerke, jQuery Foundation, Sourcey

    Possibly mis-spelled words in DESCRIPTION:
      html (9:28)

## Reverse dependencies

There are no reverse dependencies.
