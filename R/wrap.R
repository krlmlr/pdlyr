.compat_env <- new.env(parent = emptyenv())
.compat_env$compat <- plyr_compat

get_pdlyr_compat <- function() {
  .compat_env[["compat"]]
}

set_pdlyr_compat <- function(compat) {
  if (!is.list(compat) || sort(names(compat)) != c("count", "mutate", "rename") ||
      any(!vapply(compat, is.function, logical()))) {
    stop("compat must be a named list with three functions count, mutate and rename")
  }

  .compat_env[["compat"]] <- compat
}

get_count_wrapper <- function() {
  .compat_env[["compat"]][["count"]]
}

get_mutate_wrapper <- function() {
  .compat_env[["compat"]][["mutate"]]
}

get_rename_wrapper <- function() {
  .compat_env[["compat"]][["rename"]]
}

makeActiveBinding("count", get_count_wrapper, asNamespace("pdlyr"))
makeActiveBinding("mutate", get_mutate_wrapper, asNamespace("pdlyr"))
makeActiveBinding("rename", get_rename_wrapper, asNamespace("pdlyr"))
