---
title: 'TTR_0.2 on CRAN'
date: 2009-02-15T18:51:00.000-06:00
draft: false
aliases: [ "/2009/02/ttr02-on-cran.html" ]
categories: [ R Package Releases ]
tags : [Releases, TTR]
---

I am happy to announce a long-overdue update to the TTR package (version 0.2) is now on CRAN.  
  
This update represents a major milestone, as TTR useRs are no longer restricted to using matrix objects. TTR 0.2 uses [xts](https://cran.r-project.org/package=xts) internally, so all major time series classes are now supported.  
  
NEW FEATURES:  
  
- Added the zig zag indicator: `ZigZag()`  
- Added volatility estimators/indicators: `volatility()`, with the following calculations  
    - Close-to-Close  
    - Garman Klass  
    - Parkinson  
    - Rogers Satchell  
- Added Money Flow Index: `MFI()`  
- Added Donchian channel: `DonchianChannel()`  
  
  
CHANGES:  
- All functions now use xts internally, adding support for all major time series classes. If `try.xts()` fails on the input object(s), they will be converted to a matrix and a matrix object will be returned.  
- Added `bounded` arg to `stoch()` and `SMI()`, which includes the current period in the calculation.  
- Added `naCheck()` and implemented it in the moving average functions.  
- Moved `maType` argument default values from function formals to function body for the following functions:  
`ADX()`, `ATR()`, `CCI()`, `DPO()`, `EMV()`, `KST()`, `MACD()`, `RSI()`, `TRIX()`, `BBands()`, `chaikinVolatility()`, `stoch()`, `SMI()`  
- `momentum()` in `CMO()` no longer sets `na=100`  
- Replaced `na` argument in `momentum()` and `ROC()` with `na.pad`  
- Added `multiple` argument to `TDI()`, allowing more user control  
- `getYahooData()` now returns an xts object  
- Added colnames to output for `ADX()`, `EMV()`, and `CLV()` (for xts)  
- Added unit tests using the [RUnit](https://cran.r-project.org/package=RUnit) package  
- Used `checkEquals()` on object attributes as well as values  
- Removed `.First.lib` function and added `.onLoad()` with package version.  
  
  
BUG FIXES:  
  
- Corrected NaN replacement in `CLV()`  
- Corrected `williamsAD()`: AD=0 if C(t)=C(t-1)  
- Corrected `runMedian()` and `runMAD()`. The argument controlling which type of median to calculate for even-numbered samples wasn't being passed to the Fortran routine.  
- `aroon()` calculation starts at period `n+1`, instead of `n`  
- Added `NA` to first element of `closeLag` of `ATR()`  
- Corrected `BBands()` and `CCI()` for `rowMeans()` use on xts objects  
- Made changes to Rd files to pass `R CMD check` on R-devel (2.9.0)  
  
Please do contact me with any questions, concerns, bug reports, etc.

{{< package-release-footer id="package-release-footer.html" package="ttr" >}}
