---
title: 'Tactical asset allocation using blotter'
date: 2009-11-18T21:18:00.015-06:00
draft: false
aliases: [ "/2009/11/tactical-asset-allocation-using-blotter.html" ]
tags : [blotter, Code]
---

#### Hi, If I change to.monthly() to to.weekly() it se...
[Unknown](https://www.blogger.com/profile/12339660005815965945 "noreply@blogger.com") - <time datetime="2009-11-26T06:47:48.072-06:00">Nov 4, 2009</time>

Hi,  
  
If I change to.monthly() to to.weekly() it seems to die strangely. Any ideas?  
  
Cheers,  
\--------  
Error in if (!all(i <= 0)) stop("only zeros may be mixed with negative subscripts") :  
missing value where TRUE/FALSE needed  
Calls: updateAcct -> calcPortfSummary -> time -> \[ -> \[.xts
<hr />
#### Thanks Josh for providing this nice example of the...
[pg](https://www.blogger.com/profile/03166547932461080321 "noreply@blogger.com") - <time datetime="2009-11-26T10:27:59.293-06:00">Nov 4, 2009</time>

Thanks Josh for providing this nice example of the use of blotter.  
  
Just as a side note: shouldn't you be using adjusted (for dividends) prices for both ETFs ? I did that, and while the return on the buy-and-hold strategy increased substantially, the risk-return profile continued favorable to the tactical allocation (with max drawdown of just above 3.5%).  
rgds.
<hr />
#### Aaron, the problem you got is probably due to time...
[pg](https://www.blogger.com/profile/03166547932461080321 "noreply@blogger.com") - <time datetime="2009-11-26T14:18:16.442-06:00">Nov 4, 2009</time>

Aaron, the problem you got is probably due  
to time zone problems. In the updatePortf() function there is a call to  
as.POSIXct(), which converts to your local time zone. Then, when you compare back to, let's say, time(IEF) you will not get compatible date-time stamps !  
  
Josh, is it possible to make blotter functions robust to different time-zones ?
<hr />
#### Aaron, As pg mentioned, it's due to timezone ...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2009-11-29T19:27:44.377-06:00">Nov 1, 2009</time>

Aaron,  
  
As pg mentioned, it's due to timezone issues when converting from a "Date" class to "POSIXct". The fix is to add drop.time=FALSE to the to.weekly() call.  
  
pg,  
  
Timezone issues are just plain hard. blotter uses xts, which aims to be robust to timezone differences. The above issue will be addressed in a future xts release.  
  
And yes, I probably should have adjusted the series for splits and dividends. You can do that with the adjustOHLC() function in quantmod.  
  
Thanks for the comments!
<hr />
#### Hi very good work. When I run your codes on my ow...
[gamma_sf](https://www.blogger.com/profile/02835246221017053386 "noreply@blogger.com") - <time datetime="2009-12-18T21:09:44.219-06:00">Dec 6, 2009</time>

Hi very good work.  
  
When I run your codes on my own, I get this error "improper length of one or more arguments to merge.xts". Do you have a suggestion to fix it?
<hr />
#### gamma, Without more information, I have no idea w...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2009-12-19T12:28:43.380-06:00">Dec 6, 2009</time>

gamma,  
  
Without more information, I have no idea where to start. What line caused the error? What version of R, xts, quantmod, etc. are you using? Did you run this code in a clean environment?
<hr />
#### sorry, I'm using R 2.10.0 version and the line...
[gamma_sf](https://www.blogger.com/profile/02835246221017053386 "noreply@blogger.com") - <time datetime="2009-12-21T22:04:58.597-06:00">Dec 2, 2009</time>

sorry, I'm using R 2.10.0 version and the lines causing errors are:  
\[1\] "Setting up indicators"  
\> IEF$SMA <- SMA(Cl(IEF), 10)  
Error in error(x, ...) :  
improper length of one or more arguments to merge.xts  
\> SPY$SMA <- SMA(Cl(SPY), 10)  
Error in error(x, ...) :  
improper length of one or more arguments to merge.xts  
\>  
\> x <- SMA(Cl(IEF), 10)  
\> y <- SMA(Cl(SPY), 10)  
\>  
\> IEF <- merge(IEF, x)  
Error in error(x, ...) :  
improper length of one or more arguments to merge.xts
<hr />
#### gamma, It seems that you're not running the c...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2009-12-22T11:58:49.741-06:00">Dec 2, 2009</time>

gamma,  
  
It seems that you're not running the code I've posted above. This is evidenced by the lines you posted that use "<-" instead of "=" for assignment (as I did). That's not to imply that the choice of assignment operator is causing issues, but instead that I can't debug changes you've made.  
  
I just re-ran the code in the post with R-2.10.1 using the most recent version of xts from both CRAN and r-forge. I had no errors or warnings.  
  
I'd be happy to look at your code, if you'd like. Please email it to me at josh m ulrich at gmail (replace the spaces before @ with dots).
<hr />
#### Josh, thank you for this nice introduction to blot...
[Unknown](https://www.blogger.com/profile/02226069659408585327 "noreply@blogger.com") - <time datetime="2010-01-06T02:26:12.263-06:00">Jan 3, 2010</time>

Josh, thank you for this nice introduction to blotter. Helps me a lot getting started.  
  
Cheers  
Simon
<hr />
#### Hi Executed: portfolio = initPortf(symbols, initD...
[Stephen](https://www.blogger.com/profile/12965174785718327168 "noreply@blogger.com") - <time datetime="2010-01-19T20:53:07.181-06:00">Jan 3, 2010</time>

Hi  
  
Executed:  
portfolio = initPortf(symbols, initDate=initDate)  
  
Received following error:  
Error in vector("list", length = length(symbols)) : element 1 is empty; the part of the args list of 'length' being evaluated was: (symbols)  
  
Any help would be appreciated. I have executed the code as typed on your blog.
<hr />
#### Hi Stephen, There's been a lot of activity in...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-01-19T21:12:12.374-06:00">Jan 3, 2010</time>

Hi Stephen,  
  
There's been a lot of activity in the blotter repository in the past couple weeks. The code should still work with revision 120, but later revisions may have issues with the code as posted.  
  
So, use revision 120 if you're comfortable building from source. If not, give me a couple days to figure out what's changed in the most recent revisions.  
  
Best,  
Josh
<hr />
#### The code is now updated to work with revision 193....
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-01-20T19:07:33.735-06:00">Jan 4, 2010</time>

The code is now updated to work with revision 193.
<hr />
#### Josh- not sure if this is a version error or what ...
[RepentantBankster](https://www.blogger.com/profile/02243091796264106946 "noreply@blogger.com") - <time datetime="2010-02-06T13:21:28.468-06:00">Feb 6, 2010</time>

Josh- not sure if this is a version error or what but, when running your program I keep getting these error even after I dump all workspace objects.  
  
\[1\] "Initializing portfolio and account structure"  
\> portfolio = initPortf(symbols=symbols, initDate=initDate)  
Error in initPortf(symbols = symbols, initDate = initDate) :  
Portfolio default already exists, use updatePortf() or addPortfInstr() to update it.  
\> account = initAcct(portfolios='default', initDate=initDate)  
Error in initAcct(portfolios = "default", initDate = initDate) :  
Account default already exists, use updateAcct() or create a new account.  
  
  
additionally this pops up later because 'account' is not defined  
  
\+ } # End dates loop  
Error in getEndEq(account, CurrentDate) : object 'account' not found  
  
If you could shed any light on the first error I would be relieved. I have just started using R and am still getting used to all of its functions.
<hr />
#### Hi Zachary, That could be a version issue. I jus...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-02-06T21:14:10.297-06:00">Feb 0, 2010</time>

Hi Zachary,  
  
That could be a version issue. I just ran the example using revision 232 without error. It's hard to say what's causing your issue without more information. Feel free to email me if you'd like more help.  
  
Best,  
Josh
<hr />
#### \> # Convert data to monthly frequency (to.weekl...
[Unknown](https://www.blogger.com/profile/18403699889033818605 "noreply@blogger.com") - <time datetime="2010-03-03T18:41:32.460-06:00">Mar 4, 2010</time>

\> # Convert data to monthly frequency (to.weekly() needs drop.time=FALSE)  
  
\> IEF = to.monthly(IEF, indexAt='endof')  
  
Error in to.period(x, "months", indexAt = indexAt, name = name, ...) :  
NA/NaN/Inf in foreign function call (arg 3)  
Calls: to.monthly -> to.period -> .Fortran  
In addition: Warning message:  
In to.period(x, "months", indexAt = indexAt, name = name, ...) :  
missing values removed from data  
  
  
How do I fix this?
<hr />
#### judsonm123, As I've said to others: without m...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-03-03T19:56:41.340-06:00">Mar 4, 2010</time>

judsonm123,  
  
As I've said to others: without more information, I have no idea what's causing your error or how to fix it.  
  
Best,  
Josh
<hr />
#### Hi, Thanks for this great example. I ran across ...
[SP](https://www.blogger.com/profile/06415469239466265644 "noreply@blogger.com") - <time datetime="2010-03-04T09:12:05.724-06:00">Mar 4, 2010</time>

Hi,  
  
Thanks for this great example.  
  
I ran across this error:  
"  
\> # Plot Strategy Summary  
\> png(filename="20091118\_blotter\_strategy.png", 720, 720)  
\> charts.PerformanceSummary(ROC(getAccount(account)$TOTAL$End.Eq)\[-1\],main="Tactical Asset Allocation")  
Error in \`\[.xts\`(x, start.row, 1) : subscript out of bounds  
\> dev.off()  
null device  
1 "  
  
Any ideas what might be the problem?  
  
Thanks in advance.  
  
Kind regards,  
Nim.
<hr />
#### Nim, Sorry, it was a bug in the code caused by so...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-03-07T15:44:24.778-06:00">Mar 0, 2010</time>

Nim,  
  
Sorry, it was a bug in the code caused by some recent updates to blotter on R-forge. The example works now.
<hr />
#### Josh, Thanks for posting the example. I've be...
[Unknown](https://www.blogger.com/profile/10432286752304075125 "noreply@blogger.com") - <time datetime="2010-04-13T20:32:45.967-05:00">Apr 3, 2010</time>

Josh,  
Thanks for posting the example. I've been working with this example and ran into the same error as judsonm123. It appears that IEF = adjustOHLC(IEF) results in NAs for the OHLC columns which then creates an error in to.monthly and SMA calculations. I'm running R 2.10.1 with the latest required libraries. I'm still trying to figure it out but I thought I'd let you know.  
  
Best Regards,  
Trey
<hr />
#### Trey, Thanks for the information. It looks like ...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-04-13T21:57:41.262-05:00">Apr 3, 2010</time>

Trey,  
  
Thanks for the information. It looks like something changed in merge.xts that is affecting the adjustment algorithm. I'm busy preparing for, and attending, [R/Finance 2010](http://www.rinfinance.com/), so I won't be able to dig into this further until next week. Thanks for the report.  
  
Best,  
Josh
<hr />
#### Josh, I changed the code to the following: IEF =...
[Unknown](https://www.blogger.com/profile/10432286752304075125 "noreply@blogger.com") - <time datetime="2010-04-29T10:12:15.823-05:00">Apr 4, 2010</time>

Josh,  
I changed the code to the following: IEF = adjustOHLC(IEF, use.Adjusted=TRUE) and I did the same for SPY. Everything worked fine. The documentation does state that this method is less accurate.  
  
  
As is, this system isn't tradable. I'm not sure if you intended that or not. In my opinion, it's important to make sure that a back-test is actually tradable, in the sense that it could actually be executed in real time. The rule is "If Close > SMA buy on close". The values are determined after the market has closed which requires you buy at the next bar, not that bar close. In this example, that would be the open of the following month. It seems that we would need to switch to daily for the entry. I'll see what I can do. Thanks again for the code and I hope this helps.  
  
Are the presentations from R/Fin 2010 going to posted with prior years?
<hr />
#### Trey, Yes, that will work until I can fix the adj...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-04-29T10:26:36.743-05:00">Apr 4, 2010</time>

Trey,  
  
Yes, that will work until I can fix the adjustment algorithm. Accuracy is only an issue for securities with many splits and/or dividends over an extended period of time.  
  
You're correct that _code_ couldn't be executed in real-time. That said, this strategy trades very infrequently and you would generally know well ahead of time whether the month-end close would be above/below the SMA, so you _could_ enter the trades at the month-end close. Your observation is _very_ important at higher frequencies, however.  
  
The R/Finance 2010 presentations should be on the website in a few weeks. I'll post when they're available.
<hr />
#### Josh, I just downloaded the latest MacOS X Leopard...
[G$](https://www.blogger.com/profile/01349972242888715865 "noreply@blogger.com") - <time datetime="2010-05-09T22:00:17.156-05:00">May 1, 2010</time>

Josh, I just downloaded the latest MacOS X Leopard binary for blotter and am trying to follow the example so I can use the package with my Fixed Income Calendar Effects strategy, but I am getting some environment errors such as:  
  
Error in updatePosPL(Portfolio = pname, Symbol = as.character(symbol), :  
could not find function "getPrice"  
  
Am I missing an installed package, or do I have to do something to expose the getPrice function?
<hr />
#### G$, getPrice is in quantmod. Run update.packages...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-05-09T22:03:42.652-05:00">May 1, 2010</time>

G$,  
  
getPrice is in quantmod. Run update.packages(). If that doesn't work, get the most recent version of quantmod from R-forge.
<hr />
#### Sorry, I did download the latest off r-forge, vers...
[G$](https://www.blogger.com/profile/01349972242888715865 "noreply@blogger.com") - <time datetime="2010-05-09T23:17:37.872-05:00">May 1, 2010</time>

Sorry, I did download the latest off r-forge, version 03.03-14.  
  
I loaded the package, library(quantmod)  
  
I can't find any getPrice.R in the R directory, neither can I use help(getPrice) to find any documentation for it to pull from the man directory. I do see a getQuote?
<hr />
#### getPrice isn't exported, which is why you can&...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-05-10T08:10:47.726-05:00">May 1, 2010</time>

getPrice isn't exported, which is why you can't find it via the methods you tried. It's in the source file Price.transformations.R (functions do not need to be in a file of the same name).  
  
quantmod:::getPrice will show you the source code from the R console.
<hr />
#### G$, quantmod:::getPrice is in the most recent Mac...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-06-04T13:21:19.077-05:00">Jun 5, 2010</time>

G$,  
  
quantmod:::getPrice is in the most recent MacOS X binary of quantmod on R-forge (I just looked). I have no idea what you could be doing wrong.
<hr />
#### Thanks Josh, I got it to work. There was an odd m...
[G$](https://www.blogger.com/profile/01349972242888715865 "noreply@blogger.com") - <time datetime="2010-06-10T12:01:52.327-05:00">Jun 4, 2010</time>

Thanks Josh, I got it to work. There was an odd masking going on I was able to clear out. It works beautifully.
<hr />
#### Zachary, I have the same problem. I can run the s...
[Unknown](https://www.blogger.com/profile/17087416729361204935 "noreply@blogger.com") - <time datetime="2010-07-31T15:33:02.950-05:00">Jul 6, 2010</time>

Zachary,  
I have the same problem. I can run the script once, but it fails on subsequent attempts because the portfolio already exists. One way I found to remedy the issue is to cleanup the workspace.  
  
\# Reset the workspace by deleting all variables and recreating  
\# the environment variables created during library load  
rm(list=ls(all=TRUE))  
.blotter <- new.env()  
.instrument <- new.env()  
  
\-Ben  
benmccann.com
<hr />
#### Another alternative for cleaning up the environmen...
[Unknown](https://www.blogger.com/profile/17087416729361204935 "noreply@blogger.com") - <time datetime="2010-08-16T19:25:07.661-05:00">Aug 2, 2010</time>

Another alternative for cleaning up the environment would be:  
rm(list=ls(all=TRUE, pos=.blotter), pos=.blotter)  
rm(list=ls(all=TRUE, pos=.instrument), pos=.instrument)
<hr />
#### Hi - I could use some help in getting the example ...
[SWAustinGuy](https://www.blogger.com/profile/02863487227658028225 "noreply@blogger.com") - <time datetime="2010-10-10T18:56:54.137-05:00">Oct 0, 2010</time>

Hi -  
I could use some help in getting the example 'longtrend' working in R-2.11.1, and the latest blotter, xts, quantmod, from R-forge (just updated all packages today).  
  
I'm running Win7 (but don't have to if it's an issue). The problem I am having is in updatePortf()  
I get the following error  
  
\[1\] "2001-04-30 IEF 578 @ 86.39"  
Symbol IEF Date: 988588800 TxnPrice 86.39 Qty 578  
Here  
  
Error in if (ncol(Prices) > 1) Prices = getPrice(prices, Symbol)\[dateRange\] :  
argument is of length zero  
  
It appears as if everything is working correctly except for the update to the portfolio. I've dumped my enironment, version info, code I am running (from example), error message, data frame for underlying symbol IEF, and the error I get when trying to manually add a transaction and update portfolio on the command line of 'R'.  
  
http://oeo.la/T2zHyC  
  
I'm very new to 'R', so I hope to have captured all relevant information and thank anyone in advance that might be able to steer me in the right direction.  
  
Great blog - Thanks allot for sharing this.
<hr />
#### Hmm, if I change the following line in updatePortf...
[SWAustinGuy](https://www.blogger.com/profile/02863487227658028225 "noreply@blogger.com") - <time datetime="2010-10-10T19:51:46.854-05:00">Oct 1, 2010</time>

Hmm, if I change the following line in updatePortf (Dates=..., the code runs much further, executing a few hundred trades, then failing.  
  
old:  
updatePortf(ltportfolio, Dates = CurrentDate)  
  
new:  
updatePortf(Portfolio='default', Dates=paste('::',as.Date(Sys.time()),sep=''))  
  
Then fails with:  
\[1\] "2007-05-31 IEF -611 @ 91.45"  
Error in \`\[.xts\`(sym, i, ) : subscript out of bounds  
  
Is the date thing an issue in Windows?
<hr />
#### SWAustinGuy, I've spoken with Brian and we be...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-10-11T11:29:12.396-05:00">Oct 1, 2010</time>

SWAustinGuy,  
  
I've spoken with Brian and we believe the error is in r411 of blotter and has been fixed in r412. But you didn't get the fix because the Windows binary of r412 has not been built on R-forge yet. Please try again once you see "Rev: 412" for blotter on [this page](https://r-forge.r-project.org/R/?group_id=316).  
  
Sorry for the trouble.
<hr />
#### Works fine on my linux slice but I noticed install...
[Unknown](https://www.blogger.com/profile/14106507531967201905 "noreply@blogger.com") - <time datetime="2010-11-06T18:25:28.032-05:00">Nov 6, 2010</time>

Works fine on my linux slice but I noticed install blotter is blowing up on my mac. - https://r-forge.r-project.org/R/?group\_id=316&log=build\_mac&pkg=FinancialInstrument&flavor=patched  
  
Just wanted to throw out a heads up.
<hr />
#### Ok, I can get the returns and see the actual data ...
[The Prolific Programmer](https://www.blogger.com/profile/09631681950518688098 "noreply@blogger.com") - <time datetime="2011-04-15T17:37:15.162-05:00">Apr 5, 2011</time>

Ok, I can get the returns and see the actual data structures. But the code crashes at the first chartSeries line. So, I tried looking at getAccount('default'), which looks like:  
  
\# from head(getAccount('default'))  
$portfolios  
$portfolios$default  
Long.Value Short.Value Net.Value Gross.Value Realized.PL  
2002-07-31 0.0 0 0.0 0.0 0.00  
2003-04-30 199951.3 0 199951.3 199951.3 0.00  
2003-05-30 208813.3 0 208813.3 208813.3 0.00  
2003-06-30 208558.1 0 208558.1 208558.1 0.00  
2003-07-31 108136.3 0 108136.3 108136.3 -3482.57  
2003-08-29 110366.7 0 110366.7 110366.7 0.00  
2003-09-30 212134.1 0 212134.1 212134.1 0.00  
2003-10-31 114566.4 0 114566.4 114566.4 -2376.06  
2003-11-28 115817.6 0 115817.6 115817.6 0.00  
2003-12-31 121072.6 0 121072.6 121072.6 0.00  
2004-01-30 123466.2 0 123466.2 123466.2 0.00  
2004-02-27 233925.2 0 233925.2 233925.2 0.00  
2004-03-31 232928.0 0 232928.0 232928.0 0.00  
2004-04-30 120724.5 0 120724.5 120724.5 -3990.90  
2004-05-28 122791.7 0 122791.7 122791.7 0.00  
2004-06-30 124608.6 0 124608.6 124608.6 0.00  
2004-07-30 0.0 0 0.0 0.0 20595.84  
2004-08-31 105362.5 0 105362.5 105362.5 0.00  
2004-09-30 105374.8 0 105374.8 105374.8 0.00  
2004-10-29 211374.7 0 211374.7 211374.7 0.00
<hr />
#### Second on Hasan's error - the whole script run...
[Elihu](https://www.blogger.com/profile/01969924423785517132 "noreply@blogger.com") - <time datetime="2011-08-31T00:04:00.295-05:00">Aug 3, 2011</time>

Second on Hasan's error - the whole script runs up until:  
  
"charts.PerformanceSummary(ROC(getAccount('default')$TOTAL$End.Eq)\[-1\],main="Tactical Asset Allocation")  
  
Then R throws "Error in dim(data) <- dim : attempt to set an attribute on NULL."  
  
I'm running R 2.13.1 (installed today) in RStudio, and I just ran the update.packages() script mentioned above.  
  
Thanks Josh for the great tutorial!
<hr />
#### Hasan and Elihu, Sorry for the extremely slow rep...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-09-25T12:28:55.475-05:00">Sep 0, 2011</time>

Hasan and Elihu,  
  
Sorry for the extremely slow reply. I've corrected the code to work with more recent versions of blotter. Also see the update at the top of the post.  
  
Best,  
Josh
<hr />
#### Thanks for the nice example, but there's diffe...
[segaa](https://www.blogger.com/profile/04233325205386980154 "noreply@blogger.com") - <time datetime="2011-10-31T20:49:23.914-05:00">Nov 2, 2011</time>

Thanks for the nice example, but there's differently an error in the calculations of return for tactical strategy, as an example here are several lines of results that I've got from the strategy:  
Date Symbol Size Price Change Total  
0 0 0 0 0 100000  
4/30/2003 IEF 578 86.39 49933.42 50066.58  
4/30/2003 SPY 544 91.91 49999.04 67.54  
7/31/2003 IEF -578 83.38 -48193.6 48261.18  
9/30/2003 IEF 597 86.59 51694.23 -3433.05  
10/31/2003 IEF -597 84.6 -50506.2 47073.15  
  
When second position opened in IEF on 9/30/2003 there's -3422.05 left at the account that suppose to never go below 0. I understand that we can borrow money on margin, but this is not the case for the strategy, and I see several instances in the results when buy made on margin. Probably because of that at the end of the last term the return if calculated manually is more like 17%, and not 22.7% as per the script result.  
Sorry, maybe I'm missing something, please point it if so. FYI, I'm using R version 2.13.2  
Thanks again for the great job!
<hr />
#### seega, I don't where you're getting those...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-11-01T20:45:13.735-05:00">Nov 3, 2011</time>

seega,  
  
I don't where you're getting those numbers. I just ran the script myself and cannot replicate what you've shown in your comment.
<hr />
#### Joshua, thanks a lot for your reply! My results ar...
[segaa](https://www.blogger.com/profile/04233325205386980154 "noreply@blogger.com") - <time datetime="2011-11-08T19:33:22.468-06:00">Nov 3, 2011</time>

Joshua, thanks a lot for your reply! My results are 100% reproducible to me. The code is similar to yours, I've just added the following 3 lines at the top, before loading the libraries, to make the code independent of the workspace:  
rm(list=ls(all=TRUE))  
if(!exists('.instrument')) .instrument <<- new.env(hash=TRUE)  
if(!exists('.blotter')) .blotter <<- new.env(hash=TRUE)  
As verbose = TRUE I can see the results of the strategy allocations in the console output, I've just ran it again and got the following:  
... SKIP ...  
\+ } # End dates loop  
\[1\] "2003-04-30 IEF 578 @ 86.39"  
\[1\] "2003-04-30 SPY 544 @ 91.91"  
\[1\] "2003-07-31 IEF -578 @ 83.38"  
\[1\] "2003-09-30 IEF 597 @ 86.59"  
\[1\] "2003-10-31 IEF -597 @ 84.6"  
\[1\] "2004-02-27 IEF 627 @ 86.68"  
\[1\] "2004-04-30 IEF -627 @ 83.5"  
... SKIP ...  
The generated PNG images are absolutely the same as in your post.  
If I understand correctly:  
1\. we've bought 578 shares of IEF on 2003-04-30 at $86.39 that leaves $50066.58 at our account unused.  
2\. than we've bot 544 shares of SPY at $91.91 that leaves us with $67.54 on account  
3\. on 2003—07-31 we've closed our IEF position with loss at $83.38 that leaves $48261.18 at our account  
4\. next, we are buying 597 shares of IEF at $86.59 that leaves us with minus $3433.05 etc.  
  
Maybe I'm misunderstanding something, please clarify. Thanks!
<hr />
#### The script itself says: "NOTE: For the purp...
[Brian G. Peterson](https://www.blogger.com/profile/09226525229201110236 "noreply@blogger.com") - <time datetime="2011-11-08T21:00:59.481-06:00">Nov 3, 2011</time>

The script itself says:  
  
"NOTE: For the purposes of this demo, we ignore interest and leverage."  
  
It doe \*not\* say "for the purposes of this demo, we use no leverage".  
  
In basically all institutional accounts and in many retail accounts, open equity is essentially equivalent to cash, and it would be fine to use the ending equity, including any open equity, to decide on the sizing of any new positions.  
  
In any event, patches are always welcome to extract available cash and use that instead (ending equity minus position values in a long-only portfolio, as I recall).
<hr />
#### Thanks a lot for the clarifications Brian!
[segaa](https://www.blogger.com/profile/04233325205386980154 "noreply@blogger.com") - <time datetime="2011-11-10T22:33:59.207-06:00">Nov 5, 2011</time>

Thanks a lot for the clarifications Brian!
<hr />
#### Hi. I'm not sure if I'm missing something...
[wywialm](https://www.blogger.com/profile/10839436531140017459 "noreply@blogger.com") - <time datetime="2012-04-10T05:34:55.395-05:00">Apr 2, 2012</time>

Hi.  
  
I'm not sure if I'm missing something, but I have no idea how to download the blotter package from r-forge project page. Is the package available for download and in case it is, could you give me a hint how to install it properly (preferably in R-2.15.0)  
  
Regards,  
Matt
<hr />
