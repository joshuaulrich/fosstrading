---
title: 'TTR_0.22-0 on CRAN'
date: 2013-03-18T20:49:00.000-05:00
draft: false
aliases: [ "/2013/03/ttr022-0-on-cran.html" ]
tags : [Releases, TTR]
---

  
An updated version of [TTR](http://cran.r-project.org/web/packages/TTR/index.html) is now on [CRAN](http://cran.r-project.org/).  The biggest changes to be aware of are that all moving averages attempt to set colnames, `CCI()` returns an object with colnames, and the initial gap for `SAR()` is not hard-coded at 0.01.  There are also some much-needed bug fixes - most notably to Yang Zhang volatility, `MACD()`, `SAR()`, `EMA()`/`EVWMA()`, and `adjRatios()`.  
  
There are some exciting new features, including a rolling single-factor model function (`rollSFM()`, based on a prototype from James Toll), a `runPercentRank()` function from Charlie Friedemann, `stoch()` and `WPR()` return 0.5 instead of NaN when there's insufficient price movement, and a faster `aroon()` function.  
  
Here are all of the updates (from the CHANGES file):  
  
#-#-#-#-#-#-#-#-#-#    Changes in TTR version 0.22-0    #-#-#-#-#-#-#-#-#-#  
  
SIGNIFICANT USER-VISIBLE CHANGES  

*   `CCI()` now returns an object with colnames ("cci").
*   All moving average functions now attempt to set colnames.
*   Added clarification on the displaced nature of `DPO()`.
*   `SAR()` now sets the initial gap based on the standard deviation of the high-low range instead of hard-coding it at 0.01.

NEW FEATURES

*   Added `rollSFM()` function that calculates alpha, beta, and R-squared for a single-factor model, thanks to James Toll for the prototype.
*   Added `runPercentRank()` function, thanks to Charlie Friedemann.
*   Moved slowest portion of `aroon()` to C.
*   `DonchianChannel()` gains an `include.lag = FALSE` argument, which includes the current period's data in the calculation. Setting it to `TRUE` replicates the original calculation. Thanks to Garrett See and John Bollinger.
*   The Stochastic Oscillator and Williams' %R now return 0.5 (instead of NaN) when a securities' price doesn't change over a sufficient period.
*   All moving average functions gain `...`.
*   Users can now change `alpha` in Yang Zhang volatility calculation.

BUG FIXES

*   Fixed `MACD()` when `maType` is a list. Now `mavg.slow = maType[[2]]` and `mavg.fast = maType[[1]]`, as users expected based on the order of the `nFast` and `nSlow` arguments. Thanks to Phani Nukala and Jonathan Roy.
*   Fixed bug in `lags()` function, thanks to Michael Weylandt.
*   Corrected error in Yang Zhang volatility calculation, thanks to several people for identifying this error.
*   Correction to `SAR()` extreme point calculations, thanks to Vamsi Galigutta.
*   `adjRatios()` now ensures all inputs are univariate, thanks to Garrett See.
*   `EMA()` and `EVWMA()` now ensure `n` is less than the number of non-NA values, thanks to Roger Bos.
*   Fix to `BBands()` docs, thanks to Evelyn Mitchell.

{{< package-release-footer id="package-release-footer.html" package="ttr" >}}
