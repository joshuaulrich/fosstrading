---
title: 'xts_0.13.0 on CRAN'
date: 2023-02-21T14:58:00.000-05:00
draft: false
tags : [Releases, xts, R]
---

An updated version of [xts](http://cran.r-project.org/package=xts) is now on [CRAN](http://cran.r-project.org/). This release adds several exciting changes: open-ended time-of-day subsetting, smarter conversions to xts from data.frames/data.tables/tibbles; `to.period()` handles custom endpoint values, `print()` truncates rows like data.table, and `str()` provides more informative output. There are also changes to make xts more consistent with zoo, some minor speed improvements, and the usual smattering of bug fixes.

<!--more-->

For some reason, I decided it was a good idea to go through the oldest GitHub issues and determine whether they should be fixed or closed without being fixed. Some of the GitHub issues are open issues from when xts was still on R-Forge! The oldest issue fixed in this release was opened on 2013-09-15, and another one was opened on 2014-03-09! Better late than never I guess. ;-)

### New Features

The coolest new feature is the ability to use open-ended ranges for time-of-day subsetting. So you can subset by time of day from the start/end of the day without providing the start/end times (i.e. 00:00:00.000/23:59:59.999). Thanks to Chris Katsulis for the suggestion! ([#243](https://github.com/joshuaulrich/xts/issues/243))

Here's an example:

```r
# an hourly sequence of times, and an xts object using them
times <- timeBasedSeq("2023-02-01/2023-02-05/H")
x <- xts(seq_along(times), times)

# function to show the first and last index values for each day
index_range_by_day <- function(x) {
    by_day <- split(x, "days")
    index_range <- function(y) {
        paste(start(y), end(y), sep = " / ")
    }
    lapply(by_day, index_range)
}

# between the start of the day and 5pm
index_range_by_day(x["/T1800"])
## $`2023-02-01`
## [1] "2023-02-01 / 2023-02-01 18:00:00"
## 
## $`2023-02-02`
## [1] "2023-02-02 / 2023-02-02 18:00:00"
## 
## $`2023-02-03`
## [1] "2023-02-03 / 2023-02-03 18:00:00"
## 
## $`2023-02-04`
## [1] "2023-02-04 / 2023-02-04 18:00:00"
## 
## $`2023-02-05`
## [1] "2023-02-05 / 2023-02-05 18:00:00"

# between 5am and the end of the day
index_range_by_day(x["T0500/"])
## $`2023-02-01`
## [1] "2023-02-01 05:00:00 / 2023-02-01 23:00:00"
## 
## $`2023-02-02`
## [1] "2023-02-02 05:00:00 / 2023-02-02 23:00:00"
## 
## $`2023-02-03`
## [1] "2023-02-03 05:00:00 / 2023-02-03 23:00:00"
## 
## $`2023-02-04`
## [1] "2023-02-04 05:00:00 / 2023-02-04 23:00:00"
## 
## $`2023-02-05`
## [1] "2023-02-05 05:00:00 / 2023-02-05 23:00:00"
```

----

You can now pass custom endpoints to `to.period()` using the 'period' argument. So you can aggregate on something other than the times that `endpoints()` supports. Thanks to Ethan B. Smith for the suggestion! ([#302](https://github.com/joshuaulrich/xts/issues/302))

```r
data(sample_matrix)
x <- as.xts(sample_matrix)

# aggregate to OHLC by week ending on Friday
week_fri <- to.period(x, endpoints(x, "weeks"))
head(week_fri)
##              x.Open   x.High    x.Low  x.Close
## 2007-01-07 50.03978 50.42188 49.95041 49.99185
## 2007-01-14 50.03555 50.62395 49.80454 50.60145
## 2007-01-21 50.61724 50.77336 50.02142 50.42090
## 2007-01-28 50.36008 50.43875 49.87468 49.88096
## 2007-02-04 49.85624 50.55509 49.76308 50.55509
## 2007-02-11 50.52389 50.91776 50.45977 50.91160

# aggregate to OHLC by week ending on Wednesday
wednesdays <- which(.indexwday(x) == 3)
week_wed <- to.period(x, wednesdays)
head(week_wed)
##              x.Open   x.High    x.Low  x.Close
## 2007-01-03 50.03978 50.42188 49.95041 50.39767
## 2007-01-10 50.42096 50.42096 49.80454 49.97246
## 2007-01-17 49.88529 50.77336 49.88529 50.48644
## 2007-01-24 50.48051 50.60712 50.02142 50.23145
## 2007-01-31 50.20738 50.28268 49.76308 50.22578
## 2007-02-07 50.22448 50.71661 50.19101 50.60611
```

### Enhancements

The release also contains some quality of life changes to `print()` and `str()`. Now `print()` only shows the first and last 'show.rows' rows (default 10) if number of rows is > 'max.rows' (default 100), similar to [data.table](https://cran.r-project.org/package=data.table) ([#321](https://github.com/joshuaulrich/xts/issues/321)).

```r
data(sample_matrix)
x <- as.xts(sample_matrix)
x
##                Open     High      Low    Close
## 2007-01-02 50.03978 50.11778 49.95041 50.11778
## 2007-01-03 50.23050 50.42188 50.23050 50.39767
## 2007-01-04 50.42096 50.42096 50.26414 50.33236
## 2007-01-05 50.37347 50.37347 50.22103 50.33459
## 2007-01-06 50.24433 50.24433 50.11121 50.18112
## 2007-01-07 50.13211 50.21561 49.99185 49.99185
## 2007-01-08 50.03555 50.10363 49.96971 49.98806
## 2007-01-09 49.99489 49.99489 49.80454 49.91333
## 2007-01-10 49.91228 50.13053 49.91228 49.97246
## 2007-01-11 49.88529 50.23910 49.88529 50.23910
##        ...                                    
## 2007-06-21 47.71012 47.71012 47.61106 47.62921
## 2007-06-22 47.56849 47.59266 47.32549 47.32549
## 2007-06-23 47.22873 47.24771 47.09144 47.24771
## 2007-06-24 47.23996 47.30287 47.20932 47.22764
## 2007-06-25 47.20471 47.42772 47.13405 47.42772
## 2007-06-26 47.44300 47.61611 47.44300 47.61611
## 2007-06-27 47.62323 47.71673 47.60015 47.62769
## 2007-06-28 47.67604 47.70460 47.57241 47.60716
## 2007-06-29 47.63629 47.77563 47.61733 47.66471
## 2007-06-30 47.67468 47.94127 47.67468 47.76719
```

----

Now `str()` outputs more descriptive information for xts objects. It differentiates between xts objects that are empty (no data and zero-length index), zero-width (no data and has index values), or zero-length (no data--but has a column dimension and may have column names--and zero-length index). It also adds column names to the output. ([#168](https://github.com/joshuaulrich/xts/issues/168), [#378](https://github.com/joshuaulrich/xts/issues/378))

```r
empty <- numeric()

# empty -- no data and zero-length index
str(.xts(NULL, empty))
## An empty xts object 
##   Data:    double [0, 0]
##   Index:   POSIXct,POSIXt [0] (TZ: "")

# zero length -- no rows of data and a zero-length index,
#     but has a column dimension and may have column names
str(.xts(empty, empty))
## A zero-length xts object 
##   Data:    double [0, 1]
##   Index:   POSIXct,POSIXt [0] (TZ: "")

zero_length_with_colnames <-
    .xts(matrix(empty, dimnames = list(NULL, "zero")), empty)
str(zero_length_with_colnames)
## A zero-length xts object 
##   Data:    double [0, 1]
##   Columns: zero
##   Index:   POSIXct,POSIXt [0] (TZ: "")

# zero width -- no data and has index values
str(xts(NULL, Sys.Date()))
## A zero-width xts object on 2023-02-21 / 2023-02-21 containing:
##   Data:    double [0, 0]
##   Index:   Date [1] (TZ: "UTC")
```

----

There's a nice improvement to `as.xts()` for data.frame and similar objects (e.g. data.table, tibble). It will look for a time-based column in the data.frame if it cannot create an index from the row names. ([#381](https://github.com/joshuaulrich/xts/issues/381))

```r
d <- data.frame(as.Date("2023-02-21"), A = 21, B = 42)
as.xts(d)
##             A  B
## 2023-02-21 21 42
```

----

This release also includes a new xts method for `na.fill()` that significantly increases performance when 'fill' is a scalar. And it adds a startup warning that `dplyr::lag()` breaks method dispatch, which means calls to `lag(my_xts)` won't work any more, and suggests a couple ways to work around that breakage.

### Bug Fixes

* Fixed a typo in the Description section of the documentation for `period.apply()` ([#205](https://github.com/joshuaulrich/xts/issues/205)), and added detail to the argument definitions. The original Description has: 
    > the data from `INDEX[k]` to `INDEX[k+1]`

    But that's not consistent with the code. It should be:
    > the data from `INDEX[k]+1` to `INDEX[k+1]`

* Made `merge.xts()` results consistent with `merge.zoo()` for zero-width objects. Previously, `merge.xts()` returned an empty xts object if called on two or more zero-width xts objects. `merge.zoo()` would return a zero-width object with the correct index. ([#227](https://github.com/joshuaulrich/xts/issues/227), [#379](https://github.com/joshuaulrich/xts/issues/379))

* Also made `merge.xts()` results consistent with `merge.zoo()` for zero-length xts objects that have columns. The result of `merge.xts()` did not include the columns of any objects that had one or more columns, but zero rows. A join should include all the columns of the joined objects, regardless of the number of rows in the object. This is consistent with `merge.zoo()`. Thanks to Ethan B. Smith for the report and testing! ([#222](https://github.com/joshuaulrich/xts/issues/222))

* Fixed a long-standing issue with `Ops.xts()`.  Now it always returns an object with the same class as the first (left-hand side) argument. It previously returned an xts object even if the first argument was a subclass of xts. ([#49](https://github.com/joshuaulrich/xts/issues/49))

* Squashed a bug in `reclass()` that did not copy the `tclass`, `tzone`, or `tformat` from 'match.to' to the result object. Now it always copies those index attributes. ([#43](https://github.com/joshuaulrich/xts/issues/43))

### Other

* Migrated unit tests from [RUnit](https://github.com/romanzenka/RUnit) (which is actively maintained, but no longer actively developed) to [tinytest](https://github.com/markvanderloo/tinytest). Thanks [Mark van der Loo](https://github.com/markvanderloo)!

* Added to the `endpoints()` documentation to make it clearer that the result is based on the UNIX epoch (midnight 1970, UTC) and not the first observation in the xts index. Thanks to GitHub user Eluvias for the suggestion! ([#299](https://github.com/joshuaulrich/xts/issues/299))

* Removed an unnecessary check in `na.locf()` (which is not user-facing). Thanks to GitHub user @cgiachalis for the suggestion! ([#307](https://github.com/joshuaulrich/xts/issues/307))

* Updated C entry points so they're not able to accidentally be found via dynamic lookup (i.e. `.Call("foo", ...)`). This makes each call to the C code a few microseconds faster, which is nice. ([#260](https://github.com/joshuaulrich/xts/issues/260))

{{< package-release-footer id="package-release-footer.html" package="xts" >}}
