---
title: 'Margin Constraints with LSPM'
date: 2010-08-01T23:31:00.000-05:00
draft: false
aliases: [ "/2010/08/margin-constraints-with-lspm.html" ]
tags : [Examples, LSPM]
---

#### Josh Thank you for providing the LSPM package - I...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-04-26T07:29:15.446-05:00">Apr 2, 2011</time>

Josh  
  
Thank you for providing the LSPM package - I would not have been able to experiment with using LSPM if I could not use the package. I would like to confirm two things:  
1) the maxUnits function has not been built in to the LSPM package - correct?  
2) what should one do if using leverage is not an option. I can see that it is similar to the example on this page ("margin constraints with LSPM") but do not understand why you set margin <- port$maxLoss (I see in some of your other examples you use multiples of maxLoss). I want to research the LSPM model for investing in mutual funds - where margin is not applicable. What should I set margin to in this case? Also <- to maxLoss? and why?  
  
Regards  
  
Chris
<hr />
#### Hi Chris, You're most welcome and I'm gla...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-04-26T09:17:29.554-05:00">Apr 2, 2011</time>

Hi Chris,  
  
You're most welcome and I'm glad you've found the package useful.  
  
1) Correct, it was just for illustration purposes in the post.  
  
2) For mutual funds, the margin is the current NAV of the fund. It doesn't necessarily have to be the same as maxLoss, but setting them both to the current NAV may make interpreting the output easier.
<hr />
#### Josh The penny has dropped. Thank you. Regards ...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-04-26T09:43:36.376-05:00">Apr 2, 2011</time>

Josh  
  
The penny has dropped. Thank you.  
  
Regards  
  
Chris
<hr />
#### Josh How do I set the individual maxloss equal to...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-05-02T08:01:44.835-05:00">May 1, 2011</time>

Josh  
  
How do I set the individual maxloss equal to the individual current NAV. I can see from your samples how to set margin equal to maxloss  
  
Regards  
  
Chris
<hr />
#### Hi Chris, If _port_ is your lsp object, you ...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-05-02T08:13:13.775-05:00">May 1, 2011</time>

Hi Chris,  
  
If _port_ is your lsp object, you can change maxLoss via something like:  
  
\# change first maxLoss  
port$maxLoss\[1\] <- -100  
  
\# assuming port has 3 systems  
\# set maxLoss for all 3 at once  
port$maxLoss <- c(-100,-200,-250)
<hr />
#### Hi Josh Thank you for the help again. I have now...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-05-03T03:20:24.400-05:00">May 2, 2011</time>

Hi Josh  
  
  
Thank you for the help again. I have now tried it - but are still doing something wrong. This is what I do after I have loaded the 5 mutual fund files (the files contain 156 months of percentage returns):  
aa <- cbind(a,b,c,d,e)  
jpt <- jointProbTable(aa,n=c(11,11,11,11,11))  
outcomes<-jpt\[\[1\]\]  
probs<-jpt\[\[2\]\]  
port<-lsp(outcomes,probs)  
  
When I view "port" all seems fine. I then set the values for DEoptim and determine optimalf  
res <- optimalf(port,control=DEctrl)  
Up to here everything seems fine when I view "res" – when I divide optimalf by maxLoss I get figures that I can understand. I then change maxLoss  
port$maxLoss <- c(-917,-343,-949,-1969,-1469)  
and run the margin constrained optimal calculation  
resMargin <- optimalf(port, control=DEctrl, equity=100000, margin=-port$maxLoss)  
  
I then get figures that do not make sense:  
Iteration: 1000 bestvalit: -1.000018 bestmemit: 0.000000 0.000000 0.999999 0.000000 0.000000  
  
I would really appreciate your help
<hr />
#### Chris, Your problem is your 5 mutual fund files o...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-05-03T12:12:44.200-05:00">May 2, 2011</time>

Chris,  
  
Your problem is your 5 mutual fund files of **percentage returns**. You need to convert those to dollar returns.  
  
