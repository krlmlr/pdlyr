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
#'   \item{plyr_compat}{Full compatibility, the original \code{plyr}
#'     implementation is used.
#'     You should be able to run your existing code without modifications.}
#'   \item{plyr_warn_compat}{Same as \code{plyr_compat},
#'     but emit a warning for each call of the affected functions.}
#'   \item{dplyr_compat}{Full compatibility with \code{dplyr}}
#' }
#'
#' @rdname compat
#' @importFrom plyr id
#' @include wrap.R
plyr_compat <- list(
  mutate = pmutate,
  count = pcount,
  rename = prename
)

#' @rdname compat
#' @include wrap.R
plyr_warn_compat <- list(
  mutate = function(.data, ...) {
    plyr_warn("mutate", "Row names will be lost")
    pmutate(.data = .data, ...)
  },
  count = function(df, vars = NULL, wt_var = NULL) {
    plyr_warn("count", "Interface and name of count variable have changed")
    pcount(df = df, vars = vars, wt_var = wt_var)
  },
  rename = function(x, replace, warn_missing = TRUE) {
    plyr_warn("rename", "Entirely different interface, lists and vectors not accepted anymore")
    prename(x = x, replace = replace, warn_missing = warn_missing)
  }
)

#' @rdname compat
#' @include wrap.R
dplyr_compat <- list(
  mutate = dmutate,
  count = dcount,
  rename = drename
)
