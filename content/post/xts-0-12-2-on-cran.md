---
title: 'xts_0.12.2 on CRAN'
date: 2022-10-15T10:21:00.000-05:00
draft: false
aliases: [ "/2022/10/xts-0-12-2-on-cran.html" ]
tags : [Releases, xts, R]
---

An updated version of [xts](http://cran.r-project.org/package=xts) is now on [CRAN](http://cran.r-project.org/). This release is a big one, with lots of changes. Plotting functionality got a lot of attention. Another notable change is that `merge.xts()` now supports suffixes. Plus the obligatory bug fixes and refinements to make xts more robust.

<!--more-->

### Plotting functionality enhancements and bug fixes

* You can now omit the data time range from the upper-right portion of a plot by setting `main.timespan = FALSE`. ([#247](https://github.com/joshuaulrich/xts/issues/247))

* `plot.xts()` gained a `yaxis.ticks` argument to control the number of y-axis grid lines, instead of always drawing 5 y-axes grid lines. Thanks to [Fredrik Wartenberg](https://github.com/FredrikWartenberg) for the feature request and patch! ([#374](https://github.com/joshuaulrich/xts/issues/374))

* Fixed `addEventLines()` when plotted objects have a 'yearmon' index. The ISO-8601 range string was not created correctly. Thanks to [@paessens](https://github.com/paessens) for the report. ([#353](https://github.com/joshuaulrich/xts/issues/353))

* The 'ylim' argument is now robust against numerical precision issues. Thanks to [@bollard](https://github.com/bollard) for the report, PR, and a ton of help debugging intermediate solutions! ([#368](https://github.com/joshuaulrich/xts/issues/368))

* Series added to a panel now extend the panel's y-axis. Previously the y-axis limits were based on the first series' values and not updated when new series were added. So values of the new series did not appear on the plot if they were outside of the original series' min/max. Thanks to [Vitalie Spinu](https://github.com/vspinu) for the report and help debugging and testing! ([#360](https://github.com/joshuaulrich/xts/issues/360))

* All series added to any panel of a plot now update the x-axis of all panels. So the entire plot's x-axis will include every series' time index values within the original plot's time range. This behavior is consistent with `chart_Series()`. Thanks to [Vitalie Spinu](https://github.com/vspinu) for the report and help debugging and testing! ([#360](https://github.com/joshuaulrich/xts/issues/360), [#216](https://github.com/joshuaulrich/xts/issues/216))

* All y-values are now plotted for series that have duplicate index values, but different data values. Thanks to [Vitalie Spinu](https://github.com/vspinu) for the report and help debugging and testing! ([#360](https://github.com/joshuaulrich/xts/issues/360))

* Adding a series can now extend the x-axis before/after the plot's existing time index range by setting `extend.xaxis = TRUE`. That ensures all of the new series' time index values are included in the plot. `extend.xaxis = FALSE` by default to maintain backward compatibility. Thanks to [Vitalie Spinu](https://github.com/vspinu) for the report and help debugging and testing! ([#360](https://github.com/joshuaulrich/xts/issues/360))

### Other enhancements and bug fixes

* `Ops.xts()` no longer changes column names (via `make.names()`) when the two objects do not have identical indexes. This makes it consistent with `Ops.zoo()`. Thanks to [Anton Antonov](https://github.com/tonytonov) for the report! ([#114](https://github.com/joshuaulrich/xts/issues/114))

* Subsetting a zero-length xts object now returns an object with the same storage type as the input. It previously always returned a 'logical' xts object. ([#376](https://github.com/joshuaulrich/xts/issues/376))

* `tclass()` and `tzone()` now return the correct values for zero-length xts objects, instead of the defaults from the `.xts()` constructor. Thanks to [Andre Mikulec](https://github.com/AndreMikulec) for the report and suggested patch! ([#255](https://github.com/joshuaulrich/xts/issues/255))

* `first()` and `last()` now return a zero-length xts object when `n = 0`. They previously returned the entire object. This is consistent with the default `head()` and `tail()` functions, and data.table's `first()` and `last()` functions. Thanks to [Ethan B. Smith](https://github.com/ethanbsmith) for the report and patch! ([#350](https://github.com/joshuaulrich/xts/issues/350))

* Subsetting a zero-width xts now returns an object with the same class, tclass, tzone, and xtsAttributes as the input. Thanks to [@shikokuchuo](https://github.com/shikokuchuo) for the report! ([#359](https://github.com/joshuaulrich/xts/issues/359))

* Now `endpoints()` always returns last observation. Thanks to GitHub user [Eluvias](https://github.com/Eluvias) for the report. ([#300](https://github.com/joshuaulrich/xts/issues/300))

* Now `endpoints()` errors for every `on` value when `k < 1`. It was not throwing an error for `k < 1` for `on` of "years", "quarters", or "months". Thanks to [Eluvias](https://github.com/Eluvias)for the report. ([#301](https://github.com/joshuaulrich/xts/issues/301))

* Fixed a breaking change (introduced in 0.11.0) in `window()` for yearmon and yearqtr indexes. In xts < 0.11.0, `window.zoo()` was dispatched when `window()` was called on a xts object because there was no `window.xts()` method. `window.zoo()` supports additional types of values for the `start` argument, and possibly other features. Thanks to [@annaymj](https://github.com/annaymj) for the report. ([#312](https://github.com/joshuaulrich/xts/issues/312))

* Clarified documentation for `axTicksByTime()` to say that returns index locations (e.g. 1, 2, 3) and not timestamps. Thanks to [Gabor Grothendieck](https://github.com/ggrothendieck) for the suggestion and feedback. ([#354](https://github.com/joshuaulrich/xts/issues/354))

* Fixed `merge.xts()` on xts objects containing complex types when `fill` is provided. It previously threw an error because it treated `fill` as double instead of complex. Thanks to [Gabor Grothendieck](https://github.com/ggrothendieck) for the report. ([#346](https://github.com/joshuaulrich/xts/issues/346))

* Added a message to tell the user how to disable the "object timezone is different from the system timezone" warning (set `options(xts_check_TZ = FALSE)`). Thanks to [Jerzy Pawlowski](https://github.com/algoquant) for the nudge. ([#113](https://github.com/joshuaulrich/xts/issues/113))

* `rbind()` now handles xts objects without dim attribute. It previously threw an obscure error if one of the xts objects did not have a dim attribute. ([#361](https://github.com/joshuaulrich/xts/issues/361))

* `split.xts()` now always return a named list, making it consistent with `split.zoo()`. Thanks to [Gabor Grothendieck](https://github.com/ggrothendieck) for the report. ([#357](https://github.com/joshuaulrich/xts/issues/357))

* xts objects with a zero-length POSIXct index now have a zero-length POSIXct vector instead of a zero-length integer vector for the index. Thanks to [Jasper Schelfhout](https://github.com/JasperSch) for the report and PR! ([#363](https://github.com/joshuaulrich/xts/issues/363), [#364](https://github.com/joshuaulrich/xts/pulls/364))

* Add supported for suffixes in `merge.xts()` results. The suffixes are consistent with `merge.default()` and not `merge.zoo()`, because `merge.zoo()` automatically uses "." as a separator between column names, but the default method doesn't. Thanks to Alex Chernyakov for the initial report, [QiuxiaoMu](https://github.com/stucash) for testing, and [Pierre Lamarche](https://github.com/pierre-lamarche) for the nudge. Better late than never? ([#38](https://github.com/joshuaulrich/xts/issues/38), [#371](https://github.com/joshuaulrich/xts/issues/371))

----

You may have noticed that several of these issues have been open a long time. I've been revisiting historical issues and deciding whether to implement them or close them. I've already implemented some cool ones in the development version of xts.

I'm most excited about open-ended time-of-day subsetting. Now you can do things like:

```r
x["/T1700"]  # start of the day until 5pm
x["T0500/"]  # 5am until the end of the day
```

{{< package-release-footer id="package-release-footer.html" package="xts" >}}
