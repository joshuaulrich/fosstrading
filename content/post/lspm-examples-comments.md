---
title: 'LSPM Examples'
date: 2010-01-02T15:35:00.001-06:00
draft: false
aliases: [ "/2010/01/lspm-examples.html" ]
tags : [Examples, LSPM]
---

#### Hi Josh I am trying to replicate the results on p...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-11-15T14:19:05.487-06:00">Nov 2, 2011</time>

Hi Josh  
  
I am trying to replicate the results on page 87 (as mentioned in your post above) of the LSPM book. I do the following:  
\> data(port)  
\> DEctrl <- list(NP=30, itermax=100)  
\> res <- optimalf(port, control=DEctrl)  
  
The result is :  
  
Iteration: 100 bestvalit: -1.293917 bestmemit: 1.000000 0.000000 0.857813  
  
Page 87 reads:  
MktSysA 0.307  
MktSysB 0  
MktSysC 0.693
<hr />
#### Hi Chris, I mention that in the post; in the last...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-11-15T18:23:20.541-06:00">Nov 3, 2011</time>

Hi Chris,  
  
I mention that in the post; in the last paragraph of text before the code. In short, the optimization algorithms are different and the algorithm in my post is able to find a set of _f_ values that produce a higher GHPR.
<hr />
#### Josh, I am looking to accomplish two things with ...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-12-02T01:15:31.393-06:00">Dec 5, 2011</time>

Josh,  
  
I am looking to accomplish two things with your R implementation of LSPM:  
  
1\. The ability to pickup the f values from a previous search and then continue the search with those values.  
  
2\. The ability to stop a search that is in process yet retain the current f values for use.  
  
  
I have managed to accomplish the former with some rather inefficient code (coding is not my strong point) yet am at a loss as to how one could accomplish the latter:  
  
  
I accomplish the former by writing the f values to file at the end of a run:  
  
write.csv(results$f, file="OUTPUT \[f\].csv")  
  
and then pick them up again prior to the next run by repopulating the initialpop with the following (here N=47):  
  
f <- read.csv("OUTPUT \[f\].csv", header=TRUE, as.is=TRUE, sep=",", dec=".")  
initialpop=cbind(rep(f$x\[1\],NP),rep(f$x\[2\],NP),rep(f$x\[3\],NP),rep(f$x\[4\],NP),rep(f$x\[5\],NP),rep(f$x\[6\],NP),rep(f$x\[7\],NP),rep(f$x\[8\],NP),rep(f$x\[9\],NP),rep(f$x\[10\],NP),  
rep(f$x\[11\],NP),rep(f$x\[12\],NP),rep(f$x\[13\],NP),rep(f$x\[14\],NP),rep(f$x\[15\],NP),rep(f$x\[16\],NP),rep(f$x\[17\],NP),rep(f$x\[18\],NP),rep(f$x\[19\],NP),rep(f$x\[20\],NP),  
rep(f$x\[21\],NP),rep(f$x\[22\],NP),rep(f$x\[23\],NP),rep(f$x\[24\],NP),rep(f$x\[25\],NP),rep(f$x\[26\],NP),rep(f$x\[27\],NP),rep(f$x\[28\],NP),rep(f$x\[29\],NP),rep(f$x\[30\],NP),  
rep(f$x\[31\],NP),rep(f$x\[32\],NP),rep(f$x\[33\],NP),rep(f$x\[34\],NP),rep(f$x\[35\],NP),rep(f$x\[36\],NP),rep(f$x\[37\],NP),rep(f$x\[38\],NP),rep(f$x\[39\],NP),rep(f$x\[40\],NP),  
rep(f$x\[41\],NP),rep(f$x\[42\],NP),rep(f$x\[43\],NP),rep(f$x\[44\],NP),rep(f$x\[45\],NP),rep(f$x\[46\],NP),rep(f$x\[47\],NP))  
  
  
However would you know how I could accomplish stoping a process that is running yet retain the f values so that they could be used or the process can be restarted again at a latter time if required?  
  
Grant
<hr />
#### I created a more elegant solution to (1): ...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-12-02T04:46:18.556-06:00">Dec 5, 2011</time>

I created a more elegant solution to (1):  
  
f <- read.csv("OUTPUT \[f\].csv", header=TRUE, as.is=TRUE, sep=",", dec=".")  
for(i in 1:N){initialpop\[(i-1)\*NP+1\] <- f$x\[i\]}  
  
I am still however wondering how to achieve (2):  
  
2\. The ability to stop a search that is in process yet retain the current f values for use.
<hr />
#### Hi Grant, I don't currently know to accomplis...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-12-10T09:37:45.615-06:00">Dec 6, 2011</time>

Hi Grant,  
  
I don't currently know to accomplish your second request. Stopping the optimization requires you interrupt the code. There's probably a way to catch the interrupt and return the current iteration's _f_ values to the caller, but I'm not sure how to do it.  
  
That said, you can set **DEoptim.control$trace=TRUE**, manually copy/paste the last iteration's _f_ values prior to interrupt, then manually restart the job like you do to solve your first request.
<hr />
