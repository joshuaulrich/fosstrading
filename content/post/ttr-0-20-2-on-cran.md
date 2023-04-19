---
title: 'TTR_0.20-2 on CRAN'
date: 2010-03-30T14:48:00.002-05:00
draft: false
aliases: [ "/2010/03/ttr020-2-on-cran.html" ]
tags : [TTR]
---

An updated version of [TTR](http://cran.r-project.org/web/packages/TTR/) is now on [CRAN](http://cran.r-project.org/). It fixes a couple bugs and includes a couple handy tweaks. Here's the full contents of the CHANGES file:  
  
TTR version 0.20-2  
Changes from version 0.20-1  
  
  
NEW FEATURES:  

*   Added `VWAP()` and `VWMA()` (thanks to Brian Peterson)
*   Added v-factor generalization to `DEMA()` (thanks to John Gavin)

  
CHANGES:  

*   Updated `volatility()` to handle univariate case of `calc='close'` (thanks to Cedrick Johnson)
*   Moved `EMA()`, `SAR()`, and `wilderSum()` from `.Fortran()` to `.Call()` and used `xts:::naCheck()` in lieu of TTR's NA check mechanism
*   `RSI()` up/down momentum now faster with xts (thanks to Jeff Ryan)
*   If `ratio` is specified in `EMA()` but `n` is missing, the traditional value of `n` is approximated and returned as the first non-NA value (thanks to Jeff Ryan)

  
BUG FIXES:  

*   Fix to `stoch()` when `maType` is a list and `n` is not set in the list's 3rd element (thanks to Wind Me)
*   Fixed `fastK` in `stoch()` when `smooth != 1`
*   Fixed segfault caused by `EMA()` when `n < NROW(x)` (thanks to Douglas Hobbs)
*   `test.EMA.wilder()` failed under R-devel (thanks to Prof Brian Ripley)

{{< package-release-footer id="package-release-footer.html" package="ttr" >}}
