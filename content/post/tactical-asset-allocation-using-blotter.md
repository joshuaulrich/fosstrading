---
title: 'Tactical asset allocation using blotter'
date: 2009-11-18T21:18:00.015-06:00
draft: false
aliases: [ "/2009/11/tactical-asset-allocation-using-blotter.html" ]
categories: [ Articles ]
tags : [blotter, Code]
---

**_NOTE: If you simply want to test strategies in R, please see the post: [Tactical Asset Allocation Using quantstrat](http://blog.fosstrading.com/2011/08/tactical-asset-allocation-using.html).  quantstrat uses blotter behind the scenes, but provides a higher level of abstraction._**  
  
[blotter](https://r-forge.r-project.org/projects/blotter) is an [R](http://www.r-project.org/) package that tracks the P&L of your trading systems (or simulations), even if your portfolio spans many security types and/or currencies. This post uses blotter to track a simple two-ETF trading system.  
  
The contents of this post borrow heavily from code and comments in the "longtrend" demo script in the blotter package. Many thanks to [Peter Carl](http://www.braverock.com/%7Epeter/) and [Brian Peterson](http://www.braverock.com/%7Ebrian/) for their hard work.  
  
The first chart shows the result of holding an equal-weight portfolio of [SPY](http://finance.yahoo.com/q?s=SPY) and [IEF](http://finance.yahoo.com/q?s=IEF) from 2002-07-31 to 2009-10-31. The 2008 bear market led to a 30% drawdown in this portfolio.  
  

![](/post-images/20091118_blotter_buyhold.png)

  
The second chart shows the result of following [Mebane Faber's](http://www.mebanefaber.com/) tactical asset allocation approach using the same ETFs and time period. Though it did not perform as well as buy-and-hold through 2007, the 2008 bear market only caused a 5% drawdown for this strategy. Both observations are consistent with the conclusion in [Faber's article](http://ssrn.com/abstract=962461).  
  

![](/post-images/20091118_blotter_strategy.png)

  
Without further ado, here's the code:  
  
```r
# This code implements the strategy found in:
# Faber, Mebane T., "A Quantitative Approach to Tactical Asset Allocation."
# Journal of Risk Management (Spring 2007).

# The article implements a simpler version of the 200-day SMA, opting for a
# 10-month SMA because monthly data are more easily available in earlier
# periods and lower granularity should translate to lower transaction costs.

# The rules of the system are relatively simple:
# - Buy when monthly price > 10-month SMA
# - Sell and move to cash when monthly price < 10-month SMA

# 1. All entry and exit prices are on the day of the signal at the close.
# 2. All data series are total return series including dividends, updated monthly.
# NOTE: For the purposes of this demo, we only use price returns.
# 3. Cash returns are estimated with 90-day commercial paper. Margin rates for
# leveraged models are estimated with the broker call rate.
# NOTE: For the purposes of this demo, we ignore interest and leverage.
# 4. Taxes, commissions, and slippage are excluded.

# Data:
# This demo uses monthly data downloaded from Yahoo Finance for two ETFs: SPY and
# IEF. These were chosen to illustrate the classic stock/bond asset portfolio.
# Though longer serires would be preferred, data for IEF begin in mid-2002.

# Load required libraries
library(quantmod)
library(TTR)
library(blotter) # r-forge revision 193
library(PerformanceAnalytics)

# Set initial values
initDate='2002-07-31'
endDate='2009-10-31'
initEq=100000

# Set currency and instruments
currency("USD")
stock("IEF",currency="USD",multiplier=1)
stock("SPY",currency="USD",multiplier=1)

# Load data with quantmod
print("Loading data")
symbols = c("IEF", "SPY")
getSymbols(symbols, from=initDate, to=endDate, index.class=c("POSIXt","POSIXct"))

# Adjust prices for splits/dividends (thanks pg)
#IEF = adjustOHLC(IEF)
#SPY = adjustOHLC(SPY)

# Convert data to monthly frequency (to.weekly() needs drop.time=FALSE)
IEF = to.monthly(IEF, indexAt='endof')
SPY = to.monthly(SPY, indexAt='endof')

# Set up indicators with TTR
print("Setting up indicators")
IEF$SMA = SMA(Cl(IEF), 10)
SPY$SMA = SMA(Cl(SPY), 10)

# Set up a portfolio object and an account object in blotter
initPortf(name='default', symbols=symbols, initDate=initDate)
initAcct(name='default', portfolios='default', initDate=initDate, initEq=initEq)
verbose = TRUE

# Create trades
for( i in 10:NROW(SPY) ) {
  CurrentDate=time(SPY)[i]
  equity = getEndEq(Account='default', CurrentDate)

  for( symbol in symbols ) {
    sym = get(symbol)
    ClosePrice = as.numeric(Cl(sym[i,]))
    Posn = getPosQty(Portfolio='default', Symbol=symbol, Date=CurrentDate)
    UnitSize = as.numeric(trunc((equity/NROW(symbols))/ClosePrice))

    # Position Entry (assume fill at close)
    if( Posn == 0 ) {
    # No position, so test to initiate Long position
      if( Cl(sym[i,]) > sym[i,'SMA'] ) {
        # Store trade with blotter
        addTxn('default', Symbol=symbol, TxnDate=CurrentDate,
          TxnPrice=ClosePrice, TxnQty=UnitSize, TxnFees=0, verbose=verbose)
      }
    } else {
      # Have a position, so check exit
      if( Cl(sym[i,]) < sym[i,'SMA'] ) {
        # Store trade with blotter
        addTxn(Portfolio='default', Symbol=symbol, TxnDate=CurrentDate,
          TxnPrice=ClosePrice, TxnQty=-Posn, TxnFees=0, verbose=verbose)
      }
    }
  } # End symbols loop

  # Calculate P&L and resulting equity with blotter
  updatePortf(Portfolio='default', Dates=CurrentDate)
  updateAcct(name='default', Dates=CurrentDate)
  updateEndEq(Account='default', Dates=CurrentDate)

} # End dates loop


# Buy and Hold cumulative equity
buyhold = exp(cumsum( ( 0.5*ROC(Cl(IEF)) + 0.5*ROC(Cl(SPY)) )[-1] ))

# Final values
cat('Tactical Asset Allocation Return: ',(getEndEq(Account='default', Date=CurrentDate)-initEq)/initEq,'\n')
cat('Buy and Hold Return: ',tail(buyhold,1)-1,'\n')

# Plot Strategy Summary
png(filename="20091118_blotter_strategy.png", 720, 720)

#charts.PerformanceSummary(ROC(getAccount('default')$TOTAL$End.Eq)[-1],main="Tactical Asset Allocation")

charts.PerformanceSummary(ROC(getAccount('default')$summary$End.Eq)[-1],main="Tactical Asset Allocation")

dev.off()

# Plot Buy and Hold Summary
png(filename="20091118_blotter_buyhold.png", 720, 720)
charts.PerformanceSummary(ROC(buyhold)[-1],main="Buy & Hold")
dev.off()
```
