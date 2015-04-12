# Mockable warning
plyr_warn <- function(name, expl) {
  warning("Semantics of ", name, " are different in plyr and dplyr: ",
          expl, .call = FALSE)
}

#'@docType data
#'@name compat
NULL

#' Compatibility layers
#'
#' Attach these layers via \code{attach} for various levels of
#' compatibility to the \code{plyr} package when both \code{plyr}
#' and \code{dplyr} are loaded.
#'
#' \describe{
#'   \item{\code{plyr_compat}} Full compatibility, the original \code{plyr}
#'     implementation is used.
#'     You should be able to run your code without modifications.
#'   \item{\code{plyr_warn_compat}} Same as \code{plyr_compat},
#'     but emit a warning for each call of the affected functions.
#'   \item{\code{dplyr_compat}} Use implementations from \code{dplyr}
#'     but keep the \code{plyr} interface, with warnings.
#' }
#'
#'@rdname compat
#'@export
#'@importFrom plyr id
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
#'@importFrom dplyr left_join
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
