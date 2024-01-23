---
title: 'xts_0.13.2 on CRAN'
date: 2024-01-22T12:41:00.000-05:00
draft: false
categories: [ R Package Releases ]
tags : [Releases, xts, R]
---

An updated version of [xts](http://cran.r-project.org/package=xts) is now on [CRAN](http://cran.r-project.org/). The most notable change is that `plot.xts()` now supports a log scale y-axis. This involved a significant refactor of the `plot.xts()` internals, so it's possible to have introduced some bugs.

<!--more-->

### Features

* Add ability to log scale the y-axis in `plot.xts()`. ([#103](https://github.com/joshuaulrich/xts/issues/103))

* Significantly refactor the internals of `plot.xts()`. This made it a lot easier to add the y-axis log scale. ([#408](https://github.com/joshuaulrich/xts/issues/408))

### Enhancements

* Print a message when `period.apply()` is called with `FUN = mean` because it calculates the mean for each column, not all the data in    the subset like it does for all other functions. The message says to use `FUN = colMeans` for current behavior and `FUN = function(x) mean(x)` to calculate the mean for all the data. This information is also included in the help files. The option `xts.message.period.apply.mean = FALSE` suppresses the message. ([#124](https://github.com/joshuaulrich/xts/issues/124))

* Actually change the underlying index values when 'tclass' is changed from a class with a timezone (e.g. POSIXct) to one without a        timezone (e.g. Date). Add a warning when this happens, with a global option to always suppress the warning. Thanks to [Daniel Palomar](https://github.com/dppalomar) for the report and suggestion! ([#311](https://github.com/joshuaulrich/xts/issues/311))

### Bug Fixes

* Fix error when `print.xts()` is called 'quote' or 'right' arguments. Thanks to [Willem Maetens](https://github.com/WillemMaetens) for the report and patch! ([#401](https://github.com/joshuaulrich/xts/issues/401))

* Fix `addPolygon()` so it renders when `observation.based = TRUE`. ([#403](https://github.com/joshuaulrich/xts/issues/403))

* Print trailing zeros for index value with fractional seconds, so every index value has the same number of characters. ([#404](https://github.com/joshuaulrich/xts/issues/404))

{{< package-release-footer id="package-release-footer.html" package="xts" >}}
