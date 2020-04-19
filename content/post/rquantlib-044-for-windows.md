---
title: 'RQuantLib 0.4.4 for Windows'
date: 2018-01-05T14:02:00.001-06:00
draft: false
aliases: [ "/2018/01/rquantlib-044-for-windows.html" ]
tags : [Releases, R]
---

I'm pleased to announce that the [RQuantLib](https://cran.r-project.org/package=RQuantLib) Windows binaries are now up to 0.4.4!  The RQuantLib pre-built Windows binaries have been frozen on CRAN since 0.4.2, but now you can get version 0.4.4 binaries on [Dirk's](http://dirk.eddelbuettel.com/) [ghrr drat repo](https://ghrr.github.io/drat/).

Installation is as simple as:

```r  
drat::addRepo("ghrr") # maybe use 'install.packages("drat")' first 
install.packages("RQuantLib", type="binary")
``` 

I will be able to create Windows binaries for future RQuantLib versions too, now that I have a Windows [QuantLib](http://quantlib.org/index.shtml) build (version 1.11) to link against.

Dirk and I plan to talk with CRAN about getting the new binaries hosted there.  Regardless, they will always be available via the drat repo.
