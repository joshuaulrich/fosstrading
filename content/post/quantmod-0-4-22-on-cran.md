---
title: 'quantmod_0.4.22 on CRAN'
date: 2023-04-16T03:41:57.000-05:00
draft: false
aliases: [ "/2023/04/quantmod-0-4-22-on-cran.html" ]
tags : [Releases, quantmod, R]
---

An updated version of [quantmod](http://cran.r-project.org/package=quantmod) is now on [CRAN](http://cran.r-project.org/). It adds functions `HL()`, `is.HL()`, and `has.HL()` to check for 'high' and 'low' price columns. It also makes accessing Yahoo Finance price, dividend, and split data more robust. `getSymbols.FRED()` got `to` and `from` arguments, like other `getSymbols()` methods. The remaining changes are bug fixes and maintenace chores.

<!--more-->

This was mainly a maintenance and bug fix release, but it does include a couple nice features. quantmod versions 0.4.17 through 0.4.21 included several relevant features that weren't highlighted in any previous posts. They're included in a separate section below.


### New Features

* Exported `HL()`, `is.HL()`, and `has.HL()` functions and added documentation. These were added in 0.4.20 but not exported or included in the documentation.

* Switched to the Yahoo Finance v8 JSON endpoint and removed the v7 CSV endpoint. There seems to be a rate limit for the number of tickers you can request via the CSV endpoint. The [yfinance python library](https://github.com/ranaroussi/yfinance) uses the JSON endpoint and doesn't seem to have rate limit issues. ([#360](https://github.com/joshuaulrich/quantmod/issues/360), [#362](https://github.com/joshuaulrich/quantmod/issues/362), [#364](https://github.com/joshuaulrich/quantmod/issues/364))

* `getSymbols.FRED()` now supports `to` and `from` arguments. So users can set the 'from' and 'to' arguments for FRED data like they can for other data sources like Yahoo. Those values had been ignored and the entire series was always returned. ([#368](https://github.com/joshuaulrich/quantmod/issues/368))

### Bug Fixes

* Fixed `getDividends()` and `getSplits()` for stocks that issue monthly dividends. ([#372](https://github.com/joshuaulrich/quantmod/issues/372))

* Added error handling to `getSplits()` and `getDividends()`. `getDividends()` didn't handle cases where the download failed, or when dividends needed to be split-adjusted but there were no splits. It also tried to set colnames on the empty xts object that's returned when there are no dividends. `getSplits()` had the same colnames issue. Thanks to Chris Cheung for the report! ([#366](https://github.com/joshuaulrich/quantmod/issues/366))

* Remove "^" prefix from `getSymbols()` return value. The name of the object `getSymbols()` created and the symbol value it returned were inconsistent when the 'Symbols' argument has a "^" prefix and `auto.assign = TRUE`:
    * `getSymbols()` removed the "^" from the object it creates, but
    * returned the 'Symbols' argument unchanged, and
    * removed the "^" from the column names of the object it creates.

    The example below will create an object named `IXIC` but the value of `sym` will be "^IXIC".

        sym <- getSymbols("^IXIC")

    That means `x <- get(sym)` will not work because an object named `^IXIC` doesn't exist. ([#371](https://github.com/joshuaulrich/quantmod/issues/371))

### Chores

* Moved [jsonlite](http://cran.r-project.org/package=jsonlite) from Suggests to Imports so it doesn't cause a problem when a package that doesn't also Suggest jsonlite but uses `getSymbols()`. Thanks to Kurt Hornik for the report and fix! ([#380](https://github.com/joshuaulrich/quantmod/issues/380))

* Fixed S3 method issues. R-devel (83995-ish) added a check that found methods that were not registered (`str.replot()`, `seriesHi.timeSeries()`, and `seriesLo.timeSeries()`). It was also confused by `range.bars()` and `unique.formula.names()` because they are named like S3 methods. Neither were exported so they didn't affect users. Thanks to Kurt Hornik for the report! ([#375](https://github.com/joshuaulrich/quantmod/issues/375))

-----

# Changes in Prior Versions

### New Features

* Added `HL()` and supporting functions. These are analogues to `HLC()`, `OHLC()`, etc. Thanks for Karl Gauvin for the nudge to implement them.

* Added adjusted close price to `getSymbols.tiingo()` output. Thanks to Ethan Smith for the suggestion and patch! ([#289](https://github.com/joshuaulrich/quantmod/issues/289), [#345](https://github.com/joshuaulrich/quantmod/pull/345))

* Updated `getSymbols.tiingo()` to use a Date index for daily data. Thanks to Ethan Smith for the report! ([#350](https://github.com/joshuaulrich/quantmod/issues/350))

* Updated `getOptionChain()` to return all the fields that Yahoo Finance provides. Thanks to Adam Childers (@rhizomatican) for the patch! ([#318](https://github.com/joshuaulrich/quantmod/issues/318), [#336](https://github.com/joshuaulrich/quantmod/pull/336))

* Added [orats](https://docs.orats.io) as a source for `getOptionChain()`. Thanks to Steve Bronder (@SteveBronder) for the suggestion and implementation! ([#325](https://github.com/joshuaulrich/quantmod/pull/325))

* Added "Defaults" handling to `getQuote()` and `getQuote.yahoo()`. Thanks to Ethan Smith for the report. ([#291](https://github.com/joshuaulrich/quantmod/issues/291))

* Added Bid and Ask fields to the output from `getQuote()`. Thanks to @jrburl for the report and PR. ([#302](https://github.com/joshuaulrich/quantmod/pull/302))

### Bug Fixes

* Removed check for Yahoo Finance cookies because the site no longer responds with a cookie, and that caused the connection attempt to fail. This affected `getSymbols()`, `getDividends()`, and `getSplits()`. Thanks to several users for reporting, and especially to @pverspeelt and @alihru for investigating potential fixes! ([#358](https://github.com/joshuaulrich/quantmod/issues/358))

* Updated `getSymbols.yahooj()` for changes to the web page. ([#312](https://github.com/joshuaulrich/quantmod/issues/312))

* Removed unneeded arguments to the `getSymbols.tiingo()` implementation. Thanks to Ethan Smith for the suggestion and patch! ([#343](https://github.com/joshuaulrich/quantmod/issues/343), [#344](https://github.com/joshuaulrich/quantmod/pull/344))

* Load dividends and splits data into the correct environment when the user provides a value for the `env` argument. The previous behavior always loaded the data into the environment the function was called from. Thanks to Stewart Wright for the report and patch! ([#33](https://github.com/joshuaulrich/quantmod/issues/33))

* Improved the error message when `getSymbols()` cannot import data for a symbol because the symbol is not valid or does not have historical data. Thanks to Peter Carl for the report. ([#333](https://github.com/joshuaulrich/quantmod/issues/333))

* Fixed the `getMetals()` example in the documentation. The example section previously had an example of `getFX()`. Thanks to Gerhard Nachtmann (@nachti) for the report and patch! ([#330](https://github.com/joshuaulrich/quantmod/issues/330))

* Fixed `getQuote()` so it returns data when the ticker symbol contains an "&". Thanks to @pankaj3009 for the report! ([#324](https://github.com/joshuaulrich/quantmod/issues/324))

* Fixed `addMACD()` when `col` is specified. Thanks to @nvalueanalytics for the report! ([#321](https://github.com/joshuaulrich/quantmod/issues/321))

* Fixed issues handling https:// in `getSymbols.yahooj()`. Thanks to @lobo1981 and @tchevri for the reports and Ethan Smith for the suggestion to move from XML to xml2. ([#310](https://github.com/joshuaulrich/quantmod/issues/310), [#312](https://github.com/joshuaulrich/quantmod/issues/312))

* Fixed `getSymbols.yahoo()`, `getDividends()`, and `getSplits()` so they all handle download errors and retry again. Thanks for @helgasoft for the report on `getSymbols.yahoo()` and @msfsalla for the report on `getDividends()` and `getSplits()`. ([#307](https://github.com/joshuaulrich/quantmod/issues/307), [#314](https://github.com/joshuaulrich/quantmod/issues/314))

* Added implied volatility and last trade date to `getOptionChain()` output. Thanks to @hd2581 and @romanlelek for the reports. And thanks to @rjvelasquezm for noticing the error when `lastTradeDate` is `NULL`. ([#224](https://github.com/joshuaulrich/quantmod/issues/224), [#304](https://github.com/joshuaulrich/quantmod/issues/304))

* Fixed `getOptionChain()` to throw a warning and return `NULL` for every expiry that doesn't have data. ([#299](https://github.com/joshuaulrich/quantmod/issues/299))

* Fixed "Defaults" to handle unexported function (e.g. `getQuote.av()`. Thanks to @helgasoft for the report. ([#316](https://github.com/joshuaulrich/quantmod/issues/316))

* `importDefaults()` didn't call `get()` on vector with length > 1. Thanks to Kurt Hornik for the report. ([#319](https://github.com/joshuaulrich/quantmod/issues/319))

* `chartTheme()` now works when quantmod is not attached. Thanks to Kurt Hornik for the report.

{{< package-release-footer id="package-release-footer.html" package="quantmod" >}}