The easiest way is to multiply the percentage returns by the current NAV. This also normalizes the dollar returns over time (the actual dollar returns would have been lower / higher when the fund NAV was lower / higher).
<hr />
#### Thank you again. I now got it working. By the way ...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-05-04T04:42:51.658-05:00">May 3, 2011</time>

Thank you again. I now got it working. By the way - my tests confirms what you found in your blog post above. What should I do to determine optimalf using drawdown and margin constraints. I have done models with drawdown contsraints- and models with margin constraintsnow - but do not know what to do where both contsraintsare used in one model.
<hr />
#### Chris, Simply add a drawdown constraint to the op...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-05-04T09:13:18.766-05:00">May 3, 2011</time>

Chris,  
  
Simply add a drawdown constraint to the optimalf() call with a margin constraint:  
  
opt <- optimalf(port, probDrawdown, 0.2, margin, initEq, DD=0.05, horizon=3)
<hr />
#### Josh I let the following run during the night : ...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-05-05T01:17:24.037-05:00">May 4, 2011</time>

Josh  
  
I let the following run during the night : opt <- optimalf(port, probDrawdown, 0.2, margin=-port$maxLoss, equity=100000, DD=0.05, horizon=3, snow=clust, control=DEctrl)  
  
after setting up a snow cluster. The result is Iteration: 1000 bestvalit: inf bestmemit: 0.003136 0.841765 0.481197 0.889789 0.812577  
  
Does this mean there that there is no solution - or am I doing something wrong
<hr />
#### Chris, It may mean there's no solution, but i...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-05-05T10:10:15.788-05:00">May 4, 2011</time>

Chris,  
  
It may mean there's no solution, but it's most-likely because the optimization algorithm couldn't find starting values.  
  
Add **initialpop=matrix(runif(np\*nc)/100,np,nc)** to **DEctrl**\--where np is DEoptim.control$NP (the default is 50) and nc is the number of columns in your joint probability table (appears to be 5 in your example).  
  
This should provide DEoptim with starting values within your constraints. If it doesn't work, try dividing by a number larger than 100.
<hr />
#### Joshua Thank you. it worked Regards Chris
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-05-06T03:39:17.495-05:00">May 5, 2011</time>

Joshua  
  
Thank you. it worked  
  
Regards  
  
Chris
<hr />
#### Chris, It appears to me that by setting your margi...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-08-16T23:37:10.073-05:00">Aug 3, 2011</time>

Chris,  
It appears to me that by setting your margin to the CURRENT NAV (via setting of maxLoss as you have done) within the actual objective function you may not be arriving at an optimal margin constrained f due to the past variability of NAV at each i/trade.  
Although the GHPR results (for a fixed margin) do support Josh's findings above, I am wondering myself now whether due to the fluctuating live margin requirements (i.e. MFs, equities, etc) we are best to stick to post optimisation constraints as outlined in Ralph's book instead of incorporating the CURRENT margin constraint into the objective function.  
What do others think on this?  
Grant
<hr />
#### Hi Grant, Thanks for the comment. The margin con...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-08-17T22:11:45.583-05:00">Aug 4, 2011</time>

Hi Grant,  
  
Thanks for the comment. The margin constraint only prevents the optimization from providing allocations greater than your available capital. It doesn't change the optimal growth calculation in any way. It removes part of the "leverage space" surface, similar to what a drawdown constraint does.  
  
Therefore, it uses _current_ NAVs / prices (in the case of mutual funds / equities) because those are those the prices at which we can transact. The historical margin requirements have no bearing on our current capital requirements.  
  
Hope that helps.
<hr />
#### Thank you for your reply Josh. It is actually a r...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-08-18T02:27:20.707-05:00">Aug 4, 2011</time>

Thank you for your reply Josh.  
  
It is actually a relief to hear you say this and based upon the great work that you have already accomplished with LSPM implementation I am pretty sure that you must be correct on this.  
  
However, what I have a hard time with at times is trying to convince myself of such details until I see the logic laid out in front of me, especially as I am currently new to R.  
  
What I am seeing (and please correct me if I am wrong) is that both current margin and current equity is being passed by the objective function:  
  
