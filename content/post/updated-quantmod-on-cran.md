---
title: 'Updated quantmod on CRAN'
date: 2014-12-15T09:43:00.003-06:00
draft: false
aliases: [ "/2014/12/updated-quantmod-on-cran.html" ]
categories: [ R Package Releases ]
tags : [Releases, quantmod, R]
---

An updated version of [quantmod](http://www.quantmod.com/) has just been released on [CRAN](http://cran.r-project.org/).  This is my first submission as the new maintainer.  The major change was removing the dependency on the [now-archived Defaults](http://cran.r-project.org/web/packages/Defaults/) package.  End-users shouldn't notice a difference, since I basically copied the necessary functionality from Defaults and added it to quantmod.  
  
There are also several bug fixes. A few worth noting are:  

*   [getSplits](http://r-forge.r-project.org/tracker/index.php?func=detail&aid=4768&group_id=125&atid=544)
*   [adjustOHLC](http://r-forge.r-project.org/tracker/index.php?func=detail&aid=5680&group_id=125&atid=544)
*   [getSymbols (when adjust=TRUE)](http://r-forge.r-project.org/tracker/index.php?func=detail&aid=735&group_id=125&atid=544)
*   [saveSymbols](http://r-forge.r-project.org/tracker/index.php?func=detail&aid=2665&group_id=125&atid=544)
*   [newTA](http://r-forge.r-project.org/tracker/index.php?func=detail&aid=5950&group_id=125&atid=544)
*   [findValleys](http://r-forge.r-project.org/tracker/index.php?func=detail&aid=5807&group_id=125&atid=544)
