---
title: 'How to backtest a strategy in R'
date: 2011-03-26T09:54:00.001-05:00
draft: false
aliases: [ "/2011/03/how-to-backtest-strategy-in-r.html" ]
categories: [ Articles ]
tags : [Examples, Excel, R]
---

This is the third post in the [Backtesting in Excel and R](http://blog.fosstrading.com/2011/02/backtesting-in-excel-and-r.html) series and it will show how to backtest a simple strategy in R.  It will follow the 4 steps Damian outlined in his post on [how to backtest a simple strategy in Excel](http://blog.fosstrading.com/2011/03/how-to-backtest-strategy-in-excel.html).  
  
**Step 1: Get the data**  
The `getSymbols` function in [quantmod](http://www.quantmod.com/) makes this step easy if you can use daily data from [Yahoo Finance](http://finance.yahoo.com/).  There are also "methods" (not in the strict sense) to pull data from other sources (FRED, Google, Oanda, R save files, databases, etc.).  You could also use them as a template to write a custom function for a particular vendor you use.  
  
```r
# run the command below if quantmod isn't already installed
# install.packages("quantmod")
# use the quantmod package (loads TTR, xts, and zoo)
require(quantmod)

# pull SPX data from Yahoo (getSymbols returns an xts object)
getSymbols("^GSPC")
```
  
**Step 2: Create your indicator**  
The [TTR package](http://cran.r-project.org/web/packages/TTR/) contains a multitude of indicators.  The indicators are written to make it easy to [combine them in creative and unconventional ways](http://www.rinfinance.com/agenda/2010/JoshUlrich.pdf).  Starting with revision 106 on R-forge, TTR has a [DVI indicator](http://marketsci.wordpress.com/2010/07/27/css-analytics%E2%80%99-dvi-indicator-revealed/).  
  
```r
# calculate DVI indicator
dvi <- DVI(Cl(GSPC))  # Cl() extracts the close price column
```
  
**Step 3: Construct your trading rule**  
Since this trading rule is simple--we're long 100% if the DVI is below 0.5 and short 100% otherwise--it can be written in a single line.  More elaborate rules and/or position sizings can be done as well, but require more code ([RSI(2) with Position Sizing](http://blog.fosstrading.com/2009/05/rsi2-with-position-sizing.html) is an example of more complex position sizing rules).  Also notice that the signal vector is lagged, which avoids look-ahead bias.  
  
```r
# create signal: (long (short) if DVI is below (above) 0.5)
# lag so yesterday's signal is applied to today's returns
sig <- Lag(ifelse(dvi$dvi < 0.5, 1, -1))
```
  
**Step 4: The trading rules/equity curve**  
As in Damian's example, the code below is a simplified approach that is frictionless and does not account for slippage.  The code below takes today's percentage return and multiplies it by yesterday's signal / position size (always +/- 100% in this example).  I also subset the system returns to match the results in the [Excel file](http://dl.dropbox.com/u/17693/DVI%20long-short.xlsx).  

```r
# calculate signal-based returns
ret <- ROC(Cl(GSPC))*sig

# subset returns to match data in Excel file
ret <- ret["2009-06-02/2010-09-07"]
```
  
**Step 5: Evaluate strategy performance**  
Damian mentioned the importance of evaluating your strategy.  Fortunately for R users, the [PerformanceAnalytics package](http://cran.r-project.org/web/packages/PerformanceAnalytics/) makes this easy.  With a few lines of code we can view the drawdowns, downside risks, and a performance summary.  
  
```r
# use the PerformanceAnalytics package
# install.packages("PerformanceAnalytics")
require(PerformanceAnalytics)

# create table showing drawdown statistics
table.Drawdowns(ret, top=10)

# create table of downside risk estimates
table.DownsideRisk(ret)

# chart equity curve, daily performance, and drawdowns
charts.PerformanceSummary(ret)
```
  
That's all there is to backtesting a simple strategy in R.  It wasn't that intimidating, was it?  Please leave feedback if you're moving your backtesting from Excel to R and there's something you're hung up on or you have an awesome tip you'd like to share.  
  
Here's a succinct version of the code in the above post if you want to be able to copy / paste it all in one block:  

```r
require(quantmod)
require(PerformanceAnalytics)

# Step 1: Get the data
getSymbols("^GSPC")

# Step 2: Create your indicator
dvi <- DVI(Cl(GSPC))

# Step 3: Construct your trading rule
sig <- Lag(ifelse(dvi$dvi < 0.5, 1, -1))

# Step 4: The trading rules/equity curve
ret <- ROC(Cl(GSPC))*sig
ret <- ret["2009-06-02/2010-09-07"]
eq <- exp(cumsum(ret))
plot(eq)

# Step 5: Evaluate strategy performance
table.Drawdowns(ret, top=10)
table.DownsideRisk(ret)
charts.PerformanceSummary(ret)
```
