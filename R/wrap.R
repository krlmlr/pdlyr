.compat_env <- new.env(parent = emptyenv())
.compat_env$compat <- plyr_compat

#' Active compatibility layer
#'
#' These functions set and return the active compatibility layer.
#' Functions from the active compatibility layer will be used when calling
#' \code{\link{count}}, \code{\link{mutate}} or \code{\link{rename}} from
#' this package.
#'
#' @name pdlyr_compat
#' @param x A compatibility layer, e.g., one described in \code{\link{compat}}
#' @return The active or old compatibility layer (for \code{*_compat}); the
#'   wrapped function (for \code{*_wrapper}).
get_pdlyr_compat <- function() {
  .compat_env[["compat"]]
}

#' @rdname pdlyr_compat
set_pdlyr_compat <- function(compat) {
  if (!is.list(compat) || sort(names(compat)) != c("count", "mutate", "rename") ||
      any(!vapply(compat, is.function, logical()))) {
    stop("compat must be a named list with three functions count, mutate and rename")
  }

  old_compat <- .compat_env[["compat"]]
  .compat_env[["compat"]] <- compat
  old_compat
}

#' @rdname pdlyr_compat
get_count_wrapper <- function() {
  .compat_env[["compat"]][["count"]]
}

#' @rdname pdlyr_compat
get_mutate_wrapper <- function() {
  .compat_env[["compat"]][["mutate"]]
}

#' @rdname pdlyr_compat
get_rename_wrapper <- function() {
  .compat_env[["compat"]][["rename"]]
}

makeActiveBinding("count", get_count_wrapper, asNamespace("pdlyr"))
makeActiveBinding("mutate", get_mutate_wrapper, asNamespace("pdlyr"))
makeActiveBinding("rename", get_rename_wrapper, asNamespace("pdlyr"))
