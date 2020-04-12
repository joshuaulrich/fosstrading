---
title: 'New quantmod and TTR on CRAN'
date: 2015-07-24T16:04:00.000-05:00
draft: false
aliases: [ "/2015/07/new-quantmod-and-ttr-on-cran.html" ]
tags : [Releases, quantmod, TTR, R]
---

I just sent [quantmod\_0.4-5](https://cran.r-project.org/package=quantmod) to [CRAN](https://cran.r-project.org/), and [TTR\_0.23-0](https://cran.r-project.org/package=TTR) has been there for a couple weeks. I'd like to thank [Ivan Popivanov](http://www.quintuitive.com/) for many useful reports and patches to TTR. He provided patches to add HMA (Hull MA), ALMA, and ultimateOscillator functions.  
  
[James Toll](http://jtoll.com/) provided a patch to the volatility function that uses a zero mean (instead of the sample mean) in close-to-close volatility. The other big change is that moving average functions no longer return objects with column names based on the input object column names. There are many other bug fixes (see the CHANGES file in the package).  
  
The biggest changes in quantmod were to fix getSymbols.MySQL to use the correct dbConnect call based on changes made in RMySQL\_0.10 and to fix getSymbols.FRED to use https:// instead of http:// when downloading FRED data. getSymbols.csv also got some much-needed love.  
  
I'd also like to mention that development has moved to GitHub for both [TTR](https://github.com/joshuaulrich/TTR) and [quantmod](https://github.com/joshuaulrich/quantmod).