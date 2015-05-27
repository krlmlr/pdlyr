\name{NEWS}
\title{News for Package 'pdlyr'}
\encoding{UTF-8}
\section{Changes in pdlyr version 0.0-2.4 (2015-05-27)}{
  \itemize{
    \item import all of \code{plyr} and \code{dplyr} (when attached and not loaded)
    \item add vignettes to version control
  }
}
\section{Changes in pdlyr version 0.0-2.3 (2015-05-27)}{
  \itemize{
    \item Testing with Wercker, coverage with codecov.io
    \item staticdocs
  }
}
\section{Changes in pdlyr version 0.0-2.2 (2015-04-12)}{
  \itemize{
    \item new compatibility layer \code{plyr_warn_compat} that still is fully compatible with plyr but issues a warning
  }
}
\section{Changes in pdlyr version 0.0-2.1 (2015-04-12)}{
  \itemize{
    \item Compatibility layer is now implemented as list that can be \code{attach()}ed, in order to later support different kinds of compatibility
    \item Remove short-form pointers to original plyr implementations, the goal is transition to \code{dplyr}.
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
