---
title: 'quantmod 0.4-8 on CRAN'
date: 2017-04-19T10:45:00.000-05:00
draft: false
aliases: [ "/2017/04/quantmod-0-4-8-on-cran.html" ]
tags : [Releases, quantmod, R]
---

I pushed a bug-fix release of [quantmod](http://www.quantmod.com/) to [CRAN](https://cran.r-project.org/) last night. The major changes were to  

*   getSymbols.FRED ([#141](https://github.com/joshuaulrich/quantmod/issues/141))
*   getSymbols.oanda ([#144](https://github.com/joshuaulrich/quantmod/issues/144))
*   getSymbols.yahoo ([#149](https://github.com/joshuaulrich/quantmod/issues/149))

All three providers made breaking changes to their URLs/interfaces.  
  
getSymbols.google also got some love. It now honors all arguments set via setSymbolLookup ([#138](https://github.com/joshuaulrich/quantmod/issues/138)), and it correctly parses the date column in non-English locales ([#140](https://github.com/joshuaulrich/quantmod/issues/140)).  
  
There's a handy new argument to getDividends: split.adjust. It allows you to request dividends unadjusted for splits ([#128](https://github.com/joshuaulrich/quantmod/issues/140)). Yahoo provides split-adjusted dividends, so you previously had to manually unadjust them for splits if you wanted the original raw values. To import the raw unadjusted dividends, just call:  
  
rawDiv <- getDividends("IBM", split.adjust = FALSE)  
  
Note that the default is split.adjust = TRUE to maintain backward-compatibility.