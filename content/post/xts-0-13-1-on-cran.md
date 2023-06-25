---
title: 'xts_0.13.1 on CRAN'
date: 2023-04-24T10:54:00.000-05:00
draft: false
aliases: [ "/2023/04/xts-0-13-1-on-cran.html" ]
tags : [Releases, xts, R]
---

An updated version of [xts](http://cran.r-project.org/package=xts) is now on [CRAN](http://cran.r-project.org/). This release patches a few issues with the features added in version 0.13.0 and addresses a few maintenance issues that popped up recently.

<!--more-->

### Patches for features added in 0.13.0

* Format each column individually before printing. The top/bottom rows could have a different number of decimal places and there are often multiple varying spaces between columns. For example:

    ```r
                              close      volume          ma
    2022-01-03 09:31:00     476.470  803961.000          NA
    2022-01-03 09:32:00     476.700  179476.000          NA
    2022-01-03 09:33:00     476.540  197919.000          NA
                    ...
    2023-03-16 14:52:00    394.6000  46728.0000    392.8636
    2023-03-16 14:53:00    394.6500  64648.0000    392.8755
    2023-03-16 14:54:00    394.6500  69900.0000    392.8873
    ```

    There are 4 spaces between the index and the 'close' column, 2 between 'close' and 'volume', and 4 between 'volume' and 'ma'. There should be a consistent number of spaces between the columns. Most other classes of objects print with 1 space between the columns. The top rows have 3 decimals and the bottom rows have 4. These should also be the same. ([#321](https://github.com/joshuaulrich/xts/issues/321))

* Make column names based on number of columns. The original code was a lot more complicated because it tried to account for truncating the number of printed columns. That functionality was removed because of how complicated it was. So now we can simply create printed column names from the number of columns. ([#395](https://github.com/joshuaulrich/xts/issues/395))

* Only convert printed index values to character. Converting the entire index to character is time-consuming for xts objects with many observations. It can take more than a second to print an xts object with 1 million observations.

* Reduce instances when `dplyr::lag()` warning is shown. The warning was shown whenever it detected dplyr is installed, even if the user wasn't actively using dplyr. That caused an excessive amount of noise when other packages attached xts (e.g. quantmod). Thanks to Duncan Murdoch for the report and suggested fix! ([#393](https://github.com/joshuaulrich/xts/issues/393))

### Bug Fixes

* Return 'POSIXct' if object has no 'tclass'. An empty string is not a valid 'tclass', so it can cause an error.

* Fix `xts()` for zero-row data.frames. The `xts()` constructor would create an object with a list for coredata when `x` is a data.frame with no rows. xts objects can't have lists as coredata, so it should convert `x` to a matrix and throw an error if `x` is a list. ([#394](https://github.com/joshuaulrich/xts/issues/394))

* Fix `as.data.frame()` when converting a data.frame with column names to xts when there's only one non-time-based column. Previously the xts object would not have the data.frame column name. ([#391](https://github.com/joshuaulrich/xts/issues/391))

* Treat `NA` the same as `NULL` for 'start' or 'end' in `window.xts()`. `NULL` represents an undefined index value and `NA` represents an unknown or missing index value. xts does not allow `NA` as index values, so subsetting an xts or zoo object by `NA` returns a zero-length object. Therefore a `NA` (unknown) index value is essentially the same as an undefined index value. ([#383](https://github.com/joshuaulrich/xts/issues/383), [#345](https://github.com/joshuaulrich/xts/issues/345))

* Warn and remove `NA` when `periodicity()` called on date-time vector with any `NA` values. Previously it threw the uninformative error below. ([#289](https://github.com/joshuaulrich/xts/issues/289))

    ```r
    Error in try.xts(x, error = "'x' needs to be timeBased or xtsible") :
      'x' needs to be timeBased or xtsible
    ```

* Account for timezones when making names for the list `split.xts()` creates. This was specifically a problem if the xts object's index was `yearmon` because `as.yearmon.POSIXct()` always sets `tz = "GMT"` when calling `as.POSIXlt()`, regardless of the xts' index 'tzone' attribute.  That can cause the `as.yearmon()` results to be different days for GMT and the index's timezone. Use `format.POSIXct()` for "months" because it checks for a 'tzone' attribute before converting to POSIXlt and calling `format.POSIXlt()`. The conversion to POSIXlt is important because it checks and uses the 'tzone' attribute before considering the 'tz' argument. So it effectively ignores the `tz = "GMT"` setting in `as.yearmon()`. This is also the reason for calling `as.POSIXlt()` before calling `as.yearqtr()`. ([#392](https://github.com/joshuaulrich/xts/issues/392))

* Ignore attribute order in `all.equal()`. Attribute order shouldn't matter. That can be checked with `identical()`.

### Chores

* Add notes on `plot.xts()` nomenclature and structure. Also add ASCII art to illustrate definitions and layout. ([#103](https://github.com/joshuaulrich/xts/issues/103))

* Register missing S3 methods and update signatures. With R-devel (83995-ish), `R CMD check` notes these S3 methods are not registered. It also notes that the signatures for `as.POSIXct.tis()` and `str.replot_xts()` do not match the respective generics. `R CMD check` also thinks `time.frequency()` is a S3 method because `time()` is a generic. The function isn't exported, so renaming won't break any external code. Thanks to Kurt Hornik for the report. Issues with functionality for 'tis' were also identified. I removed 'tis' support entirely because the implementation was not even a bare minimum, and it's not clear it even worked correctly. ([#398](https://github.com/joshuaulrich/xts/issues/398))

* Add instructions to update old objects. Old xts objects do not have 'tclass' and 'tzone' attributes on the index. Add a function to update the object attributes and add a note to the warning to show how to use it. Also, only call `tzone()` and `tclass()` once in `check.TZ()`. Calling these functions multiple times throws multiple warnings for xts objects created before the 'tclass' and 'tzone' were attached to the index instead of the xts object. ([#306](https://github.com/joshuaulrich/xts/issues/306))

{{< package-release-footer id="package-release-footer.html" package="xts" >}}
