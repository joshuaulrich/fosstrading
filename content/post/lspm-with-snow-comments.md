---
title: 'LSPM with snow'
date: 2010-01-10T17:01:00.003-06:00
draft: false
aliases: [ "/2010/01/lspm-with-snow.html" ]
tags : [Examples, LSPM]
---

#### Hi Joshua! Could you tell me how to calculate prob...
[senyai](https://www.blogger.com/profile/05832095029637788492 "noreply@blogger.com") - <time datetime="2010-04-09T07:39:34.366-05:00">Apr 5, 2010</time>

Hi Joshua! Could you tell me how to calculate probability of drawdown using martingale exponents? I do not want to optimize anything, just calculate dd like Vince did at 173 page. My code:  
\---------------------------------  
port <- lsp(trades,probs, f=c(0.085,0.015,0.129), z = c(-0.76, -0.992, 0.0))  
probDrawdown(port,0.8,12,13)  
\---------------------------------  
This code shows me value 0.0001982222, but Vince says his dd is 0.012. And when I use my algorithm I get 0.0017759413.  
  
Thx.
<hr />
#### nevermind, i got wrong dd parameter.
[senyai](https://www.blogger.com/profile/05832095029637788492 "noreply@blogger.com") - <time datetime="2010-04-09T07:48:48.813-05:00">Apr 5, 2010</time>

nevermind, i got wrong dd parameter.
<hr />
#### I'm having trouble following the 0.1 argument ...
[G$](https://www.blogger.com/profile/01349972242888715865 "noreply@blogger.com") - <time datetime="2010-05-18T10:29:10.823-05:00">May 2, 2010</time>

I'm having trouble following the 0.1 argument to the optimalf function. I looked into the help files, and see that probDrawdown is the constraint function here, and the DD=0.2 is the ruin level being passed to probDrawdown, but what is the 0.1 between the probDrawdown and the DD arguments to this optimalf?  
  
Thanks.  
  
optimalf(port,probDrawdown,0.1,DD=0.2,horizon=5,snow=clust,control=list(NP=30,itermax=100)
<hr />
#### Note the optimalf function only has 4 arguments: 1...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-05-18T10:36:18.341-05:00">May 2, 2010</time>

Note the optimalf function only has 4 arguments:  
1) the lsp object ("port"),  
2) the constraint function ("probDrawdown"),  
3) the constraint value (0.1), and  
4) '...'  
  
In this post, "port", "probDrawdown", and "0.1" are 1, 2, and 3, respectively. All the other arguments fall into '...', which get passed to the probDrawdown function (note that all arguments in '...' must be name/value pairs).  
  
For more information on '...', see  
http://cran.r-project.org/doc/manuals/R-intro.html#Writing-your-own-functions  
  
So, after all that background information, 0.1 is the maximum constraint value (i.e. probDrawdown cannot exceed this value).
<hr />
#### Got it thanks. What I've quickly realized is ...
[G$](https://www.blogger.com/profile/01349972242888715865 "noreply@blogger.com") - <time datetime="2010-05-18T12:56:44.031-05:00">May 2, 2010</time>

Got it thanks. What I've quickly realized is my event populations are much too large. I have 10 years of daily historical P&L for strategies and have weighted all days with equal probability. I wonder if anyone has used a Self Organizing Map for their history to chop events into a number of distinct buckets and give back the mean P&L in those areas for each strategy/trade?
<hr />
#### It's no self-organizing map, but my
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-05-18T22:34:53.566-05:00">May 3, 2010</time>

It's no self-organizing map, but my [most recent post](http://blog.fosstrading.com/2010/05/lspm-joint-probability-tables.html) provides a function that creates a joint probability table from a matrix of input data.
<hr />
#### Over the past month I have had our network migrate...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-09-02T03:04:20.957-05:00">Sep 5, 2011</time>

Over the past month I have had our network migrated to Open Directory hosted by OS X Lion servers.  
  
As we also now have a number of OSX/Windows devices on the network (and inspired by a previous thread on the possibility of running R in the cloud) I have been looking at the possibility of leveraging current available processing assets to run LSPM.  
  
Am currently looking at:  
  
http://cran.r-project.org/web/packages/runjags/index.html  
\[A set of utility functions ….. arbitrary R code submission to Xgrid clusters (requires Mac OS X). ….. Utilities to run user-supplied R functions on Xgrid (using xapply as a replacement for lapply) are also included, and do not require JAGS.\]  
  
there is also:  
  
http://cran.r-project.org/web/packages/xgrid/index.html  
\[Functions to distribute and collate results from simulation studies and other computationally expensive tasks to Apple Xgrid clusters from within R\]  
  
Grant
<hr />
#### This is just a heads up to let you know that with ...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-11-02T02:26:21.826-05:00">Nov 3, 2011</time>

This is just a heads up to let you know that with the latest release of R released this week (2.14.0) we now have the "parallel" libaray which is distributed "native" with R itself.  
  
It is based upon the snow and multicore packages.  
  
Not sure yet what benefits it brings to the table but to use it simply substitute  
  
clust <- makePSOCKcluster(16)  
for  
clust <- makeSOCKcluster(16)
<hr />
