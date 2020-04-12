---
title: 'Introduction to quantstrat'
date: 2011-08-12T06:48:00.001-05:00
draft: false
aliases: [ "/2011/08/introduction-to-quantstrat.html" ]
tags : [quantstrat]
---

#### Great idea, Josh. I'm looking forward to seein...
[Alexis Petit](https://www.blogger.com/profile/00745357782282599438 "noreply@blogger.com") - <time datetime="2011-08-12T08:48:13.212-05:00">Aug 5, 2011</time>

Great idea, Josh. I'm looking forward to seeing the next posts! I think this will help many of us make a better use of Quantstrat. Many thanks!
<hr />
#### package quantstrat is not available (for R version...
[Anonymous]( "noreply@blogger.com") - <time datetime="2011-08-17T09:23:49.119-05:00">Aug 3, 2011</time>

package quantstrat is not available (for R version 2.13.1)  
  
need manual compilation?  
  
  
Thank you for your work, really helpful!
<hr />
#### From windows: install.packages("quantstrat&q...
[FBSP](https://www.blogger.com/profile/16947684784224910950 "noreply@blogger.com") - <time datetime="2011-08-18T15:32:59.687-05:00">Aug 4, 2011</time>

From windows:  
  
install.packages("quantstrat", repos="http://R-Forge.R-project.org")  
Installing package(s) into ‘C:/Users/Res1/Documents/R/win-library/2.13’  
(as ‘lib’ is unspecified)  
Warning in install.packages :  
package ‘quantstrat’ is not available (for R version 2.13.1)  
  
What do I do?
<hr />
#### arippbbc and FBSP, There's some issue with R-...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-08-18T15:37:10.413-05:00">Aug 4, 2011</time>

arippbbc and FBSP,  
  
There's some issue with R-forge building quantstrat. We're working with the R-forge maintainers to find a solution.  
  
In the meantime, you can try some of the solutions in the [Windows packages](http://cran.r-project.org/doc/manuals/R-admin.html#Windows-packages) section of the R Installation and Administration manual (e.g. [win-builder](http://win-builder.r-project.org/)).
<hr />
#### After I setup my windows box to compile R packages...
[FBSP](https://www.blogger.com/profile/16947684784224910950 "noreply@blogger.com") - <time datetime="2011-08-18T18:04:05.435-05:00">Aug 4, 2011</time>

After I setup my windows box to compile R packages - using this link as a guide  
  
http://robjhyndman.com/researchtips/building-r-packages-for-windows/  
  
(I did have manually add R to my system path variable.)  
  
I was able to build blotter, FinancialInstrument, and quantstrat from source and and install it by following the directions on this post  
  
http://r.789695.n4.nabble.com/Package-quot-quantstrat-quot-td3599657.html#a3599994  
  
JU if you send me an email I will send you the package tar.gz files that were created.
<hr />
#### The Windows binary of quantstrat is now building o...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-08-19T09:50:15.953-05:00">Aug 5, 2011</time>

The Windows binary of quantstrat is now building on R-forge.
<hr />
#### FBSP's solution works for me.
[Ravi Aranke](https://www.blogger.com/profile/08706098376170260290 "noreply@blogger.com") - <time datetime="2011-08-22T02:20:06.093-05:00">Aug 1, 2011</time>

FBSP's solution works for me.
<hr />
#### Try this: http://www.programmingr.com/content/ins...
[loc](https://www.blogger.com/profile/02759975199242151968 "noreply@blogger.com") - <time datetime="2012-11-02T12:16:37.568-05:00">Nov 5, 2012</time>

Try this:  
  
http://www.programmingr.com/content/installing-quantstrat-r-forge-and-source/
<hr />
#### Hi all, I'm very new to R but looking at getti...
[Novice Pete](https://www.blogger.com/profile/01994166450043437420 "noreply@blogger.com") - <time datetime="2012-12-21T05:42:14.510-06:00">Dec 5, 2012</time>

Hi all,  
I'm very new to R but looking at getting the Quantstrat package but i can't manage /don't understand the method outlined above, can anyone either explain it in layman/idiot terms or provide an alternative solution?  
Regards  
Pete
<hr />
#### Just to let people know I have downloaded rtools b...
[Novice Pete](https://www.blogger.com/profile/01994166450043437420 "noreply@blogger.com") - <time datetime="2012-12-21T06:02:13.631-06:00">Dec 5, 2012</time>

Just to let people know I have downloaded rtools but i didn't understand the next instructions regarding path setup in the links provided.  
Regards  
Pete
<hr />
#### Hi Pete,
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2012-12-22T14:55:12.962-06:00">Dec 6, 2012</time>

Hi Pete,  
  
[Garrett See](http://stackoverflow.com/users/967840/gsee) has a nice answer on stackoverflow about how to [build R-Forge packages from source](http://stackoverflow.com/a/11105132/271616).
<hr />
#### Hi Nice post, very helpful with demos and exampl...
[Morten](https://www.blogger.com/profile/00983129499523210138 "noreply@blogger.com") - <time datetime="2012-12-23T15:04:43.884-06:00">Dec 0, 2012</time>

Hi  
  
Nice post, very helpful with demos and examples, thanks.  
  
I tried running the example code directly from the post without any changing anything and I got the result that no trades were generated in:  
  
updatePortf("faber")  
  
although the Cl.gt.SMA and Cl.lt.SMA changed several times  
between 0/1 in the out variable:  
  
out <- try(applyStrategy(strategy=stratFaber, portfolios="faber"))  
  
I'm running  
R version 2.15.2 from Rstudio  
PerformanceAnalytics 1.0.4.4  
quantstrat 0.7.7  
blotter 0.8.13  
  
Am I missing somthing, or does the example simply not work  
on newer versions?  
  
KR Morten
<hr />
