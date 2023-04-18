---
title: 'xts 0.11-2 on CRAN'
date: 2018-11-06T06:35:00.001-06:00
draft: false
aliases: [ "/2018/11/xts-011-2-on-cran.html" ]
tags : [xts, Releases, R]
---

[xts](https://cloud.r-project.org/package=xts) version 0.11-2 was published to [CRAN](https://cloud.r-project.org/) yesterday. This is quick a bug-fix release.

<!--more-->

Notable changes are below:  

*   The xts method for `shift.time()` is now registered. Thanks to Philippe Verspeelt for the report and PR ([#268](https://github.com/joshuaulrich/xts/issues/268), [#273](https://github.com/joshuaulrich/xts/issues/273)).
*   An if-statement in the `xts` constructor will no longer try to use a logical vector with length > 1. Code like `if (c(TRUE, TRUE))` will throw a warning in an upcoming R release, and this patch will prevent that warning. Thanks to Hugh Parsonage for the report and PR ([#270](https://github.com/joshuaulrich/xts/issues/270), [#272](https://github.com/joshuaulrich/xts/issues/272)).
*   Fix subset when `index(i)` and `i` contain duplicates. Observations were being incorrectly dropped, and behavior is now consistent with zoo. Thanks to Stack Overflow user [scs](https://stackoverflow.com/users/4024268/scs) for the report, and Philippe Verspeelt for the help debugging ([#275](https://github.com/joshuaulrich/xts/issues/275)).
*   Make column names for `merge()` results with unnamed objects shorter and more like zoo ([#248](https://github.com/joshuaulrich/xts/issues/248)). Previously, column names could be hundreds, even thousands, of characters. This change has the added benefit of making `na.fill()` much faster ([#259](https://github.com/joshuaulrich/xts/issues/259)). NOTE: This may BREAK existing code for integer unnamed objects.
*   The `to.period()` family of functions now use the index timezone when converting intraday index values to daily values (or lower frequency). Previously, the dates would be calculated as UTC dates, instead of dates in the local timezone (as they are now). Thanks to Garrett See and Gabor Grothendieck for the reports ([#53](https://github.com/joshuaulrich/xts/issues/53), [#277](https://github.com/joshuaulrich/xts/issues/277)).

As always, I'm looking forward to your questions and feedback! If you have a question, please ask on [Stack Overflow](https://stackoverflow.com/) and use the [\[r\]](https://stackoverflow.com/questions/tagged/r) and [\[xts\]](https://stackoverflow.com/questions/tagged/xts) tags. Or you can send an email to the [R-SIG-Finance mailing list](https://stat.ethz.ch/mailman/listinfo/r-sig-finance) (you must subscribe to post). Open an issue [on GitHub](https://github.com/joshuaulrich/xts) if you find a bug or want to request a feature, but please read the [contributing guide](https://github.com/joshuaulrich/xts/blob/master/.github/CONTRIBUTING.md) first!

{{< post-footer id="post-footer.html" >}}
