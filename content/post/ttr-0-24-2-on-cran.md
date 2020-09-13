---
title: 'TTR_0.24.2 on CRAN'
date: 2020-09-13T08:41:00.000-05:00
draft: false
tags : [Releases, TTR, R]
---
  
This is another one of my long-overdue posts. I'm trying to get int the habit of posting and announcing each of my package releases. So I'm writing posts this morning for the most recent release of the most popular packages I maintain.

I released an updated version of [TTR](http://cran.r-project.org/package=TTR) to [CRAN](http://cran.r-project.org/) on 2020-09-01.

This is mainly a bug-fix release. There were several issues in the underlying C code that caused various issues. I'll spare you the gory details. If you're really interested, you can find them in the [CHANGES](https://github.com/joshuaulrich/TTR/blob/27ea28698295f56447fcc87ad515140bdb35c8a5/CHANGES) file. There are links to the relevant issues in there too, if you're really curious.

Now for the bug-fixes you might actually notice.

- `ALMA()` could return an object whose length didn't match the length of the input when the input was not an xts object. This bug has been around for years. I'm sorry I just now got to it.
\
\
The bug was caused by the differences in `rollapply.default()` in zoo and `rollapply.xts()`. The xts method pads with `NA` by default, whereas the default version does not. Thanks to GitHub user [marksimmonds](https://github.com/marksimmonds) for the report! ([#29](https://github.com/joshuaulrich/TTR/issues/29))

- `MFI()` has been fixed for the case where money flow is always > 0. The denominator of the money ratio is zero if there is no negative money flow for `n` consecutive observations (e.g. during a strong up-trend). This causes the money flow index to be `Inf`. Now the money flow index is set to 100 in this case.
\
\
Also, the money ratio will be `NaN` if there's no money flow for `n` consecutive observations (e.g. if there are no trades). This causes the money flow index to be `NaN`. Now the money flow index is to 50 in this case.  Thanks to GitHub user [jgehw](https://github.com/jgehw) for the report, reproducible example, and suggested patch! ([#81](https://github.com/joshuaulrich/TTR/issues/81))

----

I'm looking forward to your questions and feedback! If you have a question, please ask on [Stack Overflow](http://stackoverflow.com/questions/tagged/r) and use the \[r\] and \[xts\] tags.  Or you can send an email to the [R-SIG-Finance](https://stat.ethz.ch/mailman/listinfo/r-sig-finance) mailing list (you must subscribe to post). Open an [issue on GitHub](https://github.com/joshuaulrich/xts/issues) if you find a bug or want to request a feature, but please [read the contributing guide](https://github.com/joshuaulrich/xts/blob/master/CONTRIBUTING.md) first!

----

If you love using my open-source work (e.g. [quantmod](https://cran.r-project.org/package=quantmod), [xts](https://cran.r-project.org/package=xts), [IBrokers](https://cran.r-project.org/package=IBrokers), [microbenchmark](https://cran.r-project.org/package=microbenchmark) etc.), you can give back by [sponsoring me on GitHub](https://github.com/sponsors/joshuaulrich/). I truly appreciate anything you're willing and able to give!
