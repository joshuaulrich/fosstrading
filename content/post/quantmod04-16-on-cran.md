---
title: 'quantmod_0.4-16 on CRAN'
date: 2020-03-10T07:23:00.000-05:00
draft: false
aliases: [ "/2020/03/quantmod04-16-on-cran.html" ]
tags : [Releases, quantmod, R]
---

A new version of [quantmod](http://www.quantmod.com/) is on [CRAN](https://cran.r-project.org/package=quantmod)! One really cool thing about this release is that almost all the changes are contributions from the community.  
  
[Ethan Smith](https://github.com/ethanbsmith) made more excellent contributions to `getQuote()` in this release. It no longer throws an error if one or more symbols are missing.  And it handles multiple symbols in a semicolon-delimted string, just like `getSymbols()`. For example, you can get quotes for multiple symbols by calling `getQuote("SPY;AAPL")`.  

[@jrburl](https://github.com/jrburl) made a great enhancement to `getOptionChain()`. Now, instead of throwing an error, it sets volume and open interest to `NA` if those columns are missing from the Yahoo Finance data. They also submitted a pull request to handle cases where Bid and/or Ask data are missing too. Unfortunately, that pull request came after I had already pushed to CRAN.  
  
Unfortunately, [Yahoo! Finance](https://finance.yahoo.com/) continues to make changes to how they return data. Thankfully, quantmod users are diligent and catch these changes. [@helgasoft](https://github.com/helgasoft/) noticed the split ratio delimiter changed from `/` to `:`. So, for example, a 2-for-1 split was `1/2` but is now `2:1`.  
  
[@helgasoft](https://github.com/helgasoft/) also noticed that [Alpha Vantage](https://www.alphavantage.co/) discontinued their "batch quote" functionality, which broke `getQuote()`. Thankfully, they provided a patch that used the single-quote request, so `getQuote()` works with Alpha Vantage again!  
  
[@matiasandina](https://github.com/matiasandina) noticed that I had incorrectly labelled the dividend pay date as the ex-dividend date in the data `getQuote()` returned from Yahoo Finance. Whoops!  
  
See the [news](https://cran.r-project.org/web/packages/quantmod/news/news.html) file for the other bug fixes. Thanks for using quantmod!
