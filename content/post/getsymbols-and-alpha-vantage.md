---
title: 'getSymbols and Alpha Vantage'
date: 2017-10-06T16:12:00.000-05:00
draft: false
aliases: [ "/2017/10/getsymbols-and-alpha-vantage.html" ]
tags : [Releases, quantmod, R]
---

Thanks to [Paul Teetor](http://quantdevel.com/public/), `getSymbols()` can now import data from [Alpha Vantage](https://www.alphavantage.co/)!  This feature is part of the [quantmod](http://www.quantmod.com/) 0.4-11 release, and provides another [another data source](http://blog.fosstrading.com/2017/06/yahoo-finance-alternatives.html) to avoid any [Yahoo Finance API changes](http://blog.fosstrading.com/2017/06/quantmod-0-4-9-on-cran.html)\*.
  
Alpha Vantage is a free web service that provides real-time and historical equity data.  They provide daily, weekly, and monthly history for both domestic and international markets, with up to 20 years of history. Dividend and split adjusted close prices are available for daily data. They also provide near real-time price bars at a resolution of 1 minute or more, for up to 10 recent days.

All you need to get started is a [one-time registration for an API key](https://www.alphavantage.co/support/#api-key).  Alpha Vantage has [clean, documented, public API](https://www.alphavantage.co/documentation/) that returns either JSON-encoded data or a CSV file.  The arguments to `getSymbols.av()` closely follow the native API, so be sure to use their documentation!

To get started, install the latest [quantmod from CRAN](https://cran.r-project.org/package=quantmod).  Then you call:

```r
getSymbols("MSFT", src = "av", api.key = "\[your key\]") 
```

Where you replace `"\[your key"\]` with the API key you receive after registration.  You can use `setDefaults()` to set your API key one time, and use it for all `getSymbols.av()` calls.

```r
setDefaults("getSymbols.av", api.key = "\[your key\]")
```

\* Speaking of API changes, this release also includes a fix for a Yahoo Finance change ([#174](https://github.com/joshuaulrich/quantmod/issues/174)).
