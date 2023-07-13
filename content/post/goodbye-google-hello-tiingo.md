---
title: 'Goodbye Google, Hello Tiingo!'
date: 2018-04-13T11:14:00.001-05:00
draft: false
aliases: [ "/2018/04/goodbye-google-hello-tiingo.html" ]
categories: [ R Package Releases ]
tags : [Releases, quantmod, R]
---

First, the bad news:  
  
Google Finance no longer provides data for historical prices or financial statements, so we say goodbye to `getSymbols.google()` and `getFinancials.google()`. ([#221](https://github.com/joshuaulrich/quantmod/issues/221))  They are now defunct as of quantmod 0.4-13.  
  
Now, the good news:  
  
Thanks to [Steve Bronder](https://github.com/SteveBronder), `getSymbols()` can now import data from [Tiingo](https://www.tiingo.com/)! ([#220](https://github.com/joshuaulrich/quantmod/issues/220))  This feature is part of quantmod 0.4-13, which is [now on CRAN](https://cran.r-project.org/package=quantmod).  Windows and Mac binaries should be built in a day or two.  
  
[Tiingo](https://www.tiingo.com/) is a web service that provides tools and data for financial analysis.  They provide daily price history for US stocks and ADRs, Chinese stocks, Mutual Funds, and ETFs.  There is up to 30+ years of history, including raw prices and split/dividend adjusted prices.  
  
All this data is accessible for free, with reasonable symbol and bandwidth limits.  All you need to get started is a one-time registration for an API token.  You should see your API token just above the beginning of the [metadata section](https://api.tiingo.com/docs/tiingo/daily#metaData), after logging in, of course.  Tiingo has a well-documented [daily price data API](https://api.tiingo.com/docs/tiingo/daily) that returns either JSON or CSV.  
  
To get started, install the latest [quantmod from CRAN](https://cran.r-project.org/package=quantmod).  Then you call:  

```r
getSymbols("MSFT", src = "tiingo", api.key = "\[your key\]")   
```
  
Where you replace `"\[your key\]"` with the API key you receive after registration.  You can use `setDefaults()` to set your API key one time, and use it for all `getSymbols.tiingo()` calls.  
  
```r
setDefaults("getSymbols.tiingo", api.key = "\[your key\]")  
```

Other notable changes:  

*   There is now a `getQuote.alphavantage()` that allows you to pull real-time quotes from Alpha Vantage.  Thanks to [Ethan Smith](https://github.com/ethanbsmith)! ([#213](https://github.com/joshuaulrich/quantmod/issues/213), [#223](https://github.com/joshuaulrich/quantmod/issues/223))
*   Speaking of [Alpha Vantage](https://www.alphavantage.co/), getSymbols.av() can now pull weekly and monthly adjusted prices. ([#212](https://github.com/joshuaulrich/quantmod/issues/212))
*   The URL in `getSymbols.oanda()` and `getFX()` has been updated, so they work again. ([#225](https://github.com/joshuaulrich/quantmod/issues/225))
*   `getQuote.yahoo()` no longer errors when a field has no data for all requested tickers. ([#208](https://github.com/joshuaulrich/quantmod/issues/208))
*   `saveChart()` actually saves charts now ([#154](https://github.com/joshuaulrich/quantmod/issues/154)). Brilliant!
