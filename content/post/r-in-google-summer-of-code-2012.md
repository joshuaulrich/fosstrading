---
title: 'R in Google Summer of Code 2012'
date: 2012-03-23T13:53:00.000-05:00
draft: false
aliases: [ "/2012/03/r-in-google-summer-of-code-2012.html" ]
categories: [ Articles, Events ]
tags : [Events, Code, R]
---

This post is a slightly revised (and "blogified") version of the message [Brian Peterson](http://braverock.com/brian/resume.html) has sent to various R mailing lists.  
  
Once again, [R](http://www.r-project.org/) has been accepted as a mentoring organization for the [Google Summer of Code (2012)](http://google-melange.appspot.com/gsoc/homepage/google/gsoc2012).  We invite students interested in this program to learn more about it.  A good starting point is the [R GSoC wiki](http://rwiki.sciviews.org/doku.php?id=developers:projects:gsoc2012).  
  
Students participating in the program receive US$5,000 for successful completion of a GSoC project, a great resume item, and an opportunity to work with R package authors.  
  
There are four finance-related projects currently on the project ideas list:  

*   [Performance Attribution](http://rwiki.sciviews.org/doku.php?id=developers:projects:gsoc2012:performanceanalytics)  
    Add portfolio performance and attribution functionality from Bacon \[1\] to [PerformanceAnalytics](http://cran.r-project.org/web/packages/PerformanceAnalytics/) package.
*   [Advanced Risk and Portfolio Management](http://rwiki.sciviews.org/doku.php?id=developers:projects:gsoc2012:meucci)  
    Port [MATLAB](http://www.mathworks.com/products/matlab/) code published by Attilio Meucci \[2,3,4\] for risk and portfolio management to R.  (FYI: there is already a highly qualified student associated with this project idea).
*   [Extend RTAQ](http://rwiki.sciviews.org/doku.php?id=developers:projects:gsoc2012:rtaq)  
    Extend the [RTAQ](http://cran.r-project.org/web/packages/RTAQ/) package with additional data interoperability and volatility measures.  (FYI: there is already a highly qualified student associated with this project idea).
*   [PortfolioAnalytics Optimizer Back-ends](http://rwiki.sciviews.org/doku.php?id=developers:projects:gsoc2012:portfolioanalytics)  
    Add additional closed form and global optimizer backends to [PortfolioAnalytics](https://r-forge.r-project.org/R/?group_id=579).

and one that is not specifically finance related, but extends [xts](http://cran.r-project.org/web/packages/xts/), which is the most prevalent time series class for finance in R:  

*   [Extend xts](http://rwiki.sciviews.org/doku.php?id=developers:projects:gsoc2012:xts)  
    Improve data and model visualization.  Extend xts objects to contain mixed types (like data.frames).  Add interoperability to existing analytical functions (e.g. [ARIMA](http://en.wikipedia.org/wiki/Autoregressive_integrated_moving_average), [Holt Winters](http://en.wikipedia.org/wiki/Holt-Winters#Double_exponential_smoothing), [VAR](http://en.wikipedia.org/wiki/Vector_autoregression)).  (FYI: there is already a highly qualified student associated with this project idea).

The list of finance project ideas above is also by no means exhaustive of the proposed R projects.  There are additional non-finance R project ideas listed on the [R GSoC wiki](http://rwiki.sciviews.org/doku.php?id=developers:projects:gsoc2012).  Interested students or mentors are encouraged to discuss other project ideas on the [gsoc-r Google group](http://groups.google.com/group/gsoc-r?pli=1).  
  
Those interested in either student or mentor participation should join our Google group, as this is the main means of communication.  When you apply for group membership, please introduce yourself with one sentence, so we know you're not a spammer.  
  
Interested students should start working on applications now.  The student application process opens on 26 March, and successful students in prior years have often posted draft applications to melange for comment as soon after the opening of the application process as possible.  
  
Note that GSoC is about **coding**.  It is not intended to fund research; but many activities with R require code to advance our work, so the program can be very helpful to improving R.  
  
For information, the admins this year are Toby Dylan Hocking and John Nash, with Brian Peterson and Virgilio Gomez as backups.  
  
References:  
\[1\] Carl Bacon “Practical Portfolio Performance Measurement and Attribution”, (London, John Wiley & Sons. September 2004) ISBN 978-0470856796. 2nd Edition May 2008 ISBN 978-0470059289  
  
\[2\] Meucci, Attilio, Managing Diversification (April 1, 2010). Risk, pp. 74-79, May 2009; Bloomberg Education & Quantitative Research and Education Paper. Available at SSRN: [http://ssrn.com/abstract=1358533](http://ssrn.com/abstract=1358533 "http://ssrn.com/abstract=1358533")  
  
\[3\] Meucci, Attilio, Exercises in Advanced Risk and Portfolio Management - With Step-by-Step Solutions and Fully Documented Code (August 15, 2010). Available at SSRN: [http://ssrn.com/abstract=1447443](http://ssrn.com/abstract=1447443 "http://ssrn.com/abstract=1447443")  
  
\[4\] Meucci, Attilio, Risk and Asset Allocation. Springer Finance (2005) ISBN: 3540222138
