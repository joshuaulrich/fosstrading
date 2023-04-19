---
title: 'quantmod 0.4-6 on CRAN'
date: 2016-08-29T11:38:00.000-05:00
draft: false
aliases: [ "/2016/08/quantmod-0-4-6-on-cran.html" ]
tags : [Releases, quantmod, R]
---

[CRAN](https://cran.r-project.org/) just accepted a bugfix release of [quantmod](http://www.quantmod.com/).  The most pertinent changes were to fix getSymbols.oanda ([#36](https://github.com/joshuaulrich/quantmod/issues/36)) and getOptionChain.yahoo ([#92](https://github.com/joshuaulrich/quantmod/issues/92)).  It also includes a fix to addTRIX ([#72](https://github.com/joshuaulrich/quantmod/issues/72)).  
  
Oanda changed their URL format from http to https, and getSymbols.oanda did not follow the redirect.  Yahoo Finance changed the HTML for displaying options data, which broke getOptionChain.yahoo.  The fix downloads JSON instead of scraping HTML, so hopefully it will be less likely to break.  For more information, see the links to the GitHub issues above.  
  
I added documentation for getPrice ([#77](https://github.com/joshuaulrich/quantmod/issues/77)), and removed the unused unsetSymbolLookup function and corresponding documentation ([#115](https://github.com/joshuaulrich/quantmod/issues/115)).

{{< package-release-footer id="package-release-footer.html" package="quantmod" >}}
