\name{NEWS}
\title{News for Package 'pdlyr'}
\encoding{UTF-8}
\section{Changes in pdlyr version 0.0-3 (2015-05-27)}{
  \itemize{
    \item Compatibility layer is now implemented as list that can be \code{attach()}ed, in order to later support different kinds of compatibility
    \item Available layers: \code{plyr_compat}, \code{plyr_warn_compat}, \code{dplyr_compat} (the latter will probably be deprecated)
    \item import all of \code{plyr} and \code{dplyr} except \code{count}, \code{mutate} and \code{rename} (to avoid warnings when attached or loaded)
    \item explicit wrappers for overlaps
    \item Testing with Wercker, coverage with codecov.io
    \item staticdocs
    \item add vignettes to version control
  }
}
\section{Changes in pdlyr version 0.0-2 (2015-04-11)}{
  \itemize{
    \item Add short-form pointers to original plyr implementations: \code{pmutate}, \code{pcount} and \code{prename}
  }
}
\section{Changes in pdlyr version 0.0-1 (2015-04-11)}{
  \itemize{
    \item Initial version: compatibility wrappers for \code{mutate}, \code{count} and \code{rename}
  }
}
