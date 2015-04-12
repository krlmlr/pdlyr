context("plyr")

with_compat <- function(compat, ...) {
  with_mock(
    `plyr::mutate` = compat$mutate,
    `plyr::count` = compat$count,
    `plyr::rename` = compat$rename,
    force(...)
  )
}

with_compat(plyr_compat,
  testthat::test_package("plyr")
)
