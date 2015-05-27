.compat_env <- new.env(parent = emptyenv())
.compat_env$compat <- plyr_compat

#' Active compatibility layer
#'
#' These functions set and return the active compatibility layer.
#' Functions from the active compatibility layer will be used when calling
#' \code{\link{count}}, \code{\link{mutate}} or \code{\link{rename}} from
#' this package.
#' Initially, \code{\link{plyr_compat}} is the active compatibility layer.
#'
#' @name pdlyr_compat
#' @param compat A compatibility layer, e.g., one described in \code{\link{compat}}
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

#' Wrapped count function
#'
#' This active binding returns \code{get_count_wrapper()}.
#' Thus, the interface and the results of calling \code{count()}
#' from this package depend on the currently active compatibility layer.
#' When the package, is loaded the \code{\link{plyr_compat}} layer is active;
#' this documentation reflects the interface presented by that layer.
#'
#' @inheritParams plyr::count
#' @seealso \code{\link{pdlyr_compat}}
"count"
makeActiveBinding("count", get_count_wrapper, asNamespace("pdlyr"))

#' Wrapped mutate function
#'
#' This active binding returns \code{get_mutate_wrapper()}.
#' Thus, the interface and the results of calling \code{mutate()}
#' from this package depend on the currently active compatibility layer.
#' When the package, is loaded the \code{\link{plyr_compat}} layer is active;
#' this documentation reflects the interface presented by that layer.
#'
#' @inheritParams plyr::mutate
#' @seealso \code{\link{pdlyr_compat}}
"mutate"
makeActiveBinding("mutate", get_mutate_wrapper, asNamespace("pdlyr"))

#' Wrapped rename function
#'
#' This active binding returns \code{get_rename_wrapper()}.
#' Thus, the interface and the results of calling \code{rename()}
#' from this package depend on the currently active compatibility layer.
#' When the package, is loaded the \code{\link{plyr_compat}} layer is active;
#' this documentation reflects the interface presented by that layer.
#'
#' @inheritParams plyr::rename
#' @seealso \code{\link{pdlyr_compat}}
"rename"
makeActiveBinding("rename", get_rename_wrapper, asNamespace("pdlyr"))
