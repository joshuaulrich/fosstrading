---
title: 'Tactical asset allocation using quantstrat'
date: 2011-08-23T20:55:00.000-05:00
draft: false
aliases: [ "/2011/08/tactical-asset-allocation-using.html" ]
tags : [Examples, Code, quantstrat]
---

#### I am trying to run this script in R-Studio on OSX ...
[Lemao](https://www.blogger.com/profile/07616720150048806049 "noreply@blogger.com") - <time datetime="2011-08-30T09:45:10.080-05:00">Aug 2, 2011</time>

I am trying to run this script in R-Studio on OSX but I am getting the following error:  
  
\> currency("USD")  
Error in assign(primary\_id, currency\_temp, envir = as.environment(.instrument)) :  
object '.instrument' not found  
  
I have installed the dependencies: zoo, xts, TTR, RTAQ, quantstrat, quantmod, Performanceanalytics, FInancialInstrument, Defaults and blotter.  
  
Any ideas of what is going wrong here? (note I am new to R)
<hr />
#### I looked at the sources and found out that .instru...
[Lemao](https://www.blogger.com/profile/07616720150048806049 "noreply@blogger.com") - <time datetime="2011-08-30T11:34:53.133-05:00">Aug 2, 2011</time>

I looked at the sources and found out that .instrument is initialized when the package namespace is loaded. The issue is that I clicked on Workspace->Clear All clears it in RStudio, which wiped out everything including this variable.  
  
As I said, I am new to R, but I am curious as to whether this initialization indeed be done on package load?
<hr />
#### \> install.packages(c("quantstrat",&qu...
[Steve](https://www.blogger.com/profile/10825602317727902499 "noreply@blogger.com") - <time datetime="2011-08-31T12:19:38.651-05:00">Aug 3, 2011</time>

\> install.packages(c("quantstrat","blotter","FinancialInstrument"), repos="http://r-forge.r-project.org")  
Installing package(s) into (... )  
trying URL 'http://r-forge.r-project.org/bin/windows/contrib/2.13/quantstrat\_0.5.2.zip'  
Error in download.file(url, destfile, method, mode = "wb", ...) :  
cannot open URL 'http://r-forge.r-project.org/bin/windows/contrib/2.13/quantstrat\_0.5.2.zip'  
In addition: Warning message:  
In download.file(url, destfile, method, mode = "wb", ...) :  
cannot open: HTTP status was '404 Not Found'  
Warning in download.packages(pkgs, destdir = tmpd, available = available, :  
download of package 'quantstrat' failed (... )
<hr />
#### But it's working today... > install.packag...
[Steve](https://www.blogger.com/profile/10825602317727902499 "noreply@blogger.com") - <time datetime="2011-09-01T11:26:10.518-05:00">Sep 4, 2011</time>

But it's working today...  
  
\> install.packages(c("quantstrat","blotter","FinancialInstrument"),repos="http://r-forge.r-project.org")  
(... )  
package 'quantstrat' successfully  
(... )
<hr />
#### Lemao: You need an instrument environment to stor...
[Brian G. Peterson](https://www.blogger.com/profile/09226525229201110236 "noreply@blogger.com") - <time datetime="2011-09-08T07:54:23.853-05:00">Sep 4, 2011</time>

Lemao: You need an instrument environment to store instrument metadata. When the FinancialInstrument package loads, it will create this environment for you.  
  
Generally speaking, it's a really bad idea to clear out everything in a workspace, as you can lose important things along with all the junk. Generally accepted 'best practices' in R are to create a new workspace for each project you are working on, so that you can store history, state, working variables, etc separately for each project.
<hr />
#### Change last line to: tradeStats("faber"...
[Speaking Freely](https://www.blogger.com/profile/02075177917535713296 "noreply@blogger.com") - <time datetime="2012-08-24T13:54:40.983-05:00">Aug 5, 2012</time>

Change last line to:  
  
tradeStats("faber")\[c("Symbol","Num.Trades","Net.Trading.PL","Max.Drawdown")\]  
  
Max.Drawdown instead of maxDrawdown
<hr />
#### Hi, thanks for the post. I am somewhat new to R an...
[Mikkel](https://www.blogger.com/profile/02161911698646320961 "noreply@blogger.com") - <time datetime="2012-09-05T03:06:59.658-05:00">Sep 3, 2012</time>

Hi, thanks for the post. I am somewhat new to R and I also use Rapidminer which I am also pretty new at.  
  
I have a large dataset of historical prices which I did not pull from yahoo, but it looks somewhat similar in setup. I have calculated and selected some indicators which I have added to my dataset and want to test a strategy with the quantstrat package.  
  
When you add the indicator I am not sure I understand the arguments variable. What is going on there, could I add my already calculated indicator by typing something like?  
  
stratFaber <- add.indicator(strategy=stratFaber, name="SMA", arguments=list(data$SMA10)  
)  
  
Thanks, Mikkel
<hr />
#### Mikkel, **arguments** should be a named list t...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2012-09-06T16:57:22.536-05:00">Sep 4, 2012</time>

Mikkel,  
  
**arguments** should be a named list to be passed to the function given via the **name** argument. Note in the example **arguments=list(x=quote(Cl(mktdata)), n=10)** provides the two arguments to the **SMA** function. **x** is quoted to delay evaluation (since **mktdata** only exists inside of **applyStrategy**.  
  
You generally don't add previously-calculated indicators to strategy objects. It defeats the purpose of the strategy being able to run on multiple sets of data. Instead, specify your custom function as the **name** argument to **add.indicator** and pass any relevant arguments to it via the **arguments** argument.  
  
Best,  
Josh
<hr />
#### Thank you Josh, I understand it now, pretty smart ...
[Mikkel](https://www.blogger.com/profile/02161911698646320961 "noreply@blogger.com") - <time datetime="2012-09-11T04:13:40.368-05:00">Sep 2, 2012</time>

Thank you Josh, I understand it now, pretty smart that I can create any function to use as an indicator. I like the flexibility of R, but the learning curve can be pretty steep sometimes.  
  
I am running through this example to try to learn the quantstrat package. Everything runs fine in R, except when I replace the data from yahoo with my own dataset.  
  
I use this to initiate my dataset to R  
  
SBO <-read.csv("C:/......./MABODay.csv", header=T)  
  
SBO <-xts(SBO\[,-1\],as.Date(SBO\[,1\],"%Y/%m/%d"))  
  
Dataset is then consisted of  
  
\- Open High Low Close Volume  
YYYY-mm-dd nr nr nr nr nr  
  
Then I skip the steps where you pull data from yahoo, adjust for dividends and convert it to monthly. I wanted a 10 day SMA instead.  
  
When I setup the currency I use  
\# Set symbols  
symbols <- c("SBO")  
  
\# Set up instruments with FinancialInstruments package  
currency("USc/Lbs")  
for(symbol in symbols) {  
stock(symbol, currency="USc/Lbs", multiplier=1)  
}  
  
everything from then on is pretty much copy paste from your example.  
  
When I run  
  
out <- try(applyStrategy(strategy=stratSBO, portfolios="mySBO"))  
updatePortf("mySBO")  
  
I get the error  
  
Error in if ((orderqty + pos) < PosLimit\[, "MaxPos"\]) { :  
argument is of length zero  
  
and  
  
Error in if (length(c(year, month, day, hour, min, sec)) == 6 && c(year, :  
missing value where TRUE/FALSE needed  
In addition: Warning message:  
In as\_numeric(YYYY) : NAs introduced by coercion  
  
I interpret the first error maybe because no orders were placed?  
  
Second warning something with the date. NA values on time maybe?  
  
I just want to learn and I don't expect you to give me a finished code that I can copy paste, but if you can point me in the right direction?  
  
Thanks a lot  
  
Best Regards  
Mikkel
<hr />
#### Hi again Just want to mention that I solved my er...
[Mikkel](https://www.blogger.com/profile/02161911698646320961 "noreply@blogger.com") - <time datetime="2012-09-12T07:26:45.896-05:00">Sep 3, 2012</time>

Hi again  
  
Just want to mention that I solved my errors. The first error was simply a typo on my part in the date.  
  
The second error I reinstalled blotter and it worked.  
  
Now everything works like a charm.  
  
Thanks  
  
Best Regards  
Mikkel
<hr />
