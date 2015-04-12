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
