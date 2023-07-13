---
title: 'Build RQuantLib on 32-bit Windows'
date: 2010-12-07T17:20:00.006-06:00
draft: false
aliases: [ "/2010/12/build-rquantlib-on-32-bit-windows.html" ]
categories: [ Articles ]
tags : [R]
---

  
Before you start, note that there is now a [Windows binary of RQuantLib is available on CRAN](http://blog.fosstrading.com/2011/04/rquantlib-windows-binary-on-cran.html).  
  

* * *

  
Due to a change in how R-2.12.0 is built, CRAN maintainers could no longer provide a Windows binary of RQuantLib with the QuantLib library they had been using. I decided to try and build an updated QuantLib library from source, which would allow me (and them) to build the current RQuantLib.  
Instructions for [Getting Started with QuantLib and MinGW from Scratch](http://www.nativact.com/taugust/quantlib.html) by Terry August (found in [QuantLib FAQ 3.2](http://quantlib.org/faq.shtml#Building%20QuantLib1)) were incredibly valuable.  Thanks to [Dirk Eddelbuettel](http://dirk.eddelbuettel.com/) for helpful guidance and pointers while I was working through this exercise, and for useful comments on this blog post.  
  
Here are the steps I took.  You will need to modify the paths to suit your particular setup.  

1.  Download and install [Rtools](http://www.murdoch-sutherland.com/Rtools/).
2.  [Download](http://sourceforge.net/projects/mingw/files/) and [install](http://www.mingw.org/wiki/Getting_Started) [MinGW](http://www.mingw.org/).
3.  Download [boost](http://sourceforge.net/projects/boost/files/boost/) (I used boost\_1\_42\_0.tar.gz)  
    unzip to c:/R/cpp/boost\_1\_42\_0  
    We only need the headers, so there's nothing to install.
4.  Download [QuantLib](http://sourceforge.net/projects/quantlib/files/) (I used QuantLib-1.0.1.zip)  
    unzip to c:/R/cpp/QuantLib-1.0.1
5.  Install Quantlib. The make and make install commands are going to take quite some time. I think they took about 2 hours on my 3.4Ghz system. Let's get started. Open a msys command line and run:  
    set PATH=c:/MinGW/bin:$PATH  
    cd c:/R/cpp  
    mkdir lib include  
    cd QuantLib-1.0.1  
    configure --with-boost-include=c:/R/cpp/boost\_1\_42\_0 --prefix=c:/R/cpp  
    make  
    make install  
    cd c:/R/cpp/lib  
    cp libQuantLib.a libQuantLib.a.bak  
    strip --strip-unneeded libQuantLib.a
6.  Download the [RQuantlib source](http://cran.r-project.org/web/packages/RQuantLib/) (I used RQuantLib\_0.3.4.tar.gz)  
    unzip it to c:/R/cpp/RQuantLib
7.  Open c:/R/cpp/RQuantLib/src/Makevars.win and ensure  
    PKG\_LIBS=$(RCPP\_LDFLAGS) -L$(QUANTLIB\_ROOT)/lib -lQuantLib
8.  Make the following directories:  
    c:/R/cpp/QuantLibBuild/boost  
    c:/R/cpp/QuantLibBuild/ql  
    c:/R/cpp/QuantLibBuild/lib  
    then copy:  
    c:/R/cpp/boost\_1\_42\_0/boost to c:/R/cpp/QuantLibBuild/boost  
    c:/R/cpp/include/ql to c:/R/cpp/QuantLibBuild/ql  
    c:/R/cpp/lib/libQuantLib.a to c:/R/cpp/QuantLibBuild/lib/libQuantLib.a
9.  Now you should be able to build RQuantLib via:  
    set QUANTLIB\_ROOT=c:/R/cpp/QuantLibBuild  
    R CMD INSTALL RQuantLib\_0.3.4.tar.gz

I cannot guarantee these instructions will work on a 64-bit system because I do not have access to a 64-bit Windows machine, but the steps should be fairly similar.  If you run into any issues, feel free to leave a comment and I will do my best to help.  
  
If you just want to use my build, you can install this [RQuantLib\_0.3.4 Windows binary](https://docs.google.com/leaf?id=0B8wl4QBejPGiYmY4NGQ5MTYtOWJlMS00NTBhLThhZmItMWI4YjQ2Mjg2MWU2&hl=en&authkey=CLDLlPAN).