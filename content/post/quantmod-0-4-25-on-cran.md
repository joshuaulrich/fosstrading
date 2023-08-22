---
title: 'quantmod_0.4.25 on CRAN'
date: 2023-08-22T11:41:57.000-05:00
draft: false
categories: [ R Package Releases ]
tags : [Releases, quantmod, R]
---

An updated version of [quantmod](http://cran.r-project.org/package=quantmod) is now on [CRAN](http://cran.r-project.org/). 
It includes an awesome new feature that allows you to import up to 7 days of intraday data from Yahoo Finance!

<!--more-->

### New Features

* `getSymbols.yahoo()` can import up to 7 days of intraday data! Thanks to [@kapsner](https://github.com/kapsner) for the report and patch! ([#351](https://github.com/joshuaulrich/quantmod/issues/351), [#381](https://github.com/joshuaulrich/quantmod/issues/381)) It will throw a warning if you try to request more than 7 days of intraday data, but you can suppress the warning (thanks to [Dirk Eddelbuettel](https://dirk.eddelbuettel.com/)). ([#399](https://github.com/joshuaulrich/quantmod/issues/399))

* Add warning if `getSymbols()` is called with tickers that are reserved words because accessing them requires back-quotes (e.g. ``NA``). ([#401](https://github.com/joshuaulrich/quantmod/issues/401))

### Bug Fixes

* Fix `getQuote.yahoo()` for API changes. Thanks to Ethan B. Smith for the report and patch! Also add error message for users in GDPR countries, since we cannot automatically consent to GDPR and the request fails without consent. ([#392](https://github.com/joshuaulrich/quantmod/issues/392), [#393](https://github.com/joshuaulrich/quantmod/issues/393), [#395](https://github.com/joshuaulrich/quantmod/issues/395))

* Fix `getQuote.yahoo()` when the user only requested metrics that do not have have a value for 'regularMarketTime'. Set the value to NA in these cases so the output remains the same regardless of whether the endpoint returns a 'regularMarketTime' or not. Thanks to [@mehdiMBH](https://github.com/mehdiMBH) for the report! ([#255](https://github.com/joshuaulrich/quantmod/issues/255))

* Add fields to `getQuote.yahoo()` that are returned when no fields are explicitly requested. Thanks to [@Courvoisier13](https://github.com/Courvoisier13) for the report! ([#335](https://github.com/joshuaulrich/quantmod/issues/335))

* Fix `allReturns()` when 'subset' is specified. Thanks to [@Panagis1980](https://github.com/Panagis1980) for the report! ([#402](https://github.com/joshuaulrich/quantmod/issues/402))

{{< package-release-footer id="package-release-footer.html" package="quantmod" >}}
