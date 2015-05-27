- active compatibility layer via `get_pdlyr_compat()` and `set_pdlyr_compat()?`
- access wrappers from active compatibility layer via `get_*_wrapper()`
- export `count`, `mutate` and `rename` as active bindings that return the currently active wrappers

Version 0.0-2.4 (2015-05-27)
===

- import all of `plyr` and `dplyr` (when attached and not loaded)
- add vignettes to version control

Version 0.0-2.3 (2015-05-27)
===

- Testing with Wercker, coverage with codecov.io
- staticdocs

Version 0.0-2.2 (2015-04-12)
===

- new compatibility layer `plyr_warn_compat` that still is fully compatible with plyr but issues a warning

Version 0.0-2.1 (2015-04-12)
===

- Compatibility layer is now implemented as list that can be `attach()`ed, in order to later support different kinds of compatibility
- Remove short-form pointers to original plyr implementations, the goal is transition to `dplyr`.


Version 0.0-2 (2015-04-11)
===

- Add short-form pointers to original plyr implementations: `pmutate`, `pcount` and `prename`


Version 0.0-1 (2015-04-11)
===

- Initial version: compatibility wrappers for `mutate`, `count` and `rename`
