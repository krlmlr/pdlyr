context("dplyr")

with_compat <- function(compat, ...) {
  with_mock(
    `dplyr::mutate` = compat$mutate,
    `dplyr::count` = compat$count,
    `dplyr::rename` = compat$rename,
    force(...)
  )
}

with_compat(dplyr_compat, {
  testthat::test_package("dplyr")
})