fun <- function(f, lsp, constrFun, constrVal, margin, equity,  
...) {  
.Call("objFun\_optimalf", f, lsp, margin, equity, constrFun,  
constrVal, new.env(), PACKAGE = "LSPM")  
  
to the genetic process:  
  
de <- DEoptim(fun, lower = l, upper = u, lsp = lsp, constrFun = constrFun,  
constrVal = constrVal, margin = margin, equity = equity,  
...)  
  
So, taking the stance that you are correct (although not convinced of it myself yet / and without delving into DEoptim) my question would therefore be:  
  
In your second example are margin and equity not actually used as part of the objective function to steer the genetic process but simply passed through to constrain the equity within limits at the end of each generation/iteration (much like your first example and Ralph does only once at the end of the last generation)?  
  
I hope I even got that question right? I think that it just needs a yes or a no. If the answer is yes then I'm on your page. Thanks Josh.  
  
Grant
<hr />
#### Grant, Your understanding is close. margin and e...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-08-18T10:50:14.849-05:00">Aug 4, 2011</time>

Grant,  
  
Your understanding is close. margin and equity are used as part of the objective function, but they are only checked after GHPR is calculated. Instead of returning the calculated GHPR, the objective function returns a very large number if you're outside of your margin constraints, which causes DEoptim to ignore that particular set of f values.
<hr />
#### On the same page with this now. Your clarification...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-08-18T21:20:16.893-05:00">Aug 5, 2011</time>

On the same page with this now. Your clarifications have helped with this. Thank you.
<hr />
#### Josh, I am still trying to wrap my brain around t...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-08-21T08:35:33.455-05:00">Aug 0, 2011</time>

Josh,  
  
I am still trying to wrap my brain around the useful advise that you gave to Chris where you said:  
  
"For mutual funds, the margin is the current NAV of the fund. It doesn't necessarily have to be the same as maxLoss, but setting them both to the current NAV may make interpreting the output easier."  
  
For purposes of this discussion lets take an IB Portfolio Margin Account trading equities which will have a margin requirement of 15% \[as opposed to Reg-T's 50%\].  
Let's also assume that 1 Unit in LSPM is equal to a fixed $10,000 amount/position as opposed to a fixed number of shares \[We could view this as a unit of 1 share at a price of $10,000\].  
  
So now my question: Bearing in mind that I do not want to alter the actual JPT in anyway are there any implications that I need to be aware of when setting maxLoss equal the to actual margin requirements as just defined with the following:  
  
  
port$maxLoss <- c(-1500,-1500,-1500) # 15% Margin = 15% of $10,000 \[Portfolio Margin Account\]  
margin <- -port$maxLoss  
  
  
I assume that this is in line with what you were suggesting above.  
  
Taking data(port) by way of example we would thus end up with something looking like:  
  
  
V1 V2 V3  
f 1e-01 1e-01 1e-01  
Max Loss -5e+03 -5e+03 -5e+03  
probs V1 V2 V3  
\[1,\] 0.07692308 -150.000 253.000 533.000  
\[2,\] 0.07692308 -45.333 -1000.000 220.143  
\[3,\] 0.15384615 -45.333 -64.429 220.143  
\[4,\] 0.07692308 13.000 -64.429 -500.000  
\[5,\] 0.07692308 13.000 -64.429 533.000  
\[6,\] 0.07692308 13.000 253.000 220.143  
\[7,\] 0.07692308 13.000 253.000 799.000  
\[8,\] 0.07692308 13.000 448.000 220.143  
\[9,\] 0.07692308 79.667 -64.429 -325.000  
\[10,\] 0.07692308 79.667 -64.429 220.143  
\[11,\] 0.07692308 79.667 -64.429 533.000  
\[12,\] 0.07692308 136.000 253.000 220.143  
  
  
The JPT thus remains as is with only both of the maxLoss and margins altered.  
  
I am wondering how this might adversely impact upon the leverage space landscape?  
I am also wondering just why it is that you said that setting them both the same makes interpreting the output easier?
<hr />
#### Correction! The lsp object would look like below (...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-08-21T08:45:20.028-05:00">Aug 0, 2011</time>

Correction! The lsp object would look like below (the above you will see was for a RegT50% example):  
  
  
V1 V2 V3  
f 0.1 0.1 0.1  
Max Loss -1500.0 -1500.0 -1500.0  
probs V1 V2 V3  
\[1,\] 0.07692308 -150.000 253.000 533.000  
\[2,\] 0.07692308 -45.333 -1000.000 220.143  
\[3,\] 0.15384615 -45.333 -64.429 220.143  
\[4,\] 0.07692308 13.000 -64.429 -500.000  
\[5,\] 0.07692308 13.000 -64.429 533.000  
\[6,\] 0.07692308 13.000 253.000 220.143  
\[7,\] 0.07692308 13.000 253.000 799.000  
\[8,\] 0.07692308 13.000 448.000 220.143  
\[9,\] 0.07692308 79.667 -64.429 -325.000  
\[10,\] 0.07692308 79.667 -64.429 220.143  
\[11,\] 0.07692308 79.667 -64.429 533.000  
\[12,\] 0.07692308 136.000 253.000 220.143
<hr />
#### Hi Grant, Changing the max loss doesn't alter...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-09-04T17:48:20.277-05:00">Sep 0, 2011</time>

Hi Grant,  
  
Changing the max loss doesn't alter the _optimum_ of the leverage space landscape; it only exists to bound the f values between 0 and 1. The maximum GHPR and _f$_ are invariant to max loss. If you're mathimatically inclined, you could think of it as a monotonic transformation.  
  
Chris was asking about mutual funds without margin, so his effective margin was 100% the NAV of the fund. Setting max loss equal to the NAV is optional, but I find it easiest to think of _f_ in terms of "% lost if I lose everything" rather than "% lost if the worst outcome (up to this point) occurs".  
  
So, it's not generally the case that you should set margin = max loss = price.  
  
Hope that helps.  
  
Best,  
Josh
<hr />
#### Thank you for your reply Josh, I am conversant wit...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-09-06T12:05:16.931-05:00">Sep 2, 2011</time>

Thank you for your reply Josh,  
I am conversant with the reason for setting MaxLoss to bound f and so really my concern was just whether you might see any implication with setting an arbitary MaxLoss such as equal to Margin when this is not actually reflected in the JPT that keeps the original MaxLoss values in place.
<hr />
#### Josh, I often find that the integrated margining o...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-11-07T23:11:25.880-06:00">Nov 2, 2011</time>

Josh,  
I often find that the integrated margining often reduces component f values to zero for all but one component system in a portfolio.  
  
E.g.  
Results <- optimalf(Port, snow=Clust, control=DEctrl, equity=Equity, margin=Margin)  
  
would result in  
  
Iteration: 10000 bestvalit: -1.050794 bestmemit: 0.000010 0.000001 0.000005 0.000001 0.000002 0.000002 0.000003 0.311963 0.000002 0.000024  
.....  
Iteration: 20000 bestvalit: -1.050796 bestmemit: 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.312016 0.000000 0.000000  
  
whereas  
Results <- optimalf(Port, snow=Clust, control=DEctrl)  
  
would result in a working allocation (after adjusting post-op for actual available equity of-course) such as  
  
Iteration: 10000 bestvalit: -1.493334 bestmemit: 0.954889 0.332320 0.000000 1.000000 0.485268 0.291476 1.000000 0.941770 0.806778 0.398070  
  
Have you seen this occurring from your end? Any idea why this could be occurring? Please let me know if you might require any further information to determine why this is happening.  
  
Grant  
  
Myself, I am not sure how to peer into the objective function code to see what is causing this  
fun <- function(f, lsp, constrFun, constrVal, margin, equity,  
...) {  
.Call("objFun\_optimalf", f, lsp, margin, equity, constrFun,  
constrVal, new.env(), PACKAGE = "LSPM")
<hr />
#### Grant, My personal experience is that portfolios ...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-11-09T19:14:12.730-06:00">Nov 4, 2011</time>

Grant,  
  
My personal experience is that portfolios optimized for unconstrained-growth tend to be heavily concentrated in a few components, so your results aren't terribly surprising. Try adding a maxDrawdown constraint of 5% or so and you should see more non-zero f values across components.  
  
I would be interested in the GHPR of the portfolio that was optimized without the margin constraint _after_ adjusting for available equity. I would expect it to be less than 1.050796; let me know if you get a different result.  
  
The objective function code is in C, so you would have to look at the source code for [objectiveFunction.c](https://r-forge.r-project.org/scm/viewvc.php/pkg/src/objectiveFunction.c?view=markup&root=lspm).  
  
Best,  
Josh
<hr />
#### Josh, You said: "I would be interested in th...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-11-10T22:45:45.328-06:00">Nov 5, 2011</time>

Josh,  
  
You said:  
"I would be interested in the GHPR of the portfolio that was optimized without the margin constraint after adjusting for available equity. I would expect it to be less than 1.050796; let me know if you get a different result."  
  
Response:  
I do infact optain results greater than 1.050796 even after adjusting for available equity, GHPR=1.493334 before and GHPR=1.215942 after (please see the details that follow)  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
Here is the setup with N = 10 stable market-systems:  
  
  
\# SETUP HPR DATA  
  
setwd("xxxxx")  
  
N <- 10 # The number of component strategies  
  
A <- read.csv("A.csv", header=FALSE, as.is=TRUE, sep=",", dec=".")  
B <- read.csv("B.csv", header=FALSE, as.is=TRUE, sep=",", dec=".")  
C <- read.csv("C.csv", header=FALSE, as.is=TRUE, sep=",", dec=".")  
D <- read.csv("D.csv", header=FALSE, as.is=TRUE, sep=",", dec=".")  
E <- read.csv("E.csv", header=FALSE, as.is=TRUE, sep=",", dec=".")  
F <- read.csv("F.csv", header=FALSE, as.is=TRUE, sep=",", dec=".")  
G <- read.csv("G.csv", header=FALSE, as.is=TRUE, sep=",", dec=".")  
H <- read.csv("H.csv", header=FALSE, as.is=TRUE, sep=",", dec=".")  
I <- read.csv("I.csv", header=FALSE, as.is=TRUE, sep=",", dec=".")  
J <- read.csv("J.csv", header=FALSE, as.is=TRUE, sep=",", dec=".")  
  
rtns <- cbind(  
A$V2,  
B$V2,  
C$V2,  
D$V2,  
E$V2,  
F$V2,  
G$V2,  
H$V2,  
I$V2,  
J$V2)  
  
\# VARIABLES  
  
cores = 8 # Number of CPU cores available  
  
equity = 1000000 # Equity available for trading  
unit = 10000 # The size of one trade unit  
marginpct = 0.50 # Margin percentage  
  
NP = 10\*N # The number of population members  
iterations = 1000 # The maximum number of iterations  
crossover = 0.6 # The probability of crossover  
  
bins = 20 # The number of bins  
  
\# LOAD R PACKAGES  
  
library(LSPM)  
library(parallel)  
  
\# CREATE A SOCKET CLUSTER FOR ALL CORES  
  
clust <- makePSOCKcluster(cores)  
  
\# SETUP MARGIN  
  
margin <- rep(marginpct\*unit, N)  
  
\# DEoptim PARAMETERS  
  
#DEctrl <- list(NP=NP, itermax=iterations, CR=crossover, trace=iterations/50)  
  
initialpop=matrix(runif(NP\*N)/100,NP,N) # SETUP AN INITIAL POPULATION (if required)  
DEctrl <- list(NP=NP, itermax=iterations, CR=crossover, trace=iterations/50, initialpop=initialpop)  
  
\# SETUP THE JPT  
  
#port <- jointProbTable(rtns, n=rep(bins,N)) # BINNED  
  
probs <- rep(1/nrow(A), nrow(A)) # RAW  
port <- lsp(rtns, probs) # RAW  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
<hr />
#### \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* Usi...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-11-10T22:48:56.559-06:00">Nov 5, 2011</time>

\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
Using the integrated margin constraints:  
results <- optimalf(port, snow=clust, control=DEctrl, equity=equity, margin=margin)  
  
would result in the following:  
  
Iteration: 20000 bestvalit: -1.050796 bestmemit: 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.312016 0.000000 0.000000  
  
which clearly favours the 8th market-system above all else  
  
\> results$G  
\[1\] 1.050796  
\> # CHECK  
\> port$f <- results$f  
  
**\> GHPR(port)  
\[1\] 1.050796  
\> # Equity Required  
\> sum(equity/(-port$maxLoss/port$f)\*unit)  
\[1\] 2e+06**  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
However if I am now to run without the integrated margin constraints  
results <- optimalf(port, snow=clust, control=DEctrl)  
  
would result in the following:  
  
Iteration: 20000 bestvalit: -1.493334 bestmemit: 0.954889 0.332320 0.000000 0.485268 0.291476 0.806778 0.398070 0.941770 1.000000 1.000000  
  
which no longer favours any one market-system using the same data  
  
\> results$G  
\[1\] 1.493334  
\> # CHECK  
\> port$f <- results$f  
  
**\> GHPR(port)  
\[1\] 1.493334  
\> # Equity Required  
\> sum(equity/(-port$maxLoss/port$f)\*unit)  
\[1\] 50147451**  
  
Adjusting for the available equity (equity/maginpct=2e+06) now we obtain a realistic GHPR value 0f 1.215942 that is still way above the integrated result of 1.050796 above on the same equity constraint of 2e+06:  
  
\> weighting <- port$f/sum(port$f)/marginpct  
\> # CHECK  
\> sum(weighting)  
\[1\] 2  
\> port$f <- weighting  
  
**\> GHPR(port)  
\[1\] 1.215942  
\> # Equity Required  
\> sum(weighting\*equity)  
\[1\] 2e+06**  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
So taking these results alone we can see that there is indeed something untoward happening with the integrated magining approach.  
  
What are your thoughts on this?  
  
Grant
<hr />
#### Josh, Looking at the above results further I noti...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-11-10T23:22:18.123-06:00">Nov 5, 2011</time>

Josh,  
  
Looking at the above results further I noticed one other important point of interest.  
Although I have been able to successfully rebalance portfolios by **NOT** using the integrated magining approach I did notice that the final two market systems had maxed out at f=1.000000  
  
This led me to believe that the port$maxLoss values were not always constraining ALL of the market-system f values between 0 and 1 when working with a multiple component case.  
  
It occurred to me to therefore set all the maxLoss values to a standard abitarry value that would accomodate for all components by simply setting to the smallest absolute value:  
  
port$maxLoss <- rep(max(port$maxLoss), N)  
  
This indeed proved successfull with all f$ (f-dollar) values stable at or below this absolute value.  
  
It was my hope that this refinement might address the margining issue we are discussing above but alas it is not related and the above integrated marginging issue still stands. However it did successfully address the f value bounding issue as you can see here:  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
\# SETUP THE JPT  
  
#port <- jointProbTable(rtns, n=rep(bins,N)) # BINNED  
  
probs <- rep(1/nrow(A), nrow(A)) # RAW  
port <- lsp(rtns, probs) # RAW  
  
**port$maxLoss <- rep(max(port$maxLoss), N)**  
  
  
\# CALCULATE OPTIMAL F  
  
#(Margin constrained)  
#system.time({ results <- optimalf(port, snow=clust, control=DEctrl, equity=equity, margin=margin) })  
  
#(Unconstrained)  
system.time({ **results <- optimalf(port, snow=clust, control=DEctrl)** })  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
would result in the following:  
  
Iteration: 20000 bestvalit: -1.529956 bestmemit: 0.759071 0.248085 0.000000 0.267481 0.450634 0.907357 0.183890 0.608468 0.847335 0.883034  
  
which no longer hits f-value limits using the same data  
  
\> results$G  
\[1\] 1.529956  
\> # CHECK  
\> port$f <- results$f  
  
**\> GHPR(port)  
\[1\] 1.529956  
\> # Equity Required  
\> sum(equity/(-port$maxLoss/port$f)\*unit)  
\[1\] 60538725**  
  
Adjusting for the available equity (equity/maginpct=2e+06) now we obtain a realistic GHPR value 0f 1.215942 that is still way above the integrated result of 1.050796 above on the same equity constraint of 2e+06:  
  
\> weighting <- port$f/sum(port$f)/marginpct  
\> # CHECK  
\> sum(weighting)  
\[1\] 2  
\> port$f <- weighting  
  
**\> GHPR(port)  
\[1\] 1.285853  
\> # Equity Required  
\> sum(weighting\*equity)  
\[1\] 2e+06**  
  
Grant
<hr />
#### In Summary: **USING INTEGRATED MARGIN CONSTRAINT...**
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-11-10T23:41:50.693-06:00">Nov 5, 2011</time>

In Summary:  
  
**USING INTEGRATED MARGIN CONSTRAINTS**  
  
results <- optimalf(port, snow=clust, control=DEctrl, equity=equity, margin=margin)  
  
GHPR = **1.050796** Equity Required = **2e+06**  
  
  
**USING POST-OP MARGIN CONSTRAINTS**  
  
results <- optimalf(port, snow=clust, control=DEctrl)  
  
GHPR = 1.493334 Equity Required = 50147451  
GHPR = **1.215942** Equity Required = **2e+06**  
  
  
**USING POST-OP MARGIN CONSTRAINTS + RELEASING F FROM HITTING LIMITS**  
  
port$maxLoss <- rep(max(port$maxLoss), N)  
results <- optimalf(port, snow=clust, control=DEctrl)  
  
GHPR = 1.529956 Equity Required = 60538725  
GHPR = **1.285853** Equity Required = **2e+06**  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
I appreciate that this is a lot of information but hopefully it paints a clear picture now.  
  
Grant
<hr />
#### Grant, Rather than making things clearer, your 4 ...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-11-14T18:41:33.439-06:00">Nov 2, 2011</time>

Grant,  
  
Rather than making things clearer, your 4 comments only raise more questions. I'm afraid I can only respond to your 4 comments if you provide a reproducible example. I don't have the time to consider all the theoretical causes of the results you show, especially when one of them is human error (not necessarily yours).
<hr />
#### Josh, I have sent you the files necessary to repr...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-11-14T20:38:37.353-06:00">Nov 2, 2011</time>

Josh,  
  
I have sent you the files necessary to reproduce the above results for yourself (by email).  
  
Please note that the above is one single report/comment which I sent in response to the conflicting expectations:  
  
"I would expect it to be less than 1.050796; let me know if you get a different result."  
  
Please take a look, because you have noted "My personal experience is that portfolios optimized for unconstrained-growth tend to be heavily concentrated in a few components". My own observations are showing this to be an issue with the integrated margining only, so this may be of interest for you also.  
  
Could you please also explain what "human error" you have observed.  
  
Grant
<hr />
#### Josh In an earlier post you said that I should us...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-11-22T14:41:18.404-06:00">Nov 2, 2011</time>

Josh  
  
In an earlier post you said that I should use normalized dollar returns. I have been preparing files in Excel. Is there an easy way command/method in R that I can use to normalize a file that has three columns - security name, date and NAV/close price for that day. A line in the file would for example read:  
Fundname,20110217,1110.00  
  
Regards
<hr />
#### Hello Chris, If you take a look at the example co...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-11-22T19:30:53.106-06:00">Nov 3, 2011</time>

Hello Chris,  
  
If you take a look at the example code I posted above you can get your csv data into R with something as simple as:  
  
A <- read.csv("A.csv", header=FALSE, as.is=TRUE, sep=",", dec=".”)  
B <- read.csv(“B.csv", header=FALSE, as.is=TRUE, sep=",", dec=".”)  
.  
.  
  
rtns <- cbind(A$V3,B$V3,…..)  
  
You can then manipulate your data in R as required.  
  
A$V3,B$V3,….. etc takes your data from the 3rd column.  
  
I’m no expert at R but this works for me, and hopefully for you too.  
  
Grant
<hr />
#### Grant I appreciate your reply. I agree that what ...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-11-23T00:18:44.960-06:00">Nov 3, 2011</time>

Grant  
  
I appreciate your reply. I agree that what you have posted is a way to get CSV data in to R. I am however looking for a way to "normalize" the dollar returns. I use to do this in Excel by: converting closing prices to percentage returns and then multiplying the result by the current NAV. It is this manipulation that I want to do in R.
<hr />
#### Chris, Here's a snippet that should be close ...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-11-24T19:12:52.308-06:00">Nov 5, 2011</time>

Chris,  
  
Here's a snippet that should be close to what you want to do.  
  
\# create random price data  
set.seed(21)  
price <- matrix(1+rnorm(50)/10,10,5)  
price <- rbind(runif(5)\*10,price)  
price <- apply(price,2,cumprod)  
\# calculate normalized P&L  
library(TTR)  
\# calculate % return  
rtns <- apply(price,2,ROC)  
\# initialize P&L object  
pnl <- rtns  
\# multiply each % return by last price  
for(i in 1:NCOL(pnl)) {  
pnl\[,i\] <- rtns\[,i\]\*tail(price,1)\[,i\]  
}
<hr />
#### Brilliant Josh Thank you. I replicated the calcul...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-11-25T09:24:29.601-06:00">Nov 5, 2011</time>

Brilliant Josh  
  
Thank you. I replicated the calculations in Excel - to make sure that I understand what is being done where in the code you posted - and it works as I expected!  
  
There was an instance where the calculations in R were quite a bit different from the results in R. The two specific random values that R generated was 7.352263 and 5.678313. R gave a ROC of -0.25835388 while Excel gives -0.227678199 - which differs by 0.030675681. Do you think differences like this is small enough to ignore? R is probably more accurate in any case.
<hr />
#### Chris, It's probably due to different calcula...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-11-25T09:32:42.805-06:00">Nov 5, 2011</time>

Chris,  
  
It's probably due to different calculation methods. Read the ROC help page and compare the ROC calculation to how you're calculating % change in Excel.
<hr />
#### Josh Thank you for your reply - I am however goin...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-11-26T16:21:08.272-06:00">Nov 6, 2011</time>

Josh  
  
Thank you for your reply - I am however going to ignore the difference between the result in R and Excel for the moment.  
  
I am getting a "Error: subscript out of bounds" when I run the "# multiply each % return by last price" piece of the code you posted. Could the reason be the size of the matrix? I am working with a matrix that has 439 rows and 41 columns. Would multiplying by zero cause the error - some of the values in the matrix is zero because the price for some funds is the same for two days - resulting in the percentage difference being zero.  
  
I have searched the internet for an explanation of the error but could not find anything that seems related. I would appreciate your help.
<hr />
#### Josh My apologies - I made a mistake. The code is...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-11-29T10:20:45.733-06:00">Nov 2, 2011</time>

Josh  
  
My apologies - I made a mistake. The code is working now.  
  
Regards
<hr />
#### Hello Josh, I have a relevant question when using...
[Unknown](https://www.blogger.com/profile/13660622390753681532 "noreply@blogger.com") - <time datetime="2012-10-02T09:01:33.264-05:00">Oct 2, 2012</time>

Hello Josh,  
  
I have a relevant question when using maxProbProfit with margin constraints. Basically when maximizing for horizon>1 , say 6 period, the function returns z- values close to -1 which means that rebalancing on each subsequent period becomes very aggressive which (in some cases) violates the margin constraint. My question is whether the maxProbProfit function takes into account the margin constraint on all subsequent periods during optimization.  
I understand that i can cap the minimum z- values but i would expect the function to handle this.  
  
Many thanks in advance  
Kostas Metaxas
<hr />
#### Hi Kostas, The _maxProbProfit_ function chec...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2012-10-13T19:03:31.185-05:00">Oct 0, 2012</time>

Hi Kostas,  
  
The _maxProbProfit_ function checks the margin constraint before calculating the probability of profit, and the probability of profit calculation does not currently check the margin constraint at each future time step. I would welcome suggestions about how to best incorporate this into the current code.  
  
Best,  
Joshua
<hr />
