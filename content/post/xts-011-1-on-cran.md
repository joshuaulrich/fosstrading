---
title: 'xts 0.11-1 on CRAN'
date: 2018-09-12T13:36:00.002-05:00
draft: false
aliases: [ "/2018/09/xts-011-1-on-cran.html" ]
tags : [xts, Releases, R]
---

[xts](https://cloud.r-project.org/package=xts) version 0.11-1 was published to [CRAN](https://cloud.r-project.org/) this morning. [xts](https://cloud.r-project.org/package=xts) provides data structure and functions to work with time-indexed data.  This release contains some awesome features that will transparently make your [xts](https://cloud.r-project.org/package=xts) code even faster!  

*   There's a new `window.xts()` method, thanks to Corwin Joy ([#100](https://github.com/joshuaulrich/xts/issues/100), [#240](https://github.com/joshuaulrich/xts/issues/240)). Corwin also refactored and improved the performance of the binary search algorithm used to subset xts objects. Tom Andrews reported and fixed a few related regressions ([#251](https://github.com/joshuaulrich/xts/issues/251), [#263](https://github.com/joshuaulrich/xts/issues/263), [#264](https://github.com/joshuaulrich/xts/issues/264)).
*   The `na.locf.xts()` method loops over columns of multivariate objects in C code, for improved speed and memory performance. Thanks to Chris Katsulis and Tom Andrews for their reports and patches ([#232](https://github.com/joshuaulrich/xts/issues/232), [#233](https://github.com/joshuaulrich/xts/issues/233), [#234](https://github.com/joshuaulrich/xts/issues/234), [#235](https://github.com/joshuaulrich/xts/issues/235), [#237](https://github.com/joshuaulrich/xts/issues/237)).
*   After many years, `merge.xts()` can finally handle multiple character or complex xts objects. Thanks to Ken Williams for the report ([#44](https://github.com/joshuaulrich/xts/issues/44)).
*   You can use "quarters" to specify tick/grid mark locations on plots. Thanks to Marc Weibel for the report ([#256](https://github.com/joshuaulrich/xts/issues/256)).

There are also a few notable bug fixes:  

*   `make.index.unique()` always returns a unique and sorted index. Thanks to Chris Katsulis for the report and example ([#241](https://github.com/joshuaulrich/xts/issues/241)).
*   Plots have better axis tick mark locations, thanks to Dirk Eddelbuettel ([#246](https://github.com/joshuaulrich/xts/issues/246)).
*   `periodicity()` now warns instead of errors if the xts object contains less than 2 observations ([#230](https://github.com/joshuaulrich/xts/issues/230)).
*   `first()` and `last()` now keep dims when they would otherwise be dropped by a regular row subset. This is consistent with `head()` and `tail()`. Thanks to Davis Vaughan for the report ([#226](https://github.com/joshuaulrich/xts/issues/226)).
*   An invalid ISO8601 range subset now returns no data instead of all rows ([#96](https://github.com/joshuaulrich/xts/issues/96)).

As always, I'm looking forward to your questions and feedback! If you have a question, please ask on [Stack Overflow](https://stackoverflow.com/) and use the [\[r\]](https://stackoverflow.com/questions/tagged/r) and [\[xts\]](https://stackoverflow.com/questions/tagged/xts) tags. Or you can send an email to the [R-SIG-Finance mailing list](https://stat.ethz.ch/mailman/listinfo/r-sig-finance) (you must subscribe to post). Open an issue [on GitHub](https://github.com/joshuaulrich/xts) if you find a bug or want to request a feature, but please read the [contributing guide](https://github.com/joshuaulrich/xts/blob/master/.github/CONTRIBUTING.md) first!