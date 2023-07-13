---
title: 'quantmod_0.4-14 on CRAN'
date: 2019-03-25T06:53:00.000-05:00
draft: false
aliases: [ "/2019/03/quantmod04-14-on-cran.html" ]
categories: [ R Package Releases ]
tags : [Releases, quantmod, R]
---

I just pushed a new release of [quantmod](http://www.quantmod.com/) to [CRAN](https://cran.r-project.org/package=quantmod)! `getSymbols()` no longer stops if there's a problem with a ticker symbol. And `getQuote()` can now import quotes from [Tiingo](https://www.tiingo.com/).

<!--more-->

I'm most excited about the update to `getSymbols()` so it doesn't throw an error and stop processing if there's a problem with one ticker symbol. Now `getSymbols()` will import all the data it can, and provide an informative error message for any ticker symbols it could not import.  

At a close second, I'm also excited about being able to import quotes from [Tiingo](https://www.tiingo.com/) using `getQuote()`!. But don't thank me; thank [Ethan Smith](https://github.com/ethanbsmith) for the feature request \[[#247](https://github.com/joshuaulrich/quantmod/issues/247)\] and pull request \[[#250](https://github.com/joshuaulrich/quantmod/pull/250)\].  
  
There are also several bug fixes in this release.  The most noticeable are fixes to `getDividends()`  and `getSplits()`. [Yahoo! Finance](https://finance.yahoo.com/) continues to have stability issues. Now it returns raw dividends instead of split-adjusted dividends (thanks to Douglas Barnard for the report \[[#253](https://github.com/joshuaulrich/quantmod/issues/253)\]), and the actual split adjustment ratio instead of the inverse (e.g. now 1/2 instead of 2/1).  I suggest using a different data provider. See my post: [Yahoo! Finance Alternatives](http://blog.fosstrading.com/2017/06/yahoo-finance-alternatives.html) for some suggestions.  
  
See the [news](https://cran.r-project.org/web/packages/quantmod/news/news.html) file for the other bug fixes. Please let me know what you think about these changes.  I need your feedback and input to make quantmod even better!

{{< package-release-footer id="package-release-footer.html" package="quantmod" >}}
