---
title: 'How to backtest a strategy in R'
date: 2011-03-26T09:54:00.001-05:00
draft: false
aliases: [ "/2011/03/how-to-backtest-strategy-in-r.html" ]
tags : [Examples, Excel, R]
---

#### Thanks for the tutorial. However, when I ran it, ...
[Leo](https://www.blogger.com/profile/04413561053921603448 "noreply@blogger.com") - <time datetime="2011-03-26T11:00:12.638-05:00">Mar 6, 2011</time>

Thanks for the tutorial.  
  
However, when I ran it, I got this error:  
  
Error: could not find function "DVI"
<hr />
#### I can't seem to get the DVI indicator out of T...
[Unknown](https://www.blogger.com/profile/17305384425953877966 "noreply@blogger.com") - <time datetime="2011-03-26T14:47:22.856-05:00">Mar 6, 2011</time>

I can't seem to get the DVI indicator out of TTR. I've tried installing the package from CRAN, using install.packages('TTR',dependencies=TRUE) and from r-forge, using install.packages("TTR",repos="http://r-forge.r-project.org"). In both cases it installs fine, and other indicators work, but there's no DVI indicator.  
  
Thank you!
<hr />
#### By the way, CRAN installs 'TTR\_0.20-2.tgz'...
[Unknown](https://www.blogger.com/profile/17305384425953877966 "noreply@blogger.com") - <time datetime="2011-03-26T14:49:00.984-05:00">Mar 6, 2011</time>

By the way, CRAN installs 'TTR\_0.20-2.tgz' and R-forge installs 'TTR\_0.20-3.tgz'
<hr />
#### HMmm, ok I removed TTR and re-installed from R-For...
[Unknown](https://www.blogger.com/profile/17305384425953877966 "noreply@blogger.com") - <time datetime="2011-03-26T14:59:41.976-05:00">Mar 6, 2011</time>

HMmm, ok I removed TTR and re-installed from R-Forge. Now I get this error when I try to start it:  
  
"Loading required package: xts  
Loading required package: zoo  
Error in dyn.load(file, DLLpath = DLLpath, ...) :  
unable to load shared object '/Library/Frameworks/R.framework/Versions/2.12/Resources/library/TTR/libs/x86\_64/TTR.so':  
dlopen(/Library/Frameworks/R.framework/Versions/2.12/Resources/library/TTR/libs/x86\_64/TTR.so, 6): Library not loaded: /usr/local/lib/libgfortran.2.dylib  
Referenced from: /Library/Frameworks/R.framework/Versions/2.12/Resources/library/TTR/libs/x86\_64/TTR.so  
Reason: image not found  
Error: package/namespace load failed for 'TTR'"  
  
I'm on a mac, if that helps
<hr />
#### I installed the Fortran compilers for the mac (htt...
[Unknown](https://www.blogger.com/profile/17305384425953877966 "noreply@blogger.com") - <time datetime="2011-03-26T15:24:06.581-05:00">Mar 6, 2011</time>

I installed the Fortran compilers for the mac (http://r.research.att.com/gfortran-4.2.3.dmg) and the installation works. Weirdly, when I type ?DVI I see the help page for it, but I can't actually access the function. If you have any advice, I'd appreciate it, otherwise I'll just keep banging away at this on my own.
<hr />
#### Hi Zachary, CRAN houses the stable version of TTR...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-03-26T15:31:13.480-05:00">Mar 6, 2011</time>

Hi Zachary,  
  
CRAN houses the stable version of TTR, while R-forge contains the latest development versions.  
  
The reason you can see ?DVI but can't use it is because I forgot to export DVI. I exported it last night, but the daily builds haven't run on my latest changes yet. You have a couple options. You can replace "TTR:::DVI" instead of "DVI", checkout the latest revision and build from source, or wait until the daily builds complete.
<hr />
#### Thanks Josh! Sorry to clog your comments-- I didn...
[Unknown](https://www.blogger.com/profile/17305384425953877966 "noreply@blogger.com") - <time datetime="2011-03-26T15:43:29.033-05:00">Mar 6, 2011</time>

Thanks Josh! Sorry to clog your comments-- I didn't realize until a minute ago that you were also the package maintainer.
<hr />
#### R seems like a good choice if you're just back...
[Kvantitativ Analys](https://www.blogger.com/profile/15672740610798723186 "noreply@blogger.com") - <time datetime="2011-03-27T07:40:26.122-05:00">Mar 0, 2011</time>

R seems like a good choice if you're just backtesting standard indicators. But why would i use it over Excel for proprietary indicators? The main reason why I use Excel is because it's easy to test any idea without much limitation.  
  
How about computing power? My problem with Excel is that when the ideas get more complex the computing speed gets insufficient. For example computing a RSI(2) strategy 100 000 times takes a looooong time. How much faster is R?  
  
Thanks for a great blog!
<hr />
#### Re: Kvantitativ Analys You could always code your...
[Dekalog](https://www.blogger.com/profile/07016889838486083128 "noreply@blogger.com") - <time datetime="2011-03-27T10:13:09.509-05:00">Mar 0, 2011</time>

Re: Kvantitativ Analys  
  
You could always code your proprietary indicators in R; I think you will find things much quicker than if you stuck with Excel. It was my disappointment with Excel in this regard that prompted me to move to a combination of Octave and R.
<hr />
#### Kvantitativ Analys, You can create proprietary in...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-03-27T12:04:50.084-05:00">Mar 0, 2011</time>

Kvantitativ Analys,  
  
You can create proprietary indicators in R just like you can in Excel. The TTR package provides all the source code for the indicators in it. You can use those as templates for your proprietary indicators.  
  
It's difficult to discuss relative performance in vague terms like this. My intuition is that R would be faster, but it's impossible to say "how much faster" without a specific example. You can always move the slowest parts to compiled code, which is much easier to do in R than Excel (even via [XLW](http://xlw.sourceforge.net)).
<hr />
#### Hi. this article is very interesting! I would like...
[teramonagi](https://www.blogger.com/profile/01575109508540462223 "noreply@blogger.com") - <time datetime="2011-03-27T19:10:29.504-05:00">Mar 1, 2011</time>

Hi.  
this article is very interesting!  
I would like to translate this into Japanese.  
do you allow me to do that?
<hr />
#### Joshua Thanks for the post. I am teaching a Cours...
[Unknown](https://www.blogger.com/profile/02962683981357650944 "noreply@blogger.com") - <time datetime="2011-03-28T07:59:46.286-05:00">Mar 1, 2011</time>

Joshua  
  
Thanks for the post. I am teaching a Course in Financial Modeling with R. I use some of the packages that you and Jeff Ryan have authored. Thanks for that.  
  
I'd be glad if you could direct me to other resources like this your blog.  
Thanks
<hr />
#### jscn, you probably had the same issue as Zachary. ...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-03-28T13:39:25.418-05:00">Mar 1, 2011</time>

jscn, you probably had the same issue as Zachary. Try [re-installing TTR from R-forge](https://r-forge.r-project.org/R/?group_id=119).  
  
teramonagi, you're welcome to translate this post (and any others) to Japanese. Just please give me credit. ;-)  
  
Subhash, you're welcome. I'm glad you've found our work helpful. I don't know of any resources other than what's in my blogroll. You may find [RMetrics suite](https://www.rmetrics.org/) helpful too.
<hr />
#### Subhas - is it possible to put the link to the cou...
[vedaranyam](https://www.blogger.com/profile/01594148861784553759 "noreply@blogger.com") - <time datetime="2011-03-28T20:01:29.952-05:00">Mar 2, 2011</time>

Subhas - is it possible to put the link to the course that you are teaching ?
<hr />
#### The signal vector is quite elegant. I see you can ...
[Milk Trader](https://www.blogger.com/profile/15008769973064875700 "noreply@blogger.com") - <time datetime="2011-03-30T21:54:37.050-05:00">Mar 4, 2011</time>

The signal vector is quite elegant. I see you can take three positions(long, short, flat) by simply nesting the ifelse statement.  
  
To my fellow Mac R users, I can attest that I have downloaded TTR\_0.20-3.tar.gz from https://r-forge.r-project.org/src/contrib/ and after navigating to my ~/Downloads directory, the simple command of R CMD INSTALL TTR\_0.20-3.tar.gz from command line did the trick of installing the latest/greatest TTR, complete with DVI. (You do need XCode that the ATT Fortran compiler (found at http://r.research.att.com/tools/) installed)
<hr />
#### Joshua, do you also have an example of how to imp...
[Unknown](https://www.blogger.com/profile/11872475939362362657 "noreply@blogger.com") - <time datetime="2011-04-03T07:48:02.637-05:00">Apr 0, 2011</time>

Joshua,  
  
do you also have an example of how to implement pending orders (stop loss orders, for example), and scaling positions in and out, using ifelse()?  
That is, how to implement trading decisions that depend on trade and equity history over a certain past period, and trades that are triggered at a certain price? Example: Open a position with attached stop loss order according to some entry criterium, open another position not before the first one is in the positive, and so on until a certain position size is reached. Then scale a part of the position out and build the position up again as above.  
Now, while such strategies can be implemented fairly easily using nested for-loops and the like, doing so would make backtests far too slow. I'm looking for ways to code it in a vectorized way, such as by using the ifelse() construct. I would be grateful for any suggestions.
<hr />
#### Heikolino, You can't implement path-dependent...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-04-03T19:19:26.374-05:00">Apr 1, 2011</time>

Heikolino,  
  
You can't implement path-dependent rules with simple ifelse() function calls. Much of what you want to do can be accomplished with the [quantstrat](https://r-forge.r-project.org/R/?group_id=316) package. I plan to write an "Introduction to quantstrat" post in the near future.
<hr />
#### I noticed that the ROC() function is very similar ...
[Milk Trader](https://www.blogger.com/profile/15008769973064875700 "noreply@blogger.com") - <time datetime="2011-04-05T07:45:46.889-05:00">Apr 2, 2011</time>

I noticed that the ROC() function is very similar to quantmod::Delt and quantmod::dailyReturn except that you can select a discrete calculation (which returns values corresponding to the other quantmod functions) or you can select continuous, which is the default value. Can you explain why you chose to make this distinction and why you chose to use type="continuous" to calculate your returns?
<hr />
#### Milk Trader, The distinction is between continuou...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-04-06T21:02:42.472-05:00">Apr 4, 2011</time>

Milk Trader,  
  
The distinction is between continuous compounding and discrete compounding. I made "continuous" the default because that's what I was using in my research when I originally wrote the package in 2006.
<hr />
#### Great tutorial, thank you for taking the time!
[Unknown](https://www.blogger.com/profile/17855891153066164224 "noreply@blogger.com") - <time datetime="2011-04-06T21:59:54.730-05:00">Apr 4, 2011</time>

Great tutorial, thank you for taking the time!
<hr />
#### I'm confused by the equity calculation: eq <...
[eric](https://www.blogger.com/profile/00400272011379365065 "noreply@blogger.com") - <time datetime="2011-05-08T20:57:39.638-05:00">May 1, 2011</time>

I'm confused by the equity calculation: eq <- cumprod(1+ret).  
  
Since ret is based on ROC and the default is continuous (log) returns, then wouldn't eq = exp(cumsum(ret)) ?
<hr />
#### Eric, you are correct.
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-05-15T17:54:22.319-05:00">May 0, 2011</time>

Eric, you are correct.
<hr />
#### Thanks for the post, it's excellent. One ques...
[Unknown](https://www.blogger.com/profile/06210501108238408315 "noreply@blogger.com") - <time datetime="2011-05-17T17:22:23.791-05:00">May 2, 2011</time>

Thanks for the post, it's excellent.  
  
One question: when you say the signal is lagged, that means we have to apply the +/-1 signal for the next day, correct? Otherwise we would get a signal when all information is known. Am I missing something here? I am new to the subject (although eager to learn).  
  
Cheers!
<hr />
#### Mateo, You're correct. If we use today's...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-05-17T21:24:00.989-05:00">May 3, 2011</time>

Mateo,  
  
You're correct. If we use today's data to determine the signal, we would be snooping/peeking if we applied that signal to today's return. We lag the signal so it will be applied to tomorrow's return.
<hr />
#### 
[E](https://www.blogger.com/profile/13232084148754603978 "noreply@blogger.com") - <time datetime="2012-01-14T03:01:38.385-06:00">Jan 6, 2012</time>

This comment has been removed by the author.
<hr />
#### Thank you for the great tutorial. I'm fresh t...
[Juan L.P.](https://www.blogger.com/profile/05952396114208448372 "noreply@blogger.com") - <time datetime="2012-01-16T21:23:19.084-06:00">Jan 2, 2012</time>

Thank you for the great tutorial.  
  
I'm fresh to trading yet find this easy to follow.  
  
The only question I have is why in step 4, we evaluated the cumsum and then exp it? I get the cumsum but am not sure about the exp.  
  
Thank you.
<hr />
#### Hi Juan, I'm glad you found this post helpful...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2012-01-17T10:53:56.336-06:00">Jan 2, 2012</time>

Hi Juan,  
  
I'm glad you found this post helpful.  
  
The _cumsum_ function calculates the cumulative return at each point in time. But we want the equity value at each point in time. The call to _exp_ gives us the equity value (in effect, compounding the returns).  
  
See Pat Burns' [A tale of two returns](http://www.portfolioprobe.com/2010/10/04/a-tale-of-two-returns/) for a good comparison between arithmetic and log returns.
<hr />
#### I'm new to R, and I'm hoping someone can p...
[Dave](https://www.blogger.com/profile/00308481708219076602 "noreply@blogger.com") - <time datetime="2012-01-26T19:00:32.697-06:00">Jan 5, 2012</time>

I'm new to R, and I'm hoping someone can provide some pointers on three backtest topics:  
  
1\. I currently trade two rotational strategies (one weekly and one monthly) that use two moving averages and volatility to produce a rank for each of the 10 ETFs in my portfolio. Based on the rank, the top three ETFs are chosen. I've seen the rotational system on the Systematic Investor blog, but was wondering how to do this with quantstrat.  
  
2\. Are there any R packages that provide the capability to create a database of stock history from Yahoo, and then update this DB nightly? As the number of symbols that I'm following grows, the response from my getSymbols calls are taking longer.  
  
3\. Are there any R packages that provide the capability to append the current/intraday stock price to an xts dataseries resulting from a getSymbols call? I enter MOC orders with both of my rotational systems and I use the stock price about 30 minutes from the close to generate my signals.  
  
Thanks in advance,  
Dave
<hr />
#### Hi Dave, 1) Those types of rotational momentum st...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2012-02-02T21:22:07.467-06:00">Feb 5, 2012</time>

Hi Dave,  
  
1) Those types of rotational momentum strategies are very simple, so I would be inclined to run it without quantstrat. I'll ping Brian about how to go about doing it with quantstrat though.  
  
2) I wouldn't use a database. Pull the data you need and write it to a binary R file using save(). For daily data, you could easily store data for hundreds of symbols in one file. When you want to update the data, just pull the days you don't have and append it to the saved objects (see 3).  
  
3) Just use quantmod and xts. quantmod::getQuote will get the "current" (delayed) quote. Then you just have to xts::rbind it to your xts object that contains the historical data.
<hr />
#### We liked quantmod so much we extended support for ...
[jf](https://www.blogger.com/profile/01659463232609884552 "noreply@blogger.com") - <time datetime="2012-03-06T11:20:00.153-06:00">Mar 2, 2012</time>

We liked quantmod so much we extended support for live trading quantmod strategies through another open source platform tradelink :  
  
http://tradelink.org  
  
http://www.pracplay.com/landings/bridge\_r
<hr />
#### Joshua, I am new to R. How may we place other auto...
[Simon](https://www.blogger.com/profile/10096229250338640573 "noreply@blogger.com") - <time datetime="2012-05-15T14:47:52.822-05:00">May 2, 2012</time>

Joshua,  
I am new to R. How may we place other automatically using R with e.g. TD trade or etrade? Or it all depends on the API with different brokerage firms.  
Simon
<hr />
#### Chris, That is completely dependent on the API pr...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2012-05-16T09:22:39.695-05:00">May 3, 2012</time>

Chris,  
  
That is completely dependent on the API provided by the specific firm and whether or not someone has built R functions to interact with the API.
<hr />
#### Hi Joshua, Very Eye opening post. I have the same ...
[Unknown](https://www.blogger.com/profile/04163571652269649900 "noreply@blogger.com") - <time datetime="2012-05-29T20:59:42.401-05:00">May 3, 2012</time>

Hi Joshua, Very Eye opening post. I have the same  
questions as Dave. I wish to develop my own  
portfolio backtesting system using R.  
Where should I start.  
Also How do I get traditional metrics like sharpe ratio etc from the performanceAnalytics pkg.  
Lastly are there good manuals for the quant\* pkgs.
<hr />
#### Interesting. Never knew about TRR software.
[CandleForex](https://www.blogger.com/profile/03266676843350873704 "noreply@blogger.com") - <time datetime="2012-06-14T15:17:15.803-05:00">Jun 4, 2012</time>

Interesting. Never knew about TRR software.
<hr />
#### 
[Sean Fallon](https://www.blogger.com/profile/10274154538741102907 "noreply@blogger.com") - <time datetime="2012-09-02T13:01:50.134-05:00">Sep 0, 2012</time>

This comment has been removed by the author.
<hr />
#### Am new to R and still learning. I hit a error when...
[Sean Fallon](https://www.blogger.com/profile/10274154538741102907 "noreply@blogger.com") - <time datetime="2012-09-02T13:05:39.826-05:00">Sep 0, 2012</time>

Am new to R and still learning. I hit a error when I came to table.Drawdowns(ret, top=10). It said - "Error in dimnames(cd) <- list(as.character(index(x)), colnames(x)) : 'dimnames' applied to non-array". Quantmod and PerformanceAnalytics are both loaded. Am I missing something??
<hr />
#### Silly me?? :p missed two lines of code in between....
[Sean Fallon](https://www.blogger.com/profile/10274154538741102907 "noreply@blogger.com") - <time datetime="2012-09-02T13:12:42.657-05:00">Sep 0, 2012</time>

Silly me?? :p missed two lines of code in between. Apologies. Its working now.
<hr />
#### Hello, A noob question for an excellent post. I ...
[Unknown](https://www.blogger.com/profile/07503073135154680800 "noreply@blogger.com") - <time datetime="2012-10-15T20:19:46.498-05:00">Oct 2, 2012</time>

Hello,  
  
A noob question for an excellent post.  
  
I replaced the dvi signal with an sma signal from ttr.  
  
After replacement, I replaced dvi$dvi with sma$sma in the signal generation line.  
  
I see the following error:  
  
Error in \`$.zoo\`(sma, sma) :  
only possible for zoo series with column names  
  
Regards  
Bapi
<hr />
#### Hi Bapi, The _DVI_ function returns an objec...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2012-10-16T07:09:37.498-05:00">Oct 2, 2012</time>

Hi Bapi,  
  
The _DVI_ function returns an object with 3 columns, named dvi.mag, dvi.str, and dvi. The _SMA_ function only returns one (unnamed) column.  
  
You can use this code if you want to name the one column of the _SMA_ output:  
  
_sma <- setNames(SMA(Cl(GSPC)), "sma")_  
  
Best,  
Joshua
<hr />
#### Joshua, Thank you. Bapi
[Unknown](https://www.blogger.com/profile/07503073135154680800 "noreply@blogger.com") - <time datetime="2012-10-16T15:27:25.453-05:00">Oct 2, 2012</time>

Joshua,  
  
Thank you.  
  
Bapi
<hr />
#### Hey Joshua, Fantastic blog! I really enjoy readin...
[Graeme Walsh](https://www.blogger.com/profile/00560606945089457912 "noreply@blogger.com") - <time datetime="2012-12-09T06:29:24.394-06:00">Dec 0, 2012</time>

Hey Joshua,  
  
Fantastic blog! I really enjoy reading your posts.  
  
In this post I think I may have picked up on a slight error (not in the code, though!).  
  
In the text you say: "we're long 100% if the DVI is below 0.5 and short 100% otherwise"  
  
and then you go on to say: "create signal: (long (short) if DVI is above (below) 0.5)"  
  
In the first case you say that we're long if the DVI is below 0.5, but in the second case you say that we're long if the DVI is above 0.5!  
  
Maybe you could iron out this typo to avoid confusion?  
  
Cheers,  
GW
<hr />
#### Graeme, The copy is correct and the code comment ...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2012-12-11T21:30:12.169-06:00">Dec 3, 2012</time>

Graeme,  
  
The copy is correct and the code comment is wrong. I've now corrected the comment to align with the copy. Thanks for catching this typo!
<hr />
#### Thanks for this info. Coming from Excel, and compl...
[XE X X](https://www.blogger.com/profile/14352396361854952358 "noreply@blogger.com") - <time datetime="2013-05-23T20:08:54.079-05:00">May 5, 2013</time>

Thanks for this info. Coming from Excel, and completely new to R. Is there a way to see what each line does? Like in your lag(), can we see what arguments lag takes and what output it has?
<hr />
