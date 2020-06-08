---
title: 'Import Japanese equity data into R with quantmod 0.4-4'
date: 2015-03-10T12:09:00.001-05:00
draft: false
aliases: [ "/2015/03/import-japanese-equity-data-into-r.html" ]
tags : [Releases, quantmod, R]
---

I pushed [quantmod 0.4-4 to CRAN](http://cran.r-project.org/web/packages/quantmod/) this weekend.  It adds a `getSymbols.yahooj` function to pull stock data from Yahoo Finance Japan, and fixes issues in `getOptionChain.yahoo` and `getSymbols.oanda`.  
  
Changes to the Yahoo Finance and Oanda websites broke the `getOptionChain.yahoo` and `getSymbols.oanda` functions, respectively.  I didn't use `getOptionChain.yahoo` much, so I’m not certain I restored all the prior functionality.  Let me know if there’s something I missed. I’d be glad to add a test case for that, or to add a test you've written.  
  
The `getSymbols.yahooj` function is a major enhancement provided by [Wouter Thielen](http://morannon.org/).  It allows quantmod users to pull stock data from Yahoo Finance Japan.   
  
Japanese ticker symbols usually start with a number and it is cumbersome to use variable names that start with a number in the R environment, so the string "YJ" will be prepended to each of the Symbols.  I recommend using `setSymbolLookup` to prepend the ticker symbols with "YJ" yourself, so you can just use the main `getSymbols` function.  
  
For example, if you want to pull Sony data, you would run:

```r
require(quantmod)
setSymbolLookup(YJ6758.T='yahooj')
getSymbols('YJ6758.T')  
```

The full list of supported data sources for quantmod is now: Yahoo Finance-US, Yahoo Finance-Japan, Google Finance, csv, RData (including rds and rda), FRED, SQLite, MySQL, and Oanda.   
  
Contributions to add support for additional data sources are welcomed.  The existing `getSymbols` functions are good templates to start from.
