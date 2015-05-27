## ----echo=F--------------------------------------------------------------
library(magrittr)
knit_print.data.frame = function(x, ...) {
  res = paste(c('', '', knitr::kable(x)), collapse = '\n')
  knitr::asis_output(res)
}
`knit_print.{` = function(x, ...) {
  res <- paste(c("```r", paste0(c("", rep("  ", length(x)-1)), as.character(x)), "}", "```", ""), collapse = '\n')
  knitr::asis_output(res)
}

## ------------------------------------------------------------------------
library(plyr)
library(dplyr)

## ------------------------------------------------------------------------
plyr_exports <- ls("package:plyr")
dplyr_exports <- ls("package:dplyr")
(both_exports <- intersect(plyr_exports, dplyr_exports))

## ----echo = FALSE--------------------------------------------------------
formals_df <-
  both_exports %>%
  setNames(nm = .) %>%
  lapply(
    . %>% {
      lapply(
        c("plyr", "dplyr") %>% setNames(nm = .),
        function (x) {
          get(., sprintf("package:%s", x)) %>%
            formals %>% names %>% paste(collapse = ", ")
        }
      )
    }
  ) %>%
  plyr::ldply(data.frame, stringsAsFactors = FALSE, .id = "name") %>%
  plyr::mutate(data_first = grepl("^[.]data,", dplyr) | grepl("^df,", plyr),
               identical = plyr == dplyr) %>%
  plyr::arrange(!data_first, !identical, name)

formals_df

## ----echo = FALSE--------------------------------------------------------
formals_df %>%
  subset(data_first) %>%
  plyr::mutate(data_first = NULL)

## ----echo = FALSE--------------------------------------------------------
formals_df %>%
  subset(!data_first & identical) %>%
  plyr::mutate(data_first = NULL, identical = NULL)

## ----echo = FALSE--------------------------------------------------------
body_l <-
  formals_df %>%
  subset(!data_first & identical) %>%
  extract2("name") %>%
  as.character %>%
  setNames(nm = .) %>%
  lapply(
    . %>% {
      lapply(
        c("plyr", "dplyr") %>% setNames(nm = .),
        function (x) {
          get(., sprintf("package:%s", x)) %>%
            body
        }
      )
    }
  )

## ------------------------------------------------------------------------
body_l %>%
  llply(. %>% { identical(as.character(.$plyr), as.character(.$dplyr)) } ) %>%
  ldply(. %>% data.frame(identical_body = .), .id = "name")

## ------------------------------------------------------------------------
body_l$failwith$plyr
body_l$failwith$dplyr

## ------------------------------------------------------------------------
attach(pdlyr::dplyr_compat)

## ------------------------------------------------------------------------
mtcars %>% mutate(lphkm = 100 * 3.785411784 / 1.609344 / mpg) %>% head
mtcars %>% plyr::mutate(lphkm = 100 * 3.785411784 / 1.609344 / mpg) %>% head
mtcars %>% ddply("cyl", summarize, mean_mpg = mean(mpg))
mtcars %>% ddply("cyl", plyr::summarise, mean_mpg = mean(mpg))
mtcars %>% arrange(-wt) %>% head
mtcars %>% plyr::arrange(-wt) %>% head
mtcars %>% count("gear")
mtcars %>% plyr::count("gear")
mtcars %>% rename(list(mpg = "miles_per_gallon")) %>% extract(1:2) %>% head
mtcars %>% plyr::rename(list(mpg = "miles_per_gallon")) %>% extract(1:2) %>% head

