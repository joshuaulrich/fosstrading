---
title: 'Why Use R?'
date: 2010-12-14T22:35:00.000-06:00
draft: false
aliases: [ "/2010/12/why-use-r.html" ]
categories: [ Articles ]
tags : [R]
---

I use R very frequently and take for granted much that it has to offer.  I forget how R is different from similar tools, so I have trouble communicating the benefits of using R.  The goal of this post is to highlight R's main strengths, but first... my story.  
  
How I got started with R  
  
I was introduced to R while I was working as a [Research Analyst](http://research.stlouisfed.org/) at the [Federal Reserve Bank of St. Louis](http://stlouisfed.org/).  I wanted to do statistical analysis at home but the tools I used at work ([GAUSS](http://www.aptech.com/) and [SAS](http://www.sas.com/)) were expensive, so I started doing my analysis in Excel.  
  
But as my analysis became more complex, the Excel files became large and cumbersome.  The files also did not document my thought process, which made it difficult to revisit analysis I had started several months earlier.  I asked my fellow analysts for advice and one introduced me to R and [Modern Applied Statistics with S](http://www.amazon.com/gp/product/1441930086?ie=UTF8&tag=fosstrading-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=1441930086).  Thus began my auto-didactic journey with R.  
  
Why should you use R?  

  
R is the leading tool for statistics, data analysis, and machine learning.  It is more than a statistical package; it’s a programming language, so you can create your own objects, functions, and packages.

Speaking of packages, there are over 2,000 cutting-edge, user-contributed packages available on [CRAN](http://cran.r-project.org/) (not to mention [Bioconductor](http://www.bioconductor.org/) and [Omegahat](http://www.omegahat.net/)).  To get an idea of what packages are out there, just take a look at these [Task Views](http://cran.r-project.org/web/views/).  Many packages are submitted by prominent members of their respective fields.

Like all programs, R programs explicitly document the steps of your analysis and make it easy to reproduce and/or update analysis, which means you can quickly try many ideas and/or correct issues.

You can easily use it anywhere.  It's [platform-independent](http://en.wikipedia.org/wiki/Platform-independent), so you can use it on any operating system.  And it's free, so you can use it at any employer without having to persuade your boss to purchase a license.

Not only is R free, but it's also [open-source](http://en.wikipedia.org/wiki/Open_source).  That means anyone can examine the source code to see exactly what it’s doing.  This also means that you, or anyone, can fix bugs and/or add features, rather than waiting for the vendor to find/fix the bug and/or add the feature--at their discretion--in a future release.

R allows you to integrate with other languages (C/C++, [Java](http://java.sun.com/), [Python](http://www.python.org/)) and enables you to interact with many data sources: [ODBC](http://en.wikipedia.org/wiki/Odbc)\-compliant databases (Excel, Access) and other statistical packages ([SAS](http://www.sas.com/), [Stata](http://www.stata.com/), [SPSS](http://www.spss.com/), [Minitab](http://www.minitab.com/)).

Explicit parallelism is straightforward in R (see the [High Performance Computing Task View](http://cran.r-project.org/web/views/HighPerformanceComputing.html)): several packages allow you to take advantage of multiple cores, either on a single machine or across a network.  You can also build R with [custom BLAS](http://cran.r-project.org/doc/manuals/R-admin.html#Linear-algebra).

R has a large, active, and growing community of users.  The [mailing lists](http://www.r-project.org/mail.html) provide access to many users and package authors who are experts in their respective fields.  Additionally, there are several R conferences every year.  The most prominent and general is [useR](http://user2010.org/).  Finance-related conferences include [Rmetrics Workshop on Computational Finance and Financial Engineering](https://www.rmetrics.org/meielisalp2011) in Meielisalp, Switzerland and [R/Finance: Applied Finance with R](http://www.rinfinance.com/) in Chicago, USA.

I hope that's a helpful overview of some benefits of using R.  I'm sure I have forgotten some things, so please add them in the comments.