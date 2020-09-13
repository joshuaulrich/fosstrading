---
title: 'xts_0.12.1 on CRAN'
date: 2020-09-13T10:49:00.000-05:00
draft: false
tags : [Releases, xts, R]
---
  
This is a long-overdue post. I'm trying to get int the habit of posting and announcing each of my package releases. So I'm writing posts this morning for the most recent release of the most popular packages I maintain.

I released an updated version of [xts](http://cran.r-project.org/package=xts) to [CRAN](http://cran.r-project.org/) on 2020-09-09. I'm also going to include some notes from the prior release (0.12-0), since I didn't post about that. It has some nifty changes in it too.

I'm going to highlight a handful of the changes:

1. moving index class and index timezone from the xts object itself to the index,
1. improvements to time-of-day subsetting (`x["T10:00/T13:00"]`)
1. user contributions, and
1. several bug fixes.

### Changes to index attributes

The most significant user-facing change in this release is a bug-fix for the functions that would change the `tclass` of the xts index. This would happen in calls to `reclass()`, `period.apply()`, and logical operations on `POSIXct` indexes. Thanks to [Tom Andrews](https://github.com/TomAndrews) for the report and testing, and to [Panagiotis Cheilaris](https://github.com/philaris) for contributing test cases ([#322](https://github.com/joshuaulrich/xts/issues/322), [#323](https://github.com/joshuaulrich/xts/pull/323)).

This was a regression due to the main change in version 0.12-0. All the index-attributes were removed from the xts object and are now only attached to the index itself ([#245](https://github.com/joshuaulrich/xts/issues/245)). We took great care to maintain backward compatibility, and throw warnings when deprecated functions are called and when index-attributes are found on the xts object. I apologize for taking this long to get the fix on CRAN.

### Time-of-day subsetting

Another change in 0.12-0 is a significant (~200x!) performance improvement to time-of-day subsetting, thanks to [StackOverflow user3226167](https://stackoverflow.com/users/3226167/user3226167) ([#193](https://github.com/joshuaulrich/xts/issues/193)).

Then [Claymore Marshall](https://github.com/claymoremarshall) added many examples of time-of-day subsetting to `?subset.xts`. He also fixed a bug in time-of-day subsetting where subsetting by hour only returned wrong results ([#304](https://github.com/joshuaulrich/xts/issues/304), [#326](https://github.com/joshuaulrich/xts/issues/326), [#328](https://github.com/joshuaulrich/xts/pull/328)).

### User contributions

There were also several more user-contributed changes. I love when the community that uses open source software contributes to the project! It's so much more fun than working on it by myself. :)

These are in a bulleted list in order to highlight each user's contribution.

- [Jasen Macike](https://github.com/jaymon0703) updated `plot.xts()` to support y-axis labels via the `ylab` argument ([#333](https://github.com/joshuaulrich/xts/issues/333), [#334](https://github.com/joshuaulrich/xts/pull/334)).

- [Michael Chirico](https://github.com/MichaelChirico) added an internal `isUTC()` function that recognizes many UTC-equivalent time zones ([#319](https://github.com/joshuaulrich/xts/issues/319)).

- [Dirk Eddelbuettel](https://dirk.eddelbuettel.com/) updated the C API header to fix the signatures of `do_merge_xts()` and `is_xts`, which did not return the required type to be called via `.Call()`. Thanks to [Tomas Kalibera](https://github.com/kalibera) for the report ([#317](https://github.com/joshuaulrich/xts/issues/317)), and to Dirk for the PR ([#337](https://github.com/joshuaulrich/xts/pull/337)). \
This is a breaking change, but it's only in the C API, and is required to avoid the potential to crash your R session.

- [Harvey Smith](https://github.com/harvey131) fixed the possible values for the `major.ticks`, `minor.ticks`, and `grid.ticks.on` arguments to `plot.xts()` in the Details section of the documentation ([#291](https://github.com/joshuaulrich/xts/issues/291)).

- Performance for the `period.XYZ()` functions (sum, prod, min, max) is much faster ([#278](https://github.com/joshuaulrich/xts/issues/278)). Thanks to [Chris Katsulis](https://github.com/ckatsulis) for the report, and [Harvey Smith](https://github.com/harvey131) for several examples.

### Bug fixes

`first()` now operates correctly on non-xts objects when `n = -1`. Previously it would always return the last two values. Thanks to [GitHub user vxg20](https://github.com/vxg20) for the report ([#325](https://github.com/joshuaulrich/xts/issues/325)).

The `.xts()` constructor would create an xts object with row names if `x` had row names. This shouldn't happen, because xts objects do not have or support row names ([#298](https://github.com/joshuaulrich/xts/issues/298)).

Several binary operations (e.g. +, -, !=, <, etc.) on variations of uncommon xts objects with other xts, matrix, or vector objects, could result in malformed xts objects ([#295](https://github.com/joshuaulrich/xts/issues/295)). Some examples of the types of uncommon xts objects: no dim attribute, zero-width, zero-length.

Calling `as.matrix()` on an xts object without a dim attribute no longer throws an error ([#294](https://github.com/joshuaulrich/xts/issues/294)).

`merge.xts()` now honors `check.names = FALSE` ([#293](https://github.com/joshuaulrich/xts/issues/293)). It also creates shorter column names when passed unnamed objects, consistent with zoo ([#248](https://github.com/joshuaulrich/xts/issues/248)).

`as.zoo.xts()` is now only registered for zoo versions prior to 1.8-5.  Methods to convert an object to another class should reside in the package that implements the target class. Thanks to Kurt Hornik for the report ([#287](https://github.com/joshuaulrich/xts/issues/287)).

`.parseISO8601()` no longer has a potential length-1 logical error. Thanks to Kurt Hornik for the report ([#280](https://github.com/joshuaulrich/xts/issues/280)).

`endpoints()` now honors `k > 0` when `on = "quarters"`. Thanks to [@alkment](https://github.com/alkment) for the report ([#279](https://github.com/joshuaulrich/xts/issues/279)).

----

I'm looking forward to your questions and feedback! If you have a question, please ask on [Stack Overflow](http://stackoverflow.com/questions/tagged/r) and use the \[r\] and \[xts\] tags.  Or you can send an email to the [R-SIG-Finance](https://stat.ethz.ch/mailman/listinfo/r-sig-finance) mailing list (you must subscribe to post). Open an [issue on GitHub](https://github.com/joshuaulrich/xts/issues) if you find a bug or want to request a feature, but please [read the contributing guide](https://github.com/joshuaulrich/xts/blob/master/CONTRIBUTING.md) first!

----

If you love using my open-source work (e.g. [quantmod](https://cran.r-project.org/package=quantmod), [TTR](https://cran.r-project.org/package=TTR), [IBrokers](https://cran.r-project.org/package=IBrokers), [microbenchmark](https://cran.r-project.org/package=microbenchmark) etc.), you can give back by [sponsoring me on GitHub](https://github.com/sponsors/joshuaulrich/). I truly appreciate anything you're willing and able to give!
