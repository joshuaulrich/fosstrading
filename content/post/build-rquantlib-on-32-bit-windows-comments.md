---
title: 'Build RQuantLib on 32-bit Windows'
date: 2010-12-07T17:20:00.006-06:00
draft: false
aliases: [ "/2010/12/build-rquantlib-on-32-bit-windows.html" ]
tags : [R]
---

#### Hi Thanks for posting your guidelines, I have trie...
[Unknown](https://www.blogger.com/profile/14256968442010917749 "noreply@blogger.com") - <time datetime="2011-03-20T10:19:58.587-05:00">Mar 0, 2011</time>

Hi Thanks for posting your guidelines, I have tried it on a 64bit machine, it seems to be working upto step 11. I'm not sure where I am supposed to be entering these last commands. I entered "set QUANTLIB\_ROOT=c:/R/cpp/QuantLibBuild" via a dos prompt and created the environment varable QUANTLIB\_ROOT. The last command "R CMD INSTALL RQuantLib\_0.3.4.tar.gz" doesn't seem to be recognised anywhere. I have tried to enter it into the R commnad line only to be told there is an unexpected symbol. Obviously I am doing something wrong? ANy ideas.  
  
Thanks  
  
  
  
11.Now you should be able to build RQuantLib via  
set QUANTLIB\_ROOT=c:/R/cpp/QuantLibBuild  
R CMD INSTALL RQuantLib\_0.3.4.tar.gz
<hr />
#### Hi Jon, It sounds like your PATH variable doesn&#...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-03-20T10:28:16.922-05:00">Mar 0, 2011</time>

Hi Jon,  
  
It sounds like your PATH variable doesn't include the locations for Rtools as specified in [The Windows Toolset](http://cran.r-project.org/doc/manuals/R-admin.html#The-Windows-toolset) section of the [R Installation and Administration](http://cran.r-project.org/doc/manuals/R-admin.html) manual. Is that the issue?
<hr />
#### Hi - I tried building it again with the path of Rt...
[Unknown](https://www.blogger.com/profile/14256968442010917749 "noreply@blogger.com") - <time datetime="2011-03-20T14:02:44.224-05:00">Mar 0, 2011</time>

Hi - I tried building it again with the path of Rtools set correctly, the problem I am getting is with the utils package I think.  
  
\>R CMD INSTALL RQuantLib\_0.3.6.tar.gz  
Error: unexpected symbol in "R CMD"  
  
although I've tried loading the utils package several times it doesn't seem to recognize the command?
<hr />
#### "R CMD" is a command line function, not ...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-03-20T14:30:18.304-05:00">Mar 0, 2011</time>

"R CMD" is a command line function, not an R function. Try running it from a command prompt.
<hr />
#### Hi Joshua, you instruction number 5 is not working...
[Bogaso](https://www.blogger.com/profile/10727798143229284358 "noreply@blogger.com") - <time datetime="2011-03-22T09:10:43.935-05:00">Mar 2, 2011</time>

Hi Joshua, you instruction number 5 is not working in my vista machine. I have written:  
  
"configure --with-boost-include=c:/R/cpp/boost\_1\_42\_0 --prefix=c:/R/cpp"  
  
However I am getting error as "'configure' is not recognized as an internal or external command, operable program or batch file". Would you please tell me what to do with this error?
<hr />
#### Bogaso, it looks like you tried to run that from a...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-03-22T21:22:30.732-05:00">Mar 3, 2011</time>

Bogaso, it looks like you tried to run that from a Windows command line instead of the msys command line.  
  
Tomorrow I will try to build a Windows binary and provide a link to it in the original post.
<hr />
#### I did try your instructions step-by-step but when ...
[س](https://www.blogger.com/profile/15424454826905342786 "noreply@blogger.com") - <time datetime="2011-03-28T20:54:33.985-05:00">Mar 2, 2011</time>

I did try your instructions step-by-step but when I install the package using (R CMD INSTALL) I get the following message at the end of compilation process:  
  
"This application has requested the Runtime to terminate it in an unusual way.  
Please contact the application's support team for more information.  
ERROR  
Installation failed"  
  
Any suggestion?
<hr />
#### What do you get when you run R CMD check?
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-03-29T00:38:45.456-05:00">Mar 2, 2011</time>

What do you get when you run R CMD check?
<hr />
#### Hi, This is an excerpt from 00intstall.out produce...
[س](https://www.blogger.com/profile/15424454826905342786 "noreply@blogger.com") - <time datetime="2011-03-29T21:11:47.979-05:00">Mar 3, 2011</time>

Hi,  
This is an excerpt from 00intstall.out produce via R CMD check.  
  
installing to d:/RQuantLib.Rcheck/RQuantLib/libs/i386  
\*\* R  
\*\* demo  
\*\* inst  
\*\* preparing package for lazy loading  
\*\* help  
\*\*\* installing help indices  
\*\* building package indices ...  
\*\* testing if installed package can be loaded  
  
\* DONE (RQuantLib)  
  
This application has requested the Runtime to terminate it in an unusual way.  
Please contact the application's support team for more information.  
  
This application has requested the Runtime to terminate it in an unusual way.  
Please contact the application's support team for more information.
<hr />
#### After going through all the steps you've provi...
[س](https://www.blogger.com/profile/15424454826905342786 "noreply@blogger.com") - <time datetime="2011-03-29T21:18:45.733-05:00">Mar 3, 2011</time>

After going through all the steps you've provided, the package was installed (although as I mentioned there are some error at the end). It seems there is a conflict between the package and Microsoft Visual C++ Runtime library.I loaded the package into R, but upon closing the R session a message pops up, complaining about a run time error. The message is:  
Run Time Error!  
Program: Rgui.exe  
This application has requested the Runtime to terminate it in an unusual way.  
Please contact the application's support team for more information.
<hr />
#### I doubt this could be caused by a conflict with Mi...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-03-29T23:06:47.591-05:00">Mar 3, 2011</time>

I doubt this could be caused by a conflict with Microsoft Visual C++ Runtime library because none of the components are built with Visual C++ (R cannot be built with it and you shouldn't have built QuantLib with it).  
  
I can only guess what the issue is without knowing more about your setup. What version of Windows, R, Rtools, MinGW, msys, boost, QuantLib, and RQuantLib are you using?  
  
Do you have any other software installed that may be causing conflicts (e.g. Cygwin)?  
  
Can you just use the 32-bit binary I posted? If not, I'm working with some of the R core members to make a multi-architecture Windows binary available on CRAN, which should be available soon.
<hr />
#### Joshua, Thanks for the help. I'm now using the...
[س](https://www.blogger.com/profile/15424454826905342786 "noreply@blogger.com") - <time datetime="2011-03-31T17:23:33.381-05:00">Mar 4, 2011</time>

Joshua,  
Thanks for the help. I'm now using the binary package that you've posted, and waiting for the newer versions to become available on CRAN.  
Thanks again
<hr />
