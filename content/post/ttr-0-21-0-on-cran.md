---
title: 'TTR_0.21-0 on CRAN'
date: 2011-09-01T13:10:00.000-05:00
draft: false
aliases: [ "/2011/09/ttr021-0-on-cran.html" ]
categories: [ R Package Releases ]
tags : [Releases, TTR]
---

An updated version of [TTR](http://cran.r-project.org/web/packages/TTR/) is now on [CRAN](http://cran.r-project.org/).  It contains some much-needed bug fixes (most notably to `stockSymbols()`), some small changes, and a few new functions.  Note that the change to `wilderSum()` will affect functions that use it (e.g. `ADX()`).  
  
Here are the full contents of the CHANGES file:  
  
> TTR version 0.21-0  
>   Changes from version 0.20-2  
>   
> NEW FEATURES:  
> 
> *   Added variable moving average function, `VMA()`.
> *   Added [Brian Peterson's](http://braverock.com/brian/) price bands function, `PBands()`.
> *   Added [David Varadi's](http://cssanalytics.wordpress.com/) `DVI()` indicator, `DVI()`.
> 
> CHANGES:  
> 
> *   Added `wilder` and `ratio` arguments to `DEMA()`. Thanks to Matthew Fornari for the suggestion.
> *   Changed `wilderSum()` to seed initial value with raw sum. This matches Wilder's original calculations. Thanks to Mahesh Bp for the report.
> *   The `BBands()` `sd` calculation now uses the population instead of sample statistic. This is consistent with Bollinger Band literature. Thanks to [Jeff Ryan](http://www.lemnica.com/) for the patch.
> 
> BUG FIXES:  
> 
> *   Fixed `stockSymbols()` for [nasdaq.com](http://nasdaq.com/) changes.
> *   Fixed `ZLEMA()` default ratio by changing it from `2/(n-1)` to `2/(n+1)`. This makes it consistent with `EMA()`. Thanks to [Dirk Eddelbuettel](http://dirk.eddelbuettel.com/).
> *   Corrected close-to-close volatility. Thanks to James Toll for the report.
> *   `adjRatios()` failed (spectacularly) if there were missing close prices. Thanks to Garrett See for the report.

{{< package-release-footer id="package-release-footer.html" package="ttr" >}}
