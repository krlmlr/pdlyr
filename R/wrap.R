#' Forwarders for overlapping functions in plyr and dplyr
#'
#' Of the overlapping functions in \code{plyr} and \code{dplyr},
#' only three have a different interface and/or semantics:
#' \code{count}, \code{mutate} and \code{rename}.
#' These functions are forwarders to the corresponding functions
#' in the \code{plyr} and \code{dplyr} packages.
#' @name forward
NULL

#' @rdname forward
#' @inheritParams plyr::count
#' @seealso \code{plyr::\link[plyr]{count}}
pcount <- plyr::count

#' @rdname forward
#' @inheritParams plyr::mutate
#' @seealso \code{plyr::\link[plyr]{mutate}}
pmutate <- plyr::mutate

#' @rdname forward
#' @inheritParams plyr::rename
#' @seealso \code{plyr::\link[plyr]{rename}}
prename <- plyr::rename

#' @rdname forward
#' @inheritParams dplyr::count
#' @seealso \code{dplyr::\link[dplyr]{count}}
dcount <- dplyr::count

#' @rdname forward
#' @inheritParams dplyr::mutate
#' @seealso \code{dplyr::\link[dplyr]{mutate}}
dmutate <- dplyr::mutate

#' @rdname forward
#' @inheritParams dplyr::rename
#' @seealso \code{dplyr::\link[dplyr]{rename}}
drename <- dplyr::rename
