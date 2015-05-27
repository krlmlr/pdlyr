- `dplyr_compat` now means full compatibility to `dplyr` (i.e., the default).
- Use wrappers when defining compatibility layers

Version 0.0-3 (2015-05-27)
===

- Compatibility layer is now implemented as list that can be `attach()`ed, in order to later support different kinds of compatibility
- Available layers: `plyr_compat`, `plyr_warn_compat`, `dplyr_compat` (the latter will probably be deprecated)
- import all of `plyr` and `dplyr` except `count`, `mutate` and `rename` (to avoid warnings when attached or loaded)
- explicit wrappers for overlaps
- Testing with Wercker, coverage with codecov.io
- staticdocs
- add vignettes to version control


Version 0.0-2 (2015-04-11)
===

- Add short-form pointers to original plyr implementations: `pmutate`, `pcount` and `prename`


Version 0.0-1 (2015-04-11)
===

- Initial version: compatibility wrappers for `mutate`, `count` and `rename`
