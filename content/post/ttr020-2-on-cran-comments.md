---
title: 'TTR_0.20-2 on CRAN'
date: 2010-03-30T14:48:00.002-05:00
draft: false
aliases: [ "/2010/03/ttr020-2-on-cran.html" ]
tags : [TTR]
---

#### Can you describe how the various trading packages ...
[Milk Trader](https://www.blogger.com/profile/15008769973064875700 "noreply@blogger.com") - <time datetime="2010-03-31T19:28:11.990-05:00">Apr 4, 2010</time>

Can you describe how the various trading packages in R relate to one another. Specifically, xts, quantmod, blotter, lspm and ttr are the ones I'm interested in.  
  
xts creates objects that are then passed into quantmod, I think. Is that right? How are the others related? It appears they are not competing packages, but rather complementary. Are there others I'm missing?
<hr />
#### You're correct that they're complementary,...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-03-31T22:14:16.699-05:00">Apr 4, 2010</time>

You're correct that they're complementary, but I would think of them as a toolkit rather than a workflow.  
  
_xts_ is a time series class; use it to store and manipulate data (e.g. convert it to/from other time series classes).  
  
_quantmod_ is probably best explained by the [examples](http://www.quantmod.com/examples/) page on quantmod.com.  
  
_blotter_ keeps track instruments, transactions, portfolios and accounts for trading systems.  
  
_TTR_ contains technical indicators and other functions commonly used in creating trading algorithms.  
  
_LSPM_ contains functions to determine position size according to Ralph Vince's Leverage Space Portfolio Model.  
  
You should look at:  
_quantstrat_ allows you to specify, build, and back-test quantitative financial trading and portfolio strategies.  
  
_PerformanceAnalytics_ is a library of econometric functions for performance and risk analysis and aims to aid practitioners and researchers in utilizing the latest research in analysis of non-normal return streams.  
  
_PortfolioAnalytics_ is a library of portfolio optimization and analysis routines and graphics.
<hr />
#### Thanks for quantstrat and Performance Analytics. D...
[Milk Trader](https://www.blogger.com/profile/15008769973064875700 "noreply@blogger.com") - <time datetime="2010-04-01T07:27:00.719-05:00">Apr 4, 2010</time>

Thanks for quantstrat and Performance Analytics. Do any of these packages excel at the walk-forward technique, or out-of-sample backtesting on set-aside data whose parameters are determined by an objective function applied to a preceding window?  
  
Let me explain that better. I'd like to determine a parameter set to trade a system for a pre-determined period, say six months. The first parameter set I choose is based on the most recent two years of backtest data. I run this "ideal" parameter set on the first six months of out-of-sample data and determine the results, which I set aside for later analysis. Then, I treat the six month out-of-sample data as in-sample data and choose my parameters based on a backtest of two years again. But this time, the oldest six months of original backtest data is replaced with the first walk-forward data (which was 6 months in our example). This technique is widely known and commonly used.  
  
There is a matter of how one chooses the best parameters to walk-forward. Maximum net profit is the most intuitive, but not the ideal objective function. Other objective functions can get fairly complicated so the ability to program it is important.
<hr />
#### PerformanceAnalytics has Return.portfolio and Retu...
[Brian G. Peterson](https://www.blogger.com/profile/09226525229201110236 "noreply@blogger.com") - <time datetime="2010-04-01T14:27:50.202-05:00">Apr 4, 2010</time>

PerformanceAnalytics has Return.portfolio and Return.rebalancing which can construct return series for portfolios based on a time series of weighting vectors.  
  
PortfolioAnalytics has optimize.portfolio.rebalancing which conducts 'walk-forward' rebalancing on a periodic basis. All of the portfolio objectives in PortfolioAnalytics are layered and based on arbitrary R functions, not limited to simple single-objective or fixed approaches.  
  
quantstrat does not yet have rebalancing or parameter optimization, though those functions will likely be added as parameterization is stabilized over the next couple months.
<hr />
#### It may be there is no R package for what I have in...
[Milk Trader](https://www.blogger.com/profile/15008769973064875700 "noreply@blogger.com") - <time datetime="2010-04-02T11:11:49.398-05:00">Apr 5, 2010</time>

It may be there is no R package for what I have in mind specifically, in which case maybe I can develop it.  
  
Here is the basic idea.  
  
Moving average crossover system that calculates the following results for each parameter set over 400 trading days.  
  
Permutation #: 1  
Parameter One: 10  
Parameter Two: 30  
Net Profit: 2,000  
Max Drawdown: 3,000  
Profit/Max DD: .6667  
Perfect Profit: 100,000  
Percent Perfect: .02  
Correlation PP: .3211  
  
  
And so on with data generation. But this is the start. Then, populate this array with results from each permutation.  
  
Then, one would need to select a reasonable range of permutations and choose between brute force (for reasonable amount of permutations) or genetic algorithm, particle swarm (for unreasonable number of permutations).  
  
Once this array is populated through permutation n, R would choose the one parameter set that exhibited the max or min of one of the elements of the array (eg, Maximum Net Profit). Once that parameter set is chosen, it is applied to the next 100 days of out-of-sample data and a new set of arrays would be populated. This process continues until you run out of data.  
  
The results are then compiled into a new data frame that can be parsed for statistical analysis. ie, periodAverage <- mean(Results$NetProfit)  
  
Many commercial off the shelf programs like TradersStudio, Amibroker and TradeStation (I believe) already do this, but doing this in R yields many advantages including the ability to script a set of statistical analysis, graph them and the like without being confined to a vendor-specific windowing interface. Extracting custom information from vectors is much easier than trying to generate custom views from the other programs as well.
<hr />
#### Please consider adding any development effort to <...
[Brian G. Peterson](https://www.blogger.com/profile/09226525229201110236 "noreply@blogger.com") - <time datetime="2010-04-03T06:59:49.837-05:00">Apr 6, 2010</time>

Please consider adding any development effort to _quantstrat_. This is what quantstrat is designed for, and the next major area of development is parameterization of signals and indicators, followed closely by parameter optimization.
<hr />
#### Can you explain how far along quantstrat is in the...
[Milk Trader](https://www.blogger.com/profile/15008769973064875700 "noreply@blogger.com") - <time datetime="2010-04-03T08:47:13.509-05:00">Apr 6, 2010</time>

Can you explain how far along quantstrat is in the development cycle? R Forge shows version 0.2. Does it become functional at 1.0? And where is the best place to find the package's author and how could I input some ideas on walk-forward.  
  
Thanks!
<hr />
#### _quantstrat_ is functional, but still in alph...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-04-03T10:12:44.743-05:00">Apr 6, 2010</time>

_quantstrat_ is functional, but still in alpha status (meaning it may undergo some design changes).  
  
You've been corresponding with two of _quantstrat_'s authors. ;-) The best way to make contributions is to checkout the [_quantstrat_ source](http://r-forge.r-project.org/R/?group_id=316) (part of the TradeAnalytics project) from [r-forge](http://r-forge.r-project.org) and email your patches to the package maintainer.
<hr />
#### Thanks Joshua. I also look forward to presentation...
[Milk Trader](https://www.blogger.com/profile/15008769973064875700 "noreply@blogger.com") - <time datetime="2010-04-03T20:34:07.445-05:00">Apr 0, 2010</time>

Thanks Joshua. I also look forward to presentations at R/Finance 2010 in Chicago.
<hr />
#### I suppose there isn't any further documentatio...
[G$](https://www.blogger.com/profile/01349972242888715865 "noreply@blogger.com") - <time datetime="2010-04-22T10:09:48.302-05:00">Apr 4, 2010</time>

I suppose there isn't any further documentation yet, other than the index html page?
<hr />
#### G$, TTR has complete documentation. What are you...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-04-22T10:12:14.022-05:00">Apr 4, 2010</time>

G$,  
  
TTR has complete documentation. What are you referring to?
<hr />
#### sorry, i was following the thread. I was referrin...
[G$](https://www.blogger.com/profile/01349972242888715865 "noreply@blogger.com") - <time datetime="2010-04-22T18:39:08.754-05:00">Apr 4, 2010</time>

sorry, i was following the thread. I was referring to blotter and quantstrat
<hr />
#### The documentation for blotter and quantstrat is no...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-04-22T18:50:18.731-05:00">Apr 4, 2010</time>

The documentation for blotter and quantstrat is not complete, but there is a lot more documentation than just the index page.
<hr />
#### Is there any presentations from R/Finance 2010 pub...
[steffi](https://www.blogger.com/profile/03083735023765883793 "noreply@blogger.com") - <time datetime="2010-04-28T15:39:15.520-05:00">Apr 3, 2010</time>

Is there any presentations from R/Finance 2010 published to the general public?
<hr />
#### steffi, The presenters have recently been contact...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-04-28T18:02:07.922-05:00">Apr 3, 2010</time>

steffi,  
  
The presenters have recently been contacted to ask their permission, so (most of) the presentations should be available in the next few weeks. I will post once they're online.
<hr />
#### Joshua, the R-forge TradeAnalytics page seems to b...
[Jack](https://www.blogger.com/profile/13779819272552611212 "noreply@blogger.com") - <time datetime="2010-04-28T21:58:08.256-05:00">Apr 4, 2010</time>

Joshua, the R-forge TradeAnalytics page seems to be down. Is there anywhere else we can obtain a copy of these packages? Thanks.
<hr />
#### Jack, All the servers at the Vienna University of...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-04-28T22:10:16.278-05:00">Apr 4, 2010</time>

Jack,  
  
All the servers at the Vienna University of Economics and Business were affected by an electrical system failure earlier this week.  
  
It appears r-forge is still experiencing issues. I would expect it to be resolved in a day or two. Send me an email if you would like me to send you the _source code_ (**not** Windows binaries).
<hr />
#### 
[threadline](https://www.blogger.com/profile/10506652090696681619 "noreply@blogger.com") - <time datetime="2010-08-01T15:14:40.677-05:00">Aug 0, 2010</time>

This comment has been removed by the author.
<hr />
#### I have just run the demo files (e.g. macross) in q...
[threadline](https://www.blogger.com/profile/10506652090696681619 "noreply@blogger.com") - <time datetime="2010-08-01T15:16:34.145-05:00">Aug 0, 2010</time>

I have just run the demo files (e.g. macross) in quantstrat and played a bit with it. I am trying to complete the scripts to perform trade performance analysis and was wondering if anyone knows a function in quantstrat/quantmod to extract P&L by trade.  
  
My intent is to have a trade table from which i can use to apply performance criteria by strategy and then develop an optimising routine for the strategy parameters.  
  
Since this is an important part of an algo trading module I thought it may be part of the package and I may not know where to find it.
<hr />
#### In reply to phil: the function getPortfolio will ...
[Brian G. Peterson](https://www.blogger.com/profile/09226525229201110236 "noreply@blogger.com") - <time datetime="2010-08-02T11:54:16.733-05:00">Aug 1, 2010</time>

In reply to phil:  
  
the function getPortfolio will return the portfolio object, which includes all the realized and unrealized P&L by transaction and in the portfolio based on how you mark the book.  
  
There are no summary reports yet. They just haven't been more important than creating the framework itself.  
  
If you have suggestions for what should be in a summary report, we'd love to hear it. Even better, of course, would be to provide code to the community, which we could include in the approporiate package (with attribution, of course)
<hr />
#### Many thank Brian. I got this working and will writ...
[threadline](https://www.blogger.com/profile/10506652090696681619 "noreply@blogger.com") - <time datetime="2010-08-03T23:58:40.899-05:00">Aug 3, 2010</time>

Many thank Brian. I got this working and will write the code over the coming weeks. One question though. When I run the demo(macross) and extract the results using getPosition(), this is what comes out.  
  
$AAPL$txn  
Txn.Qty Txn.Price ...  
1999-12-31 0 0.00 ...  
2001-06-26 100 23.75 ...  
  
...  
  
what is the command to extract specific info from the transaction results part of getPosition() into a proper data frame. It doesn't work when I type APPL$Txn.Qty  
  
Phil
<hr />
#### phil, Try 'getPortfolio' instead. This i...
[Brian G. Peterson](https://www.blogger.com/profile/09226525229201110236 "noreply@blogger.com") - <time datetime="2010-08-05T12:18:29.834-05:00">Aug 4, 2010</time>

phil,  
  
Try 'getPortfolio' instead. This is a list which should contain everything you should need. None of these are data.frame, because all of this data is time series data. data.frames have some useful properties for tabular data, but these are time series, and need to be indexed and subset as time series, which is why we use xts for all of it. Basically, each list element is a time series, and should be able to be manipulated as such. Hope this helps...
<hr />
#### Brian, See below for more info. I may not have be...
[threadline](https://www.blogger.com/profile/10506652090696681619 "noreply@blogger.com") - <time datetime="2010-08-06T16:29:46.868-05:00">Aug 5, 2010</time>

Brian,  
  
See below for more info. I may not have been specific enough in my query and I am still learning my way through the blotter/xts. The analysis uses JJG as the stock  
  
\>is.xts(JJG)  
\[1\] TRUE  
  
\>getTxns(s$name) # gives a subset of getPortfolio() results  
$JJG$txn  
Txn.Qty Txn.Price Txn.Value  
2000-12-31 0 0.00 0  
2009-05-31 1000 45.67 45670  
2009-05-31 1000 45.67 45670  
2009-05-31 1000 45.67 45670  
  
My intent is to extract those results in a format which I can manipulate to calculate performance measures on which I will write an optimisation routine on the strategy parameters. Where I am struggling is to find the syntax to extract those.  
  
it appears that the results are not xts  
\>is.xts(JJG$txn)  
NULL  
  
it's neither a data frame  
\>JJG$txn\[\]  
NULL  
  
i apologize if this may sound basic to some of you but I really want to learn it and spent a considerable amount of time in trial and errors. Help appreciate  
  
Phil
<hr />
#### Phil, You haven't actually extracted anything...
[Brian G. Peterson](https://www.blogger.com/profile/09226525229201110236 "noreply@blogger.com") - <time datetime="2010-08-26T07:48:33.418-05:00">Aug 4, 2010</time>

Phil,  
  
You haven't actually extracted anything using the syntax you've shown here. All you did was display the information to your screen.  
  
You'd have to assign it to a variable to manipulate it.  
  
The data for blotter is stored in a 'list', in 'slots' (any introductory R text should cover this)  
  
getTxns() extracts these from the environment they're stored in, and makes them available to you to assign to a variable.  
  
So, let's use a reproducible example:  
  
require('blotter')  
  
demo('amzn\_test')  
  
getTxns(Portfolio='amzn\_port',Symbol='amzn')  
  
\# the above command will print stuff to your screen  
  
#let's assign the returned data to a variable instead  
amzn\_txns<-getTxns(Portfolio='amzn\_port',Symbol='amzn')  
  
\# now we'll check it  
class(amzn\_txns)  
  
\# gives:  
\# \[1\] "transactions" "xts" "zoo"  
  
#and the test phil tried before  
is.xts(amzn\_txns)  
  
\# gives:  
#\[1\] TRUE
<hr />
