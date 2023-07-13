---
title: 'Thoughts on LSPM from R/Finance 2010'
date: 2010-04-18T22:24:00.000-05:00
draft: false
aliases: [ "/2010/04/thoughts-on-lspm-from-rfinance-2010.html" ]
categories: [ Articles ]
tags : [LSPM, Events]
---

I just got back from [R/Finance](http://www.rinfinance.com/) [2010](http://www.rinfinance.com/) in Chicago. If you couldn't make it this year, I strongly encourage you to attend next year. I will post a more comprehensive review of the event in the next couple days, but I wanted to share some of my notes specific to [LSPM](http://lspm.r-forge.r-project.org/).  

*   How sensitive are optimal-f values to the method used to construct the joint probability table?
*   Is there an optimizer better suited for this problem (e.g. [CMA-ES](http://en.wikipedia.org/wiki/CMA-ES), or [adaptive differential evolution](http://www.amazon.com/gp/product/3642015263?ie=UTF8&tag=fotr09-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=3642015263))?
*   How accurate are the estimates of the probability of drawdown, ruin, profit, etc.?
*   What could be learned from [ruin theory](http://en.wikipedia.org/wiki/Ruin_theory) (see the [actuar](http://cran.r-project.org/web/packages/actuar/index.html) package)?

These notes are mostly from many great conversations I had with other attendees, rather than thoughts I had while listening to the presentations. That is not a criticism of the presentations, but an illustration of the quality of the other conference-goers.