#'@export
dplyr_compat <- list(
  mutate = function(.data, ...) {
    warning("Row names will be lost")
    dplyr::mutate_(.data = .data, .dots = lazyeval::lazy_dots(...))
  },
  count = function(df, vars = NULL, wt_var = NULL) {
  .Deprecated("dplyr::count_", "plyr")
  dplyr::count_(x = df, vars = vars, wt = wt_var, sort = FALSE) %>%
    dplyr::rename(freq = n)
  },
  rename = function(x, replace, warn_missing = TRUE) {
    if (!warn_missing) {
      warning("rename now always throws an error if names are not found.")
    }
    .Deprecated("dplyr::rename_", "plyr")
    dplyr::rename_(.data = x, .dots = as.list(setNames(names(replace), unlist(replace))))
  }
)
