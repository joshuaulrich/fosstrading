---
title: 'DEoptim in Parallel'
date: 2012-03-04T20:33:00.000-06:00
draft: false
aliases: [ "/2012/03/deoptim-in-parallel.html" ]
tags : [DEoptim, Releases, R]
---

Running [DEoptim](http://cran.r-project.org/package=DEoptim) in parallel has been on the development team's wishlist for awhile.  It had not been a priority though, because none of us have personally needed it.  An opportunity arose when [Kris Boudt](http://www.econ.kuleuven.be/public/n06054/) approached me about collaborating to add this functionality as part of a consultancy project for a financial services firm.  
  
We were able to add and test the functionality within a week.  The latest revision of [DEoptim on R-Forge](https://r-forge.r-project.org/projects/deoptim/) has the capability to evaluate the objective function on multiple cores using [foreach](http://cran.r-project.org/web/packages/foreach/index.html).  Very CPU-intensive problems will see speed increases in approximately linear time (less communication overhead).  
  
I gave a [short presentation](http://files.meetup.com/1772780/20120201_Ulrich_Parallel_DEoptim.pdf) (PDF) on the parallel functionality at the [Saint Louis R User Group](http://www.meetup.com/Saint-Louis-RUG/) meetup in February.  A longer-running version of the code used in the presentation is on R-Forge, in the file [DEoptim/sandbox/largeN\_doSNOW.R](https://r-forge.r-project.org/scm/viewvc.php/pkg/DEoptim/sandbox/largeN_doSNOW.R?view=markup&revision=86&root=deoptim) (revision 86).  
  
There are a few things to keep in mind when using the parallel functionality.  I quote from the meetup presentation:  

*   Data communication between nodes can overwhelm gains from processing on multiple CPUs

*   Be careful with non-varying objects
*   Exclude them from formal function arguments

*   Copy them to nodes before optimization (`clusterExport()`)
*   If `mu` and `sigma` were formal function arguments, they would be copied to each node for all 2037 function evaluations!

Please try it and give us feedback.  R-Forge has been undergoing major updates, so please anonymously checkout the source and build it yourself if you're unable to download the pre-built source / binaries.
