---
title: 'xts 0.10-2 on CRAN'
date: 2018-03-19T05:30:00.000-05:00
draft: false
aliases: [ "/2018/03/xts-010-2-on-cran.html" ]
tags : [xts, Releases, R]
---

This [xts](http://joshuaulrich.github.io/xts/) release contains mostly bugfixes, but there are a few noteworthy features. Some of these features were added in version 0.10-1, but I forgot to blog about it. Anyway, in no particular order:  
  

*   `endpoints()` gained sub-second accuracy on Windows ([#202](https://github.com/joshuaulrich/xts/issues/202))!
*   `na.locf.xts()` now honors `x` and `xout` arguments by dispatching to the next method ([#215](https://github.com/joshuaulrich/xts/issues/215)). Thanks to Morten Grum for the report.
*   `na.locf.xts()` and `na.omit.xts()` now support character xts objects. Thanks to Ken Williams and Samo Pahor for the reports ([#42](https://github.com/joshuaulrich/xts/issues/42)).

  
Many of the bug fixes were related to the new plot.xts() introduced in 0.10-0. And a handful of bugfixes were to make xts more consistent with zoo in some edge cases.  
  
As always, I'm looking forward to your questions and feedback!  If you have a question, please ask on Stack Overflow and use the \[r\] and \[xts\] tags.  Or you can send an email to the R-SIG-Finance mailing list (you must subscribe to post).  Open an issue on GitHub if you find a bug or want to request a feature, but please read the contributing guide first!
