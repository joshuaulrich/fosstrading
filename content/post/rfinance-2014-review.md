---
title: 'R/Finance 2014 Review'
date: 2014-06-30T07:40:00.001-05:00
draft: false
aliases: [ "/2014/06/rfinance-2014-review.html" ]
tags : [Reviews, Events, R]
---

It's been more than a month since [R/Finance 2014](http://www.rinfinance.com/), and my job has finally slowed down enough to allow me to write down my thoughts (though I'm writing this over two days during my train to and from Chicago).  
  
The comments below are based on my personal experience. If I don't comment on a seminar or presentation, it doesn't mean I didn't like it or it wasn't good; it may have been over my head or I may have been distracted with my duties as a committee member. All the currently available conference slides are available [on the website](http://www.rinfinance.com/agenda/).  
  
Friday morning seminar:  
I went to [Dirk Eddelbuettel's](http://www.rinfinance.com/agenda/2014/workshop/DirkEddelbuettel.pdf) seminar because I may be writing a R package to query [Deltix's](http://www.deltixlab.com/) [](https://www.blogger.com/null) [TimeBase](http://www.deltixlab.com/solutions/timebase.html) database. Deltix provides a C++ API, so this is a perfect opportunity to use Rcpp.  
  
Friday talks:  
The first presentation was given by keynote [Luke Tierney](http://www.rinfinance.com/agenda/2014/talk/LukeTierney.pdf), who discussed recent and upcoming performance improvements to R, and introduced some new profiling tools in his [proftools](https://github.com/ltierney/Rpkg-proftools) package (and a new [proftools-GUI](https://github.com/ltierney/Rpkg-proftools-GUI) package).  
  
[Yang Lu](http://www.rinfinance.com/agenda/2014/talk/YangLu.pdf) explored the low-risk anomaly on high/low volatility portfolios with similar industry, size, and volume. [Avery Moon](http://www.rinfinance.com/agenda/2014/talk/AveryMoon.pdf) discussed how they use R at [Wealthfront](http://www.wealthfront.com/) to run cashflow simulations for their tax-loss harvesting strategy. [Steven Pav](http://www.rinfinance.com/agenda/2014/talk/StevenPav.pdf) used math and memes to discuss portfolio inference. [Tobias Setz](http://www.rinfinance.com/agenda/2014/talk/TobiasSetz.pdf) used the Bayesian Change Point method to analyze time series stability.  
  
[Paul Teetor](http://www.rinfinance.com/agenda/2014/talk/PaulTeetor.pdf) and [Matthew Clegg](http://www.rinfinance.com/agenda/2014/talk/MatthewClegg.pdf) discussed different aspects of pairs trading. [Kent Hoxsey](http://www.rinfinance.com/agenda/2014/talk/KentHoxsey.pdf) demonstrated a simple way to explore trading signal expectation. [Matthew Barry](http://www.rinfinance.com/agenda/2014/talk/MatthewBarry.pdf) introduced the [pbo](https://github.com/mrbcuda/pbo) package, which implements some of the ideas in the paper, [The Probability of Backtest Overfitting](http://papers.ssrn.com/sol3/papers.cfm?abstract_id=2326253).  
  
[Alexios Ghalanos](http://www.rinfinance.com/agenda/2014/talk/AlexiosGhalanos.pdf) was the day's second keynote, and he discussed smooth transition autoregressive models and his new package, [twinkle](https://bitbucket.org/alexiosg/twinkle). Alexios [wrote a post](http://unstarched.net/2014/05/27/twinkletwinkle-little-star/) discussing his presentation, which you should definitely read.  
  
Friday food/networking:  
During the two-hour conference reception at UIC, I had some drinks and hors d'ouvres, talked with speakers, and meet people I encouraged to attend and/or present. Next was the (optional) dinner at [The Terrace at Trump](http://www.trumphotelcollection.com/chicago/rooftop-restaurants-chicago.php). It was cold and windy again this year, so we were inside the entire night. Same as last year, the food was fantastic, but the conversations were even better.  
  
Saturday talks:  
The first presentation was a lightning talk by [Chirag Anand](http://www.rinfinance.com/agenda/2014/talk/ChiragAnand.pdf), where he introduced the [eventstudies](http://cran.r-project.org/web/packages/eventstudies/) package, which is very well done. [Casey King](http://www.rinfinance.com/agenda/2014/talk/CaseyKing.pptx) gave an incredibly informative and entertaining presentation on anti-money laundering and suspicious activity reporting in penny stocks using message board posts. [Bryan Lewis](http://www.rinfinance.com/agenda/2014/talk/BryanLewis.pdf) introduced his [IRL](https://github.com/bwlewis/IRL) package and ran a 16 million node network analysis in < 2 minutes on his Chromebook, during his talk. [Stephen Rush](http://www.rinfinance.com/agenda/2014/talk/StephenRush.pdf) discussed his work on [VPIN](http://en.wikipedia.org/wiki/VPIN) (volume synchronized probability of informed trading), while competing with Steven Pav for the "presentation with the most memes".  
  
[Bob McDonald](http://www.rinfinance.com/agenda/2014/talk/BobMcDonald.pdf) gave the third keynote presentation, where he discussed using R to teach derivatives in MBA classes. He also explained his decision to adopt R in terms of valuing an option. [Eric Zivot](http://www.rinfinance.com/agenda/2014/talk/EricZivot.pdf) discussed his upcoming book, "Modeling Financial Time Series with S-Plus R". [Rohini Grover](http://www.rinfinance.com/agenda/2014/talk/RohiniGrover.pdf) measured the imprecision of implied volatility estimates in volatility indexes using the [ifrogs](https://r-forge.r-project.org/projects/ifrogs/) package.  
  
[Bill Cleveland](http://www.rinfinance.com/agenda/2014/talk/BillCleveland.pdf) gave the final keynote and talked about the "divide-and-recombine" method for large, complex data, using R and Hadoop. [Gregor Kastner](http://www.rinfinance.com/agenda/2014/talk/GregorKastner.pdf) introduced his [stochvol](http://cran.r-project.org/web/packages/stochvol/) package, and [Matthew Dixon](http://www.rinfinance.com/agenda/2014/talk/MatthewDixon.pdf) showed how to calibrate stochastic volatility models using his "alpha" [gpusvcalibration](https://github.com/mfrdixon/gpusvcalibration) package. [Dirk Eddelbuettel](http://www.rinfinance.com/agenda/2014/talk/DirkEddelbuettel.pdf) closed the conference with a lightning talk on his recently-released [RcppRedis](http://cran.r-project.org/web/packages/RcppRedis/) package.  
  
The committee also presented the awards for best papers. The winners were:  

*   _Portfolio inference with this one weird trick_, Steven E. Pav
*   _Dealing with Stochastic Volatility in Time Series Using the R Package stochvol_, Gregor Kastner
*   _Re-Evaluation of the Low-Risk Anomaly in Finance via Matching_, Yang Lu, Daniel Wu, Kwok Yu
*   _All words are not equal: Sentiment dynamics and information content within CEO letters_, Kris Boudt, James Thewissen

Saturday food/networking:  
As always, the conference ended with one more trip to [Jaks Tap](http://jakstap.com/). I spent some time giving college students some advice about starting their careers, and discussed the presentation I gave earlier in the week at the [Chicago R User Group](http://www.meetup.com/ChicagoRUG/) on [Profiling for Speed](http://files.meetup.com/1625815/ProfilingForSpeed_Ulrich_05-14.pdf).  
  
Last, but not least: none of this would be possible without the support of fantastic sponsors:  
[International Center for Futures and Derivatives at UIC](http://business.uic.edu/academic-centers-and-research/cba-research-centers/international-center-for-futures-and-derivatives), [Revolution Analytics](http://www.revolutionanalytics.com/), [MS-Computational Finance at University of Washington](http://depts.washington.edu/compfin/), [OneMarketData](http://www.onetick.com/), [RStudio](http://www.rstudio.org/), [TIBCO](http://spotfire.tibco.com/), [SYMMS](http://www.symmys.com/arpm-bootcamp), and [paradigm4](http://www.paradigm4.com/).