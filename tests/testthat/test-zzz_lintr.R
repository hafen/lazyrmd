
context("true")

test_that("true", {
  expect_true(TRUE)
})

# https://github.com/jimhester/lintr
if (requireNamespace("lintr", quietly = TRUE)) {
  context("lints")
  test_that("Package Style", {
    lintr::expect_lint_free(cache = TRUE)
  })
}
