---
title: 'quantmod 0.4-9 on CRAN'
date: 2017-06-07T12:25:00.004-05:00
draft: false
aliases: [ "/2017/06/quantmod-0-4-9-on-cran.html" ]
tags : [HIstorical Data, Releases, quantmod, R]
---

A new release of [quantmod](http://www.quantmod.com/) is now on [CRAN](https://cran.r-project.org/package=quantmod)! The only change was to address changes to [Yahoo! Finance](https://finance.yahoo.com/) and their effects on getSymbols.yahoo().  GitHub issue [#157](https://github.com/joshuaulrich/quantmod/issues/157) contains some details about the fix implementation.  
  
Unfortunately, the URL wasn't the only thing that changed.  The actual data available for download changed as well.  
  
The most noticeable difference is that the adjusted close column is no longer dividend-adjusted (i.e. it's only split-adjusted).  Also, only the close price is unadjusted; the open, high, and low are split-adjusted.  
  
There also appear to be issues with the adjusted prices in some instruments.  For example, users reported issues with split data for XLF and SPXL in GitHub issue [#160](https://github.com/joshuaulrich/quantmod/issues/160).  For XLF, there a split _and_ a dividend on 2016-09-16, even on the [Yahoo! Finance historical price page for XLF](https://finance.yahoo.com/quote/XLF/history?period1=1473138000&period2=1474866000&interval=1d&filter=history&frequency=1d). As far as I can tell, there was only a special dividend.  The problem with SPXL is that the adjusted close price isn't adjusted for the 4/1 split on 2017-05-01, which is also reflected on the [Yahoo! Finance historical prices page for SPXL](https://finance.yahoo.com/quote/SPXL/history?period1=1488088800&period2=1495774800&interval=1d&filter=history&frequency=1d).  
  
Another change is that the downloaded data may contain rows where all the values are "null".  These appear on the website as "0".  This is a major issue for some instruments.  Take XLU for example; 188 of the 624 days of data are missing between 2014-12-04 and 2017-05-26 (ouch!).  You can see this is even true on the [Yahoo! Finance historical price page for XLU](https://finance.yahoo.com/quote/XLU/history?period1=1417672800&period2=1422079200&interval=1d&filter=history&frequency=1d).  
  
If these changes have made you look for a new data provider, see my post: [Yahoo! Finance Alternatives](http://blog.fosstrading.com/2017/06/yahoo-finance-alternatives.html).