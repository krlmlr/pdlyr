# Mockable warning
plyr_warn <- function(name, expl) {
  warning("Semantics of ", name, " are different in plyr and dplyr: ",
          expl, .call = FALSE)
}

#' Compatibility layers
#'
#' TODO add documentation
#'
#'@rdname compat
#'@export
plyr_compat <- list(
  mutate = plyr::mutate,
  count = plyr::count,
  rename = plyr::rename
)

#'@rdname compat
#'@export
plyr_warn_compat <- list(
  mutate = function(.data, ...) {
    plyr_warn("mutate", "Row names will be lost")
    plyr::mutate(.data = .data, ...)
  },
  count = function(df, vars = NULL, wt_var = NULL) {
    plyr_warn("count", "Interface and name of count variable have changed")
    plyr::count(df = df, vars = vars, wt_var = wt_var)
  },
  rename = function(x, replace, warn_missing = TRUE) {
    plyr_warn("rename", "Entirely different interface, lists and vectors not accepted anymore")
    plyr::rename(x = x, replace = replace, warn_missing = warn_missing)
  }
)

#'@rdname compat
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
