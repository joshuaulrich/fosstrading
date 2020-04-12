---
title: 'DEoptim in Parallel'
date: 2012-03-04T20:33:00.000-06:00
draft: false
aliases: [ "/2012/03/deoptim-in-parallel.html" ]
tags : [DEoptim, Releases, R]
---

#### This is great work by Josh. If anyone would like ...
[Unknown](https://www.blogger.com/profile/15256155200899864782 "noreply@blogger.com") - <time datetime="2012-03-06T16:18:04.010-06:00">Mar 2, 2012</time>

This is great work by Josh. If anyone would like to test this out before we send it to CRAN, see example code in the 'sandbox' directory in the package source, also provided by Josh.  
  
If you want to just see it working (though this won't show any speed improvements), here is some minimal code. You will need the following packages installed: doSNOW, foreach, DEoptim (the version from R-forge, not CRAN).  
  
  
  
require(DEoptim)  
  
'Rosenbrock' <- function(x){  
x1 <- x\[1\]  
x2 <- x\[2\]  
100 \* (x2 - x1 \* x1)^2 + (1 - x1)^2  
}  
  
set.seed(1234)  
  
t1 <- system.time(out1 <- DEoptim(Rosenbrock, rep(-10,2), rep(10,2)))  
out1$optim$iter  
out1$optim$bestval  
  
require(doSNOW)  
  
cl <- makeSOCKcluster(2)  
  
\## do something like the lines below if necessary:  
##clusterEvalQ(cl, library(PerformanceAnalytics)) # load any necessary libraries  
##clusterExport(cl, list("mu", "sigma", "m3", "m4")) # copy any necessary objects  
  
\## you can monitor your processes (using, e.g., the 'top'  
\## command on a unix shell, and see multiple R  
\## sessions created  
  
registerDoSNOW(cl) # register foreach backend  
set.seed(1234)  
t2 <- system.time(out2 <- DEoptim(Rosenbrock, rep(-10,2), rep(10,2)))  
stopCluster(cl) # stop cluster  
out2$optim$iter  
out2$optim$bestval  
  
\## faster in serial  
t1  
t2
<hr />
#### Hi there, Very nice job indeed. I tried the packa...
[Unknown](https://www.blogger.com/profile/12179443876042101349 "noreply@blogger.com") - <time datetime="2012-03-16T04:29:58.961-05:00">Mar 5, 2012</time>

Hi there,  
  
Very nice job indeed. I tried the package on a very basic problem (solving the MV optimal portfolio problem with DEoptim with a bunch of assets, which is inefficient), but I did not observe time improvement for the calculation. Might well be some inefficiency in my own code.  
  
Olivier.
<hr />
#### Here's a gist that modifies the example code i...
[Mike Lawrence](https://www.blogger.com/profile/03749108150512055844 "noreply@blogger.com") - <time datetime="2012-03-16T08:16:06.378-05:00">Mar 5, 2012</time>

Here's a gist that modifies the example code in the sandbox dir so that it uses doMC for the unix folks:  
  
https://gist.github.com/2050019
<hr />
#### I was applying parallel DEoptim on my data, but it...
[Rick](https://www.blogger.com/profile/11791667587730675233 "noreply@blogger.com") - <time datetime="2012-03-20T01:10:05.281-05:00">Mar 2, 2012</time>

I was applying parallel DEoptim on my data, but it is even slower than seqential.. which makes me quite confused.
<hr />
#### Rick, You've probably encountered what I ment...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2012-03-20T05:38:30.528-05:00">Mar 2, 2012</time>

Rick,  
  
You've probably encountered what I mentioned in the first bullet point, "Data communication between nodes can overwhelm gains from processing on multiple CPUs".  
  
Running in parallel will not be beneficial for _every_ problem.
<hr />
#### Thanks Josh! -Stu
[Chicago](https://www.blogger.com/profile/02587750062987304071 "noreply@blogger.com") - <time datetime="2012-05-17T16:02:01.250-05:00">May 4, 2012</time>

Thanks Josh! -Stu
<hr />
