---
title: 'Tactical asset allocation using quantstrat'
date: 2011-08-23T20:55:00.000-05:00
draft: false
aliases: [ "/2011/08/tactical-asset-allocation-using.html" ]
tags : [Examples, Code, quantstrat]
---

As promised in the [introduction to quantstrat](http://blog.fosstrading.com/2011/08/introduction-to-quantstrat.html), here is an example strategy.  I thought I'd start with the obligatory tactical asset allocation (TAA) strategy.  This post will replicate the strategy in the post, [tactical asset allocation using blotter](http://blog.fosstrading.com/2009/11/tactical-asset-allocation-using-blotter.html).  
  
The "faber" demo in the quanstrat package contains a TAA strategy but it uses a slightly different approach than the code we're trying to replicate.  There are two major differences:  

1.  The blotter TAA code initiates a position at the first observation where the close is above the SMA.  The demo only initiates a position when the close _crosses_ the SMA to the upside.  
      
    For example, assume the close is above the SMA at the beginning of the sample.  The demo has to wait for the close to drop below the SMA and then cross above it before taking a position; the blotter TAA code initiates a position on the first observation.  
      
    
2.  The blotter TAA code calculates order size based on total account equity (as stored in the `UnitSize` object).  The demo always uses an order size of 1,000 shares, regardless of total account value (in case you're wondering, yes, capital/equity-aware order sizing is on the to-do list).

We need to make a few changes to the `demo(faber)` code to make it work more like the blotter TAA post.  First, we change the `add.signal` calls to use `sigCrossover` instead of `sigComparison`.  This allows us to create an order on the first observation, rather than wait for a crossover.  
  
Next, we need to change the first call to `add.rule` (the entry rule).  `sigComparison` will be `TRUE` for every period where the close is above the SMA and we don't want to buy 1000 shares every period, so we need to tell `ruleSignal` to use the max position order sizing function.  We do this by adding `osFUN=osMaxPos` to the list of arguments passed to `ruleSignal`.  
  
Finally, we need to set the position limits for each instrument.  We do this via two calls to `addPosLimit` (one for each symbol) and we set the maximum position to 1000 shares and the minimum position to 0 shares.  
  
The modified code is below and even includes some simple evaluation of the results at no extra charge.  The `tradeStats` function has a ton more columns; I've only selected a few to make the output more readable.  Feel free to tinker.  
  
NOTE: I wrote this code using the latest quantmod, xts, and zoo from CRAN; and the latest blotter, FinancialInstrument, and quantstrat from R-Forge.  
  

```r
# This code is a slight modification of the quantstrat "faber" demo, intended to replicate   
# http://blog.fosstrading.com/2009/11/tactical-asset-allocation-using-blotter.html   
# Uncomment the line below to install the latest packages on R-Forge:  
#install.packages(c("quantstrat","blotter","FinancialInstrument"), repos="http://r-forge.r-project.org")

require(quantstrat)
require(PerformanceAnalytics)

# Set initial values
initDate <- "2002-07-31"
endDate <- "2009-10-31"
initEq <- 100000

# Pull Yahoo Finance data
symbols <- c("IEF", "SPY")
getSymbols(symbols, from=initDate, to=endDate, index.class=c("POSIXt","POSIXct"))

# adjust for splits/dividends (comment to replicate blotter example)
#IEF <- adjustOHLC(IEF, use.Adjusted=TRUE)
#SPY <- adjustOHLC(SPY, use.Adjusted=TRUE)

# convert to monthly
IEF <- to.monthly(IEF, indexAt="endof")
SPY <- to.monthly(SPY, indexAt="endof")

# Set up instruments with FinancialInstruments package
currency("USD")
for(symbol in symbols) {
  stock(symbol, currency="USD", multiplier=1)
}

# Delete portfolio, account, and order book if they already exist
suppressWarnings(rm("account.faber","portfolio.faber",pos=.blotter))
suppressWarnings(rm("order_book.faber",pos=.strategy))

# Initialize portfolio and account
initPortf("faber", symbols=symbols, initDate=initDate)
initAcct("faber", portfolios="faber", initDate=initDate, initEq=initEq)
initOrders(portfolio="faber", initDate=initDate)

# Initialize a strategy object
stratFaber <- strategy("faber")

# Add the 10-month SMA indicator
stratFaber <- add.indicator(strategy=stratFaber, name="SMA",
  arguments=list(x=quote(Cl(mktdata)), n=10), label="SMA10")

# There are two signals:
# The first is when monthly price crosses over the 10-month SMA
stratFaber <- add.signal(stratFaber, name="sigComparison",
  arguments=list(columns=c("Close","SMA10"),relationship="gte"), label="Cl.gt.SMA")

# The second is when the monthly price crosses under the 10-month SMA
stratFaber <- add.signal(stratFaber, name="sigComparison",
  arguments=list(columns=c("Close","SMA10"),relationship="lt"), label="Cl.lt.SMA")

# There are two rules:
# The first is to buy when the price crosses above the SMA
stratFaber <- add.rule(stratFaber, name="ruleSignal",
  arguments=list(sigcol="Cl.gt.SMA", sigval=TRUE, orderqty=1000, ordertype="market",
  orderside="long", pricemethod="market", TxnFees=-5, osFUN=osMaxPos), type="enter", path.dep=TRUE)

# The second is to sell when the price crosses below the SMA
stratFaber <- add.rule(stratFaber, name="ruleSignal",
  arguments=list(sigcol="Cl.lt.SMA", sigval=TRUE, orderqty="all", ordertype="market",
  orderside="long", pricemethod="market", TxnFees=-5), type="exit", path.dep=TRUE)

# Set position limits so we don't add to the position every month Close > SMA10
addPosLimit("faber", "SPY", timestamp=initDate, maxpos=1000, minpos=0)
addPosLimit("faber", "IEF", timestamp=initDate, maxpos=1000, minpos=0)

# Process the indicators and generate trades
out <- try(applyStrategy(strategy=stratFaber, portfolios="faber"))
updatePortf("faber")

# Evaluate results
portRet <- PortfReturns("faber")
portRet$Total <- rowSums(portRet, na.rm=TRUE)
charts.PerformanceSummary(portRet$Total)
tradeStats("faber")[,c("Symbol","Num.Trades","Net.Trading.PL","Max.Drawdown")]

