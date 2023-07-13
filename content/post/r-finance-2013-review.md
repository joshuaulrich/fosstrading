---
title: 'R/Finance 2013 Review'
date: 2013-05-28T08:00:00.000-05:00
draft: false
aliases: [ "/2013/05/r-finance-2013-review.html" ]
categories: [ Articles, Events ]
tags : [Reviews, Events, R]
---

It's been one week since the [5th Annual R/Finance conference](http://www.rinfinance.com/), and I finally feel sufficiently recovered enough to share my thoughts. The conference is a two-day whirlwind of applied quantitative finance, fantastic networking, and general geekery.  
  
The comments below are based on my personal experience.  If I don't comment on a seminar or presentation, it doesn't mean I didn't like it or it wasn't good; it may have been over my head or I may have been distracted with my duties as a committee member.  All the currently available conference slides are available [on the website](http://www.rinfinance.com/agenda/).  

Friday morning seminar:  
I went to (and live-tweeted) [Jeff Ryan's seminar](http://www.rinfinance.com/agenda/2013/workshop/JeffRyan.pdf) because I wanted to learn more about how he uses [mmap](http://cran.r-project.org/web/packages/mmap/)+[indexing](http://r-forge.r-project.org/projects/indexing) with options data.  There I realized that [POSIXlt](http://www.inside-r.org/r-doc/base/DateTimeClasses) components use a zero-based index because they mirror the underlying [tm struct](http://www.cplusplus.com/reference/ctime/tm/), and that mmap+indexing files can be shared across cores and you can read them from other languages (e.g. [Python](http://www.python.org/)).  
  
Friday talks:  
The first presentation was by keynote [Ryan Sheftel](http://www.rinfinance.com/agenda/2013/talk/RyanSheftel.pdf), who talked about how he uses R on his bond trading desk.  [David Ardia](http://www.rinfinance.com/agenda/2013/talk/DavidArdia.pdf) showed how expected returns can be estimated via the covariance matrix.  [Ronald Hochreiter](http://www.rinfinance.com/agenda/2013/talk/RonaldHochreiter.pdf) gave an overview of modeling optimization via his [modopt](http://www.modopt.com/) package.  Tammer Kamel gave a live demo of the [Quandl package](http://www.quandl.com/help/packages/r) and said, "Quandl hopes to do to Bloomberg what Wikipedia did to Britannica."  
  
I had the pleasure of introducing both [Doug Martin](http://www.rinfinance.com/agenda/2013/talk/DougMartin.pdf), who talked about robust covariance estimation, and [Giles Heywood](http://www.rinfinance.com/agenda/2013/talk/GilesHeywood.pdf), who discussed several ways of estimating and forecasting covariance, and proposed an "open source equity risk and backtest system" as a means of matching talent with capital.  
  
[Ruey Tsay](http://www.rinfinance.com/agenda/2013/talk/RueyTsay.pdf) was the next keynote, and spoke about using principal volatility components to simplify multivariate volatility modeling.  [Alexios Ghalanos](http://www.rinfinance.com/agenda/2013/talk/AlexiosGhalanos.pdf) spoke about modeling multivariate time-varying skewness and kurtosis.  Unfortunately, I missed both [Kris Boudt's](http://www.rinfinance.com/agenda/2013/talk/KrisBoudt.pdf) and [David Matteson's](http://www.rinfinance.com/agenda/2013/talk/DavidMatteson.pdf) presentations, but I did get to see Winston Chang's live demo of [Shiny](http://www.rstudio.com/shiny/).  
  
Friday food/networking:  
The two-hour conference reception at UIC was a great time to have a drink, talk with speakers, and say hello to people I had never met in person.  Next was the (optional) dinner at [The Terrace at Trump](http://www.trumphotelcollection.com/chicago/rooftop-restaurants-chicago.php).  Unfortunately, it was cold and windy, so we only spent 15-20 minutes on the terrace before moving inside.  The food was fantastic, but the conversations were even better.  
  
Saturday talks:  

I missed the first block of lightning talks.  [Samantha Azzarello](http://www.rinfinance.com/agenda/2013/talk/Azzarello+Putnam.pdf) discussed her work with Blu Putnam, which used a dynamic linear model to evaluate the Fed's performance vis-a-vis the Taylor Rule.  [Jiahan Li](http://www.rinfinance.com/agenda/2013/talk/JiahanLi.pdf) used constrained least squares on 4 economic fundamentals to forecast foreign exchange rates.  [Thomas Harte](http://www.rinfinance.com/agenda/2013/talk/ThomasHarte.pdf) talked about regulatory requirements of foreign exchange pricing (and wins the award for most slides, 270); basically documentation is important, [Sweave](http://www.inside-r.org/r-doc/utils/Sweave) to the rescue!

  

[Sanjiv Das](http://www.rinfinance.com/agenda/2013/talk/SanjivDas.pptx) gave a keynote on 4 applications: 1) network analysis on SEC and FDIC filings to determine banks that pose systematic risk, 2) determining which home mortgage modification is optimal, 3) portfolio optimization with mental accounting, 4) venture capital communities.

  

I had the pleasure of introducing the following speakers: [Dirk Eddelbuettel](http://www.rinfinance.com/agenda/2013/talk/DirkEddelbuettel.pdf) showed how it's easy to write fast linear algebra code with [RcppArmadillo](http://cran.r-project.org/web/packages/RcppArmadillo/index.html).  [Klaus Spanderen](http://www.rinfinance.com/agenda/2013/talk/KlausSpanderen.pdf) showed how to use [QuantLib](http://quantlib.org/index.shtml) from R, and even how to to call C++ from R from C++.  [Bryan Lewis](http://www.rinfinance.com/agenda/2013/talk/BryanLewis.pdf) talked about [SciDB](http://www.scidb.org/) and the [scidb](http://cran.r-project.org/web/packages/scidb/) package (SciDB contains fast linear algebra routines that operate **on** the database!).  [Matthew Dowle](http://www.rinfinance.com/agenda/2013/talk/MatthewDowle.pdf) gave an introduction to [data.table](http://cran.r-project.org/web/packages/data.table/index.html) (in addition to a seminar).

  

Attilio Meucci gave his keynote on visualizing advanced risk management and portfolio optimization.  Immediately following, [Brian Peterson](http://www.rinfinance.com/agenda/2013/talk/BrianPeterson.pdf) gave a lightning on implementing Meucci's work in R (Attilio works in Matlab), which was part of a Google Summer of Code project last year.

  

[Thomas Hanson](http://www.rinfinance.com/agenda/2013/talk/Chance+Hanson+etal.pdf) presented his work with Don Chance (and others) on computational issues in estimating the volatility smile.  [Jeffrey Ryan](http://www.rinfinance.com/agenda/2013/talk/JeffRyan.pdf) showed how to manipulate options data in R with the [greeks](https://code.google.com/p/rgreeks/) package.

  

The conference wrapped up by giving away three books, generously donated by Springer, to three random people who submitted feedback surveys.  I performed the random drawing live on stage, using my patent-pending TUMC method (I tossed the papers up in the air).

  

The committee also presented the awards for best papers.  The winners were: 

*   _Regime switches in volatility and correlation of ﬁnancial institutions_, Boudt et. al.
*   _A Bayesian interpretation of the Federal Reserve's dual mandate and the Taylor Rule_, Putnam & Azzarello
*   _Nonparametric Estimation of Stationarity and Change Points in Finance_, Matteson et. al.
*   _Estimating High Dimensional Covariance Matrix Using a Factor Model_, Sun (best student paper)

Saturday food/networking:

The whirlwind came to a close at [Jaks Tap](http://jakstap.com/).  I was finally able to ask speed-obsessed Matthew Dowle about potential implementations of a multi-type xts object (a Google Summer of Code project this year).    I also spoke to a few people about how to add options strategy backtesting to quantstrat.  
  
Last, but not least: none of this would be possible without the support of fantastic sponsors: [International Center for Futures and Derivatives at UIC](http://business.uic.edu/academic-centers-and-research/cba-research-centers/international-center-for-futures-and-derivatives), [Revolution Analytics](http://www.revolutionanalytics.com/), [MS-Computational Finance at University of Washington](http://depts.washington.edu/compfin/), [Google](http://www.google.com/), [lemnica](http://www.lemnica.com/), [OpenGamma](http://www.opengamma.com/), [OneMarketData](http://www.onetick.com/), and [RStudio](http://www.rstudio.org/).
