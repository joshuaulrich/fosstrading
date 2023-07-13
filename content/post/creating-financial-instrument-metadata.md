---
title: 'Creating Financial Instrument metadata in R'
date: 2011-07-27T22:16:00.003-05:00
draft: false
aliases: [ "/2011/07/creating-financial-instrument-metadata.html" ]
categories: [ Articles ]
tags : [Data, R]
---

This is a guest post by [Ilya Kipnis](https://quantstrattrader.wordpress.com/about/). He blogs at [QuantStrat TradeR](https://quantstrattrader.wordpress.com).
  
When trading stocks in a single currency, instrument [metadata](http://en.wikipedia.org/wiki/Metadata) can be safely ignored because the multiplier is 1 and the currencies are all the same.  When doing analysis on fixed income products, options, futures, or other complex derivative instruments, the data defining the properties of these instruments becomes critical to tasks like accounting for value of trades, or comparing notional value between more than one instrument. The [FinancialInstrument](http://r-forge.r-project.org/R/?group_id=316) package provides a construct for storing metadata for tradeable contracts (referred to as instruments, e.g. stocks, futures, options, etc.) and their root representations.  It can be used to create any asset class and complex derivatives, across multiple currencies.   
  
In [tactical asset allocation using blotter](http://blog.fosstrading.com/2009/11/tactical-asset-allocation-using-blotter.html), Joshua Ulrich used FinancialInstrument (blotter depends on it) to create a stock portfolio.  FinancialInstrument is also a required dependency of the quantstrat quantitative strategy framework in R (quantstrat will be covered in a later post).  
  
Creating a list of historical symbols is a recurring challenge with historical data on derivative instruments.  These symbols tend to follow a deterministic pattern and FinancialInstrument provides utility functions to create the symbols traded over specific periods of time. These symbols could then be used to request historical data from a data vendor or to construct instrument objects in R.  
  
The simplest function for generating a series of symbols is `build_series_symbols()`.  Let's look at it with a small example using crude oil (CL) and STOXX (STXE) futures:  
  
```r
# install.packages("FinancialInstrument", repos="http://R-Forge.R-project.org")  
require(FinancialInstrument)  
Data <- data.frame(primary_id="CL", month_cycle="F,G,H,J,K,M,N,Q,U,V,X,Z")  
Data <- rbind(Data, data.frame(primary_id="STXE", month_cycle="H,M,U,Z"))  
Data  
##   primary_id               month_cycle  
## 1         CL   F,G,H,J,K,M,N,Q,U,V,X,Z  
## 2       STXE                   H,M,U,Z  
```
  
The `Data` object contains two columns.  The `primary_id` is the root contract that identifies the instrument, and the `month_cycle` defines the months the contracts trade in (e.g. "H,M,U,Z" for Mar/Jun/Sep/Dec).  
  
`build_series_symbols()` only needs `Data` and `yearlist`. `yearlist` is the suffix for expiration years and 0, 1, 2 represent 2010, 2011, 2012 in this example.  `build_series_symbols()` returns a vector of series symbols that we could use to request data or create `future_series` instruments.  
  
```r
build_series_symbols(Data, yearlist=c(0,1,2))  
## [1] "CLF0"   "CLG0"   "CLH0"   "CLJ0"   "CLK0"   "CLM0"   "CLN0"   "CLQ0"   
## [9] "CLU0"   "CLV0"   "CLX0"   "CLZ0"   "STXEH0" "STXEM0" "STXEU0" "STXEZ0"  
## [17] "CLF1"   "CLG1"   "CLH1"   "CLJ1"   "CLK1"   "CLM1"   "CLN1"   "CLQ1"   
## [25] "CLU1"   "CLV1"   "CLX1"   "CLZ1"   "STXEH1" "STXEM1" "STXEU1" "STXEZ1"  
## [33] "CLF2"   "CLG2"   "CLH2"   "CLJ2"   "CLK2"   "CLM2"   "CLN2"   "CLQ2"   
## [41] "CLU2"   "CLV2"   "CLX2"   "CLZ2"   "STXEH2" "STXEM2" "STXEU2" "STXEZ2"  
```

A more complicated task is to create symbols for exchange guaranteed calendar spreads.  The `build_spread_symbols()` function creates a vector of symbols for spreads of securities (currently coded for futures calendar spreads but can be extended and generalized) in a very shorthand notation.  
  
`build_spread_symbols()` accepts instrument specifications via either a file path or (preferably) a data frame (using the file or data arguments, respectively). Output can be assigned to an object or written to a file using the optional `outputfile` argument.  The default starting date is the current date, but the user can manually set a starting date (e.g. historical dates for backtesting, and future dates to create lists of instruments to be traded in the future).  
  
```r
# read in data that would be suitable for load.instruments on root contracts  
# series_data.csv can be downloaded here:
# https://docs.google.com/leaf?id=0B8wl4QBejPGiMjI2NTQzZjEtZDRkNC00MDRjLWI2ZDgtMzhjOTM5ZGFkYmFk&hl=en_US)"
Data <- read.csv("series_data.csv", stringsAsFactors=FALSE)  
# set the type to guaranteed_spread  
Data$type <- "guaranteed_spread"  
# call build_spread_symbols  
output <- build_spread_symbols(Data[6:7,], start_date="2010-01-01")  
```
  
The critical fields in the data (CSV or data frame) are the `primary_id`, the type (e.g. future, calendar spread, inter-commodity spread, etc.), the `month_cycle`, and the `active_months` (how many contracts to display).  For instance, an `active_months` value of 12 on a contract that trades quarterly ("H,M,U,Z") would create front month contracts for the next 3 years.  An `active_months` value of 6 on this same quarterly contract would produce 1.5 years.  On a contract that trades 12 months a year ("F,G,H,J,K,M,N,Q,U,V,X,Z"), an `active_months` value of 12 would produce 1 year of contracts, and a value of 6 would only produce half a year.  
  
Lastly, the `contracts_ahead` field specifies the month spread on calendar spread type securities.  Note that these are **contracts** ahead and not months ahead.  For example, if you consider a contract trading "H,M,U,Z" vs. a contract trading "F,G,H,J,K,M,N,Q,U,V,X,Z", a value of 1 for the "H,M,U,Z" contract would create an H1-M1 spread or the like, while a value of 1 with the 12-month traded contract would create an F1-G1 spread.  
  
The rest of the columns simply get carried over, for further use in other programs/scripts/procedures, such as the `load.instruments()` function.  
  
_About the Author: Ilya Kipnis holds a Master's degree in Statistics from Rutgers, and uses and contributes to the R packages blotter, FinancialInstrument, and quantstrat. Ilya may be contacted for consulting and full-time opportunities in finance at ilya.kipnis@gmail.com._
