---
title: 'xts 0.10-0 on CRAN!'
date: 2017-07-07T14:10:00.003-05:00
draft: false
aliases: [ "/2017/07/xts-0-10-0-on-cran.html" ]
tags : [xts, Releases, R]
---

A new, and long overdue, release of [xts](http://joshuaulrich.github.io/xts/) is now on [CRAN](https://cran.r-project.org/package=xts)!  The major change is the completely new [plot.xts()](http://joshuaulrich.github.io/xts/plotting_basics.html) written by Michael Weylandt and Ross Bennett, and which is based on Jeff Ryan's `quantmod::chart_Series()` code.  
  
Do note that the new `plot.xts()` includes breaking changes to the original (and rather limited) `plot.xts()`.  However, we believe the new functionality more than compensates for the potential one-time inconvenience.  And I will no longer have to tell people that I use `plot.zoo()` on xts objects!  
  
This release also includes more bug fixes than you can shake a stick at.  We squashed several bugs that could have crashed your R session.  We also fixed some (always pesky and tricky) timezone issues.  We've also done more sanity checking (e.g. for NA in the index), and provide more informative errors when things aren't right.  And last, but not least, unit tests are running again!  
  
I'm sure you were hoping to see some examples of the new `plot.xts()` functionality.  Rather than clutter up this blog post with code, check out the [basic examples](http://joshuaulrich.github.io/xts/plotting_basics.html), and the [panel functionality examples](http://joshuaulrich.github.io/xts/plotting_panels.html) that Ross Bennett created.  
  
I'm looking forward to your questions and feedback!  If you have a question, please ask on [Stack  Overflow](http://stackoverflow.com/questions/tagged/r) and use the \[r\] and \[xts\] tags.  Or you can send an email to the [R-SIG-Finance](https://stat.ethz.ch/mailman/listinfo/r-sig-finance)  mailing list (you must subscribe to post).  Open an [issue on GitHub](https://github.com/joshuaulrich/xts/issues) if you find a bug or want to request a feature, but please [read the contributing guide](https://github.com/joshuaulrich/xts/blob/master/CONTRIBUTING.md) first!
