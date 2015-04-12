context("plyr-warn")

call_compat <- function(compat, names = c("mutate", "count", "rename")) {
  lapply(
    setNames(nm = names),
    function(name) {
      switch(
        name,
        mutate = compat$mutate(.data = mtcars, a = 0),
        count = compat$count(df = mtcars, vars = "cyl", wt_var = NULL),
        rename = compat$rename(x = mtcars, list(mpg = "miles_per_gallon"),
                               warn_missing = TRUE)
      )
    }
  )
}

test_that("warnings are thrown", {
  expect_warning(call_compat(plyr_warn_compat), "^Semantics", all = TRUE)
  expect_warning(call_compat(plyr_warn_compat, "mutate"),
                 "Row names", all = FALSE)
  expect_warning(call_compat(plyr_warn_compat, "count"),
                 "Interface", all = FALSE)
  expect_warning(call_compat(plyr_warn_compat, "rename"),
                 "Entirely different interface", all = FALSE)
})

test_that("otherwise identical to plyr", {
  expect_equal(suppressWarnings(call_compat(plyr_warn_compat)),
               call_compat(plyr_compat))
})
