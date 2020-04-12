---
title: 'Introduction to PortfolioAnalytics'
date: 2014-03-29T12:25:00.002-05:00
draft: false
aliases: [ "/2014/03/intro-to-portfolioanalytics.html" ]
tags : [Examples, PortfolioAnalytics, Code, R]
---

PortfolioAnalytics Basics body, td { font-family: sans-serif; background-color: white; font-size: 12px; margin: 8px; } tt, code, pre { font-family: 'DejaVu Sans Mono', 'Droid Sans Mono', 'Lucida Console', Consolas, Monaco, monospace; } h1 { font-size:2.2em; } h2 { font-size:1.8em; } h3 { font-size:1.4em; } h4 { font-size:1.0em; } h5 { font-size:0.9em; } h6 { font-size:0.8em; } a:visited { color: rgb(50%, 0%, 50%); } pre { margin-top: 0; max-width: 95%; border: 1px solid #ccc; white-space: pre-wrap; } pre code { display: block; padding: 0.5em; } code.r, code.cpp { background-color: #F8F8F8; } table, td, th { border: none; } blockquote { color:#666666; margin:0; padding-left: 1em; border-left: 0.5em #EEE solid; } hr { height: 0px; border-bottom: none; border-top-width: thin; border-top-style: dotted; border-top-color: #999999; } @media print { \* { background: transparent !important; color: black !important; filter:none !important; -ms-filter: none !important; } body { font-size:12pt; max-width:100%; } a, a:visited { text-decoration: underline; } hr { visibility: hidden; page-break-before: always; } pre, blockquote { padding-right: 1em; page-break-inside: avoid; } tr, img { page-break-inside: avoid; } img { max-width: 100% !important; } @page :left { margin: 15mm 20mm 15mm 10mm; } @page :right { margin: 15mm 10mm 15mm 20mm; } p, h2, h3 { orphans: 3; widows: 3; } h2, h3 { page-break-after: avoid; } } pre .operator, pre .paren { color: rgb(104, 118, 135) } pre .literal { color: rgb(88, 72, 246) } pre .number { color: rgb(0, 0, 205); } pre .comment { color: rgb(76, 136, 107); } pre .keyword { color: rgb(0, 0, 255); } pre .identifier { color: rgb(0, 0, 0); } pre .string { color: rgb(3, 106, 7); } var hljs=new function(){function m(p){return p.replace(/&/gm,"&amp;").replace(/</gm,"&lt;")}function f(r,q,p){return RegExp(q,"m"+(r.cI?"i":"")+(p?"g":""))}function b(r){for(var p=0;p<r.childNodes.length;p++){var q=r.childNodes\[p\];if(q.nodeName=="CODE"){return q}if(!(q.nodeType==3&&q.nodeValue.match(/\\s+/))){break}}}function h(t,s){var p="";for(var r=0;r<t.childNodes.length;r++){if(t.childNodes\[r\].nodeType==3){var q=t.childNodes\[r\].nodeValue;if(s){q=q.replace(/\\n/g,"")}p+=q}else{if(t.childNodes\[r\].nodeName=="BR"){p+="\\n"}else{p+=h(t.childNodes\[r\])}}}if(/MSIE \[678\]/.test(navigator.userAgent)){p=p.replace(/\\r/g,"\\n")}return p}function a(s){var r=s.className.split(/\\s+/);r=r.concat(s.parentNode.className.split(/\\s+/));for(var q=0;q<r.length;q++){var p=r\[q\].replace(/^language-/,"");if(e\[p\]){return p}}}function c(q){var p=\[\];(function(s,t){for(var r=0;r<s.childNodes.length;r++){if(s.childNodes\[r\].nodeType==3){t+=s.childNodes\[r\].nodeValue.length}else{if(s.childNodes\[r\].nodeName=="BR"){t+=1}else{if(s.childNodes\[r\].nodeType==1){p.push({event:"start",offset:t,node:s.childNodes\[r\]});t=arguments.callee(s.childNodes\[r\],t);p.push({event:"stop",offset:t,node:s.childNodes\[r\]})}}}}return t})(q,0);return p}function k(y,w,x){var q=0;var z="";var s=\[\];function u(){if(y.length&&w.length){if(y\[0\].offset!=w\[0\].offset){return(y\[0\].offset<w\[0\].offset)?y:w}else{return w\[0\].event=="start"?y:w}}else{return y.length?y:w}}function t(D){var A="<"+D.nodeName.toLowerCase();for(var B=0;B<D.attributes.length;B++){var C=D.attributes\[B\];A+=" "+C.nodeName.toLowerCase();if(C.value!==undefined&&C.value!==false&&C.value!==null){A+='="'+m(C.value)+'"'}}return A+">"}while(y.length||w.length){var v=u().splice(0,1)\[0\];z+=m(x.substr(q,v.offset-q));q=v.offset;if(v.event=="start"){z+=t(v.node);s.push(v.node)}else{if(v.event=="stop"){var p,r=s.length;do{r--;p=s\[r\];z+=("</"+p.nodeName.toLowerCase()+">")}while(p!=v.node);s.splice(r,1);while(r<s.length){z+=t(s\[r\]);r++}}}}return z+m(x.substr(q))}function j(){function q(x,y,v){if(x.compiled){return}var u;var s=\[\];if(x.k){x.lR=f(y,x.l||hljs.IR,true);for(var w in x.k){if(!x.k.hasOwnProperty(w)){continue}if(x.k\[w\] instanceof Object){u=x.k\[w\]}else{u=x.k;w="keyword"}for(var r in u){if(!u.hasOwnProperty(r)){continue}x.k\[r\]=\[w,u\[r\]\];s.push(r)}}}if(!v){if(x.bWK){x.b="\\\\b("+s.join("|")+")\\\\s"}x.bR=f(y,x.b?x.b:"\\\\B|\\\\b");if(!x.e&&!x.eW){x.e="\\\\B|\\\\b"}if(x.e){x.eR=f(y,x.e)}}if(x.i){x.iR=f(y,x.i)}if(x.r===undefined){x.r=1}if(!x.c){x.c=\[\]}x.compiled=true;for(var t=0;t<x.c.length;t++){if(x.c\[t\]=="self"){x.c\[t\]=x}q(x.c\[t\],y,false)}if(x.starts){q(x.starts,y,false)}}for(var p in e){if(!e.hasOwnProperty(p)){continue}q(e\[p\].dM,e\[p\],true)}}function d(B,C){if(!j.called){j();j.called=true}function q(r,M){for(var L=0;L<M.c.length;L++){if((M.c\[L\].bR.exec(r)||\[null\])\[0\]==r){return M.c\[L\]}}}function v(L,r){if(D\[L\].e&&D\[L\].eR.test(r)){return 1}if(D\[L\].eW){var M=v(L-1,r);return M?M+1:0}return 0}function w(r,L){return L.i&&L.iR.test(r)}function K(N,O){var M=\[\];for(var L=0;L<N.c.length;L++){M.push(N.c\[L\].b)}var r=D.length-1;do{if(D\[r\].e){M.push(D\[r\].e)}r--}while(D\[r+1\].eW);if(N.i){M.push(N.i)}return f(O,M.join("|"),true)}function p(M,L){var N=D\[D.length-1\];if(!N.t){N.t=K(N,E)}N.t.lastIndex=L;var r=N.t.exec(M);return r?\[M.substr(L,r.index-L),r\[0\],false\]:\[M.substr(L),"",true\]}function z(N,r){var L=E.cI?r\[0\].toLowerCase():r\[0\];var M=N.k\[L\];if(M&&M instanceof Array){return M}return false}function F(L,P){L=m(L);if(!P.k){return L}var r="";var O=0;P.lR.lastIndex=0;var M=P.lR.exec(L);while(M){r+=L.substr(O,M.index-O);var N=z(P,M);if(N){x+=N\[1\];r+='<span class="'+N\[0\]+'">'+M\[0\]+"</span>"}else{r+=M\[0\]}O=P.lR.lastIndex;M=P.lR.exec(L)}return r+L.substr(O,L.length-O)}function J(L,M){if(M.sL&&e\[M.sL\]){var r=d(M.sL,L);x+=r.keyword\_count;return r.value}else{return F(L,M)}}function I(M,r){var L=M.cN?'<span class="'+M.cN+'">':"";if(M.rB){y+=L;M.buffer=""}else{if(M.eB){y+=m(r)+L;M.buffer=""}else{y+=L;M.buffer=r}}D.push(M);A+=M.r}function G(N,M,Q){var R=D\[D.length-1\];if(Q){y+=J(R.buffer+N,R);return false}var P=q(M,R);if(P){y+=J(R.buffer+N,R);I(P,M);return P.rB}var L=v(D.length-1,M);if(L){var O=R.cN?"</span>":"";if(R.rE){y+=J(R.buffer+N,R)+O}else{if(R.eE){y+=J(R.buffer+N,R)+O+m(M)}else{y+=J(R.buffer+N+M,R)+O}}while(L>1){O=D\[D.length-2\].cN?"</span>":"";y+=O;L--;D.length--}var r=D\[D.length-1\];D.length--;D\[D.length-1\].buffer="";if(r.starts){I(r.starts,"")}return R.rE}if(w(M,R)){throw"Illegal"}}var E=e\[B\];var D=\[E.dM\];var A=0;var x=0;var y="";try{var s,u=0;E.dM.buffer="";do{s=p(C,u);var t=G(s\[0\],s\[1\],s\[2\]);u+=s\[0\].length;if(!t){u+=s\[1\].length}}while(!s\[2\]);if(D.length>1){throw"Illegal"}return{r:A,keyword\_count:x,value:y}}catch(H){if(H=="Illegal"){return{r:0,keyword\_count:0,value:m(C)}}else{throw H}}}function g(t){var p={keyword\_count:0,r:0,value:m(t)};var r=p;for(var q in e){if(!e.hasOwnProperty(q)){continue}var s=d(q,t);s.language=q;if(s.keyword\_count+s.r>r.keyword\_count+r.r){r=s}if(s.keyword\_count+s.r>p.keyword\_count+p.r){r=p;p=s}}if(r.language){p.second\_best=r}return p}function i(r,q,p){if(q){r=r.replace(/^((<\[^>\]+>|\\t)+)/gm,function(t,w,v,u){return w.replace(/\\t/g,q)})}if(p){r=r.replace(/\\n/g,"<br>")}return r}function n(t,w,r){var x=h(t,r);var v=a(t);var y,s;if(v){y=d(v,x)}else{return}var q=c(t);if(q.length){s=document.createElement("pre");s.innerHTML=y.value;y.value=k(q,c(s),x)}y.value=i(y.value,w,r);var u=t.className;if(!u.match("(\\\\s|^)(language-)?"+v+"(\\\\s|$)")){u=u?(u+" "+v):v}if(/MSIE \[678\]/.test(navigator.userAgent)&&t.tagName=="CODE"&&t.parentNode.tagName=="PRE"){s=t.parentNode;var p=document.createElement("div");p.innerHTML="<pre><code>"+y.value+"</code></pre>";t=p.firstChild.firstChild;p.firstChild.cN=s.cN;s.parentNode.replaceChild(p.firstChild,s)}else{t.innerHTML=y.value}t.className=u;t.result={language:v,kw:y.keyword\_count,re:y.r};if(y.second\_best){t.second\_best={language:y.second\_best.language,kw:y.second\_best.keyword\_count,re:y.second\_best.r}}}function o(){if(o.called){return}o.called=true;var r=document.getElementsByTagName("pre");for(var p=0;p<r.length;p++){var q=b(r\[p\]);if(q){n(q,hljs.tabReplace)}}}function l(){if(window.addEventListener){window.addEventListener("DOMContentLoaded",o,false);window.addEventListener("load",o,false)}else{if(window.attachEvent){window.attachEvent("onload",o)}else{window.onload=o}}}var e={};this.LANGUAGES=e;this.highlight=d;this.highlightAuto=g;this.fixMarkup=i;this.highlightBlock=n;this.initHighlighting=o;this.initHighlightingOnLoad=l;this.IR="\[a-zA-Z\]\[a-zA-Z0-9\_\]\*";this.UIR="\[a-zA-Z\_\]\[a-zA-Z0-9\_\]\*";this.NR="\\\\b\\\\d+(\\\\.\\\\d+)?";this.CNR="\\\\b(0\[xX\]\[a-fA-F0-9\]+|(\\\\d+(\\\\.\\\\d\*)?|\\\\.\\\\d+)(\[eE\]\[-+\]?\\\\d+)?)";this.BNR="\\\\b(0b\[01\]+)";this.RSR="!|!=|!==|%|%=|&|&&|&=|\\\\\*|\\\\\*=|\\\\+|\\\\+=|,|\\\\.|-|-=|/|/=|:|;|<|<<|<<=|<=|=|==|===|>|>=|>>|>>=|>>>|>>>=|\\\\?|\\\\\[|\\\\{|\\\\(|\\\\^|\\\\^=|\\\\||\\\\|=|\\\\|\\\\||~";this.ER="(?!\[\\\\s\\\\S\])";this.BE={b:"\\\\\\\\.",r:0};this.ASM={cN:"string",b:"'",e:"'",i:"\\\\n",c:\[this.BE\],r:0};this.QSM={cN:"string",b:'"',e:'"',i:"\\\\n",c:\[this.BE\],r:0};this.CLCM={cN:"comment",b:"//",e:"$"};this.CBLCLM={cN:"comment",b:"/\\\\\*",e:"\\\\\*/"};this.HCM={cN:"comment",b:"#",e:"$"};this.NM={cN:"number",b:this.NR,r:0};this.CNM={cN:"number",b:this.CNR,r:0};this.BNM={cN:"number",b:this.BNR,r:0};this.inherit=function(r,s){var p={};for(var q in r){p\[q\]=r\[q\]}if(s){for(var q in s){p\[q\]=s\[q\]}}return p}}();hljs.LANGUAGES.cpp=function(){var a={keyword:{"false":1,"int":1,"float":1,"while":1,"private":1,"char":1,"catch":1,"export":1,virtual:1,operator:2,sizeof:2,dynamic\_cast:2,typedef:2,const\_cast:2,"const":1,struct:1,"for":1,static\_cast:2,union:1,namespace:1,unsigned:1,"long":1,"throw":1,"volatile":2,"static":1,"protected":1,bool:1,template:1,mutable:1,"if":1,"public":1,friend:2,"do":1,"return":1,"goto":1,auto:1,"void":2,"enum":1,"else":1,"break":1,"new":1,extern:1,using:1,"true":1,"class":1,asm:1,"case":1,typeid:1,"short":1,reinterpret\_cast:2,"default":1,"double":1,register:1,explicit:1,signed:1,typename:1,"try":1,"this":1,"switch":1,"continue":1,wchar\_t:1,inline:1,"delete":1,alignof:1,char16\_t:1,char32\_t:1,constexpr:1,decltype:1,noexcept:1,nullptr:1,static\_assert:1,thread\_local:1,restrict:1,\_Bool:1,complex:1},built\_in:{std:1,string:1,cin:1,cout:1,cerr:1,clog:1,stringstream:1,istringstream:1,ostringstream:1,auto\_ptr:1,deque:1,list:1,queue:1,stack:1,vector:1,map:1,set:1,bitset:1,multiset:1,multimap:1,unordered\_set:1,unordered\_map:1,unordered\_multiset:1,unordered\_multimap:1,array:1,shared\_ptr:1}};return{dM:{k:a,i:"</",c:\[hljs.CLCM,hljs.CBLCLM,hljs.QSM,{cN:"string",b:"'\\\\\\\\?.",e:"'",i:"."},{cN:"number",b:"\\\\b(\\\\d+(\\\\.\\\\d\*)?|\\\\.\\\\d+)(u|U|l|L|ul|UL|f|F)"},hljs.CNM,{cN:"preprocessor",b:"#",e:"$"},{cN:"stl\_container",b:"\\\\b(deque|list|queue|stack|vector|map|set|bitset|multiset|multimap|unordered\_map|unordered\_set|unordered\_multiset|unordered\_multimap|array)\\\\s\*<",e:">",k:a,r:10,c:\["self"\]}\]}}}();hljs.LANGUAGES.r={dM:{c:\[hljs.HCM,{cN:"number",b:"\\\\b0\[xX\]\[0-9a-fA-F\]+\[Li\]?\\\\b",e:hljs.IMMEDIATE\_RE,r:0},{cN:"number",b:"\\\\b\\\\d+(?:\[eE\]\[+\\\\-\]?\\\\d\*)?L\\\\b",e:hljs.IMMEDIATE\_RE,r:0},{cN:"number",b:"\\\\b\\\\d+\\\\.(?!\\\\d)(?:i\\\\b)?",e:hljs.IMMEDIATE\_RE,r:1},{cN:"number",b:"\\\\b\\\\d+(?:\\\\.\\\\d\*)?(?:\[eE\]\[+\\\\-\]?\\\\d\*)?i?\\\\b",e:hljs.IMMEDIATE\_RE,r:0},{cN:"number",b:"\\\\.\\\\d+(?:\[eE\]\[+\\\\-\]?\\\\d\*)?i?\\\\b",e:hljs.IMMEDIATE\_RE,r:1},{cN:"keyword",b:"(?:tryCatch|library|setGeneric|setGroupGeneric)\\\\b",e:hljs.IMMEDIATE\_RE,r:10},{cN:"keyword",b:"\\\\.\\\\.\\\\.",e:hljs.IMMEDIATE\_RE,r:10},{cN:"keyword",b:"\\\\.\\\\.\\\\d+(?!\[\\\\w.\])",e:hljs.IMMEDIATE\_RE,r:10},{cN:"keyword",b:"\\\\b(?:function)",e:hljs.IMMEDIATE\_RE,r:2},{cN:"keyword",b:"(?:if|in|break|next|repeat|else|for|return|switch|while|try|stop|warning|require|attach|detach|source|setMethod|setClass)\\\\b",e:hljs.IMMEDIATE\_RE,r:1},{cN:"literal",b:"(?:NA|NA\_integer\_|NA\_real\_|NA\_character\_|NA\_complex\_)\\\\b",e:hljs.IMMEDIATE\_RE,r:10},{cN:"literal",b:"(?:NULL|TRUE|FALSE|T|F|Inf|NaN)\\\\b",e:hljs.IMMEDIATE\_RE,r:1},{cN:"identifier",b:"\[a-zA-Z.\]\[a-zA-Z0-9.\_\]\*\\\\b",e:hljs.IMMEDIATE\_RE,r:0},{cN:"operator",b:"<\\\\-(?!\\\\s\*\\\\d)",e:hljs.IMMEDIATE\_RE,r:2},{cN:"operator",b:"\\\\->|<\\\\-",e:hljs.IMMEDIATE\_RE,r:1},{cN:"operator",b:"%%|~",e:hljs.IMMEDIATE\_RE},{cN:"operator",b:">=|<=|==|!=|\\\\|\\\\||&&|=|\\\\+|\\\\-|\\\\\*|/|\\\\^|>|<|!|&|\\\\||\\\\$|:",e:hljs.IMMEDIATE\_RE,r:0},{cN:"operator",b:"%",e:"%",i:"\\\\n",r:1},{cN:"identifier",b:"\`",e:"\`",r:0},{cN:"string",b:'"',e:'"',c:\[hljs.BE\],r:0},{cN:"string",b:"'",e:"'",c:\[hljs.BE\],r:0},{cN:"paren",b:"\[\[({\\\\\])}\]",e:hljs.IMMEDIATE\_RE,r:0}\]}}; hljs.initHighlightingOnLoad(); This is a guest post by Ross Bennett. Ross is currently enrolled in the University of Washington Master of Science in Computational Finance & Risk Management program with an expected graduation date of December 2014. He worked on the PortfolioAnalytics package as part of the Google Summer of Code 2013 project and continues to work on the package as a Research Assistant at the University of Washington.

His work on the package focused on implementing a portfolio specification to separate and modularize assets, constraints, and objectives. Support for additional constraints including group, diversification, and factor exposure constraints was also added. The random portfolio solver was expanded to include two additional methods of generating random portfolios. The optimization backends were further standardized for sets of constraints and objectives that can be solved via linear and quadratic programming solvers using the ROI package. Charts including risk budget and efficient frontiers were added as well as standardizing the charting across all optimization engines.

This post is meant to provide a very basic introduction to the PortfolioAnalytics package. PortfolioAnalytics is an R package designed to provide numerical solutions and visualizations for portfolio problems with complex constraints and objectives. A key feature of PortfolioAnalytics is the ability to specify a portfolio with assets, constraints, and objectives that is solver agnostic, where the objective can be comprised of any valid R function. PortfolioAnalytics utilizes multiple solvers as backends for the optimization; linear programming, quadratic programming, differential evolution, random portfolios, particle swarm, and generalized simulated annealing. For optimization problems that can be formulated as linear or quadratic problems, these can be solved very fast and efficiently using the appropriate linear or quadratic solver supported by PortfolioAnalytics. For optimization problems with more complex constraints and objectives, a global solver such as differential evolution or random portfolios can be used to find a solution.

Ross will be giving a tutorial on PortfolioAnalytics at the [R/Finance 2014 Conference](http://www.rinfinance.com). The tutorial will cover the key features of PortfolioAnalytics along with several comprehensive examples. Those who want to learn more about how R is used in finance are encouraged to attend.

The primary functions in PortfolioAnalytics to specify a portfolio with constraints and objectives are `portfolio.spec`, `add.constraint`, and `add.objective`.

```
library(PortfolioAnalytics)  
data(edhec)  
returns <- edhec[, 1:6]  
funds <- colnames(returns)  

```Here we create a portfolio object with `portfolio.spec`. The `assets` argument is a required argument to the `portfolio.spec` function. `assets` can be a character vector with the names of the assets, a named numeric vector, or a scalar value specifying the number of assets. If a character vector or scalar value is passed in for `assets`, equal weights will be created for the initial portfolio weights.

```
init.portfolio <- portfolio.spec(assets = funds)  

```The `portfolio` object is an S3 class that contains portfolio level data as well as the constraints and objectives for the optimization problem. You can see that the constraints and objectives lists are currently empty, but we will add sets of constraints and objectives with `add.constraint` and `add.objective`.

```
print.default(init.portfolio)  

``````
## $assets  
## Convertible Arbitrage            CTA Global Distressed Securities   
##                0.1667                0.1667                0.1667   
##      Emerging Markets Equity Market Neutral          Event Driven   
##                0.1667                0.1667                0.1667   
##   
## $category_labels  
## NULL  
##   
## $weight_seq  
## NULL  
##   
## $constraints  
## list()  
##   
## $objectives  
## list()  
##   
## $call  
## portfolio.spec(assets = funds)  
##   
## attr(,"class")  
## [1] "portfolio.spec" "portfolio"  

```Here we add the full investment constraint. The full investment constraint is a special case of the leverage constraint that specifies the weights must sum to 1 and is specified with the alias `type="full_investment"` as shown below.

```
init.portfolio <- add.constraint(portfolio = init.portfolio, type = "full_investment")  

```Now we add box constraint to specify a long only portfolio. The long only constraint is a special case of a box constraint where the lower bound of the weights of each asset is equal to 0 and the upper bound of the weights of each asset is equal to 1. This is specified with `type="long_only"` as shown below. The box constraint also allows for per asset weights to be specified.

```
init.portfolio <- add.constraint(portfolio = init.portfolio, type = "long_only")  

```The following constraint types are supported:  

*   leverage
*   box
*   group
*   position\_limit1
*   turnover2
*   diversification
*   return
*   factor\_exposure
*   transaction\_cost2

1.  Not supported for problems formulated as quadratic programming problems solved with `optimize_method="ROI"`.
2.  Not supported for problems formulated as linear programming problems solved with `optimize_method="ROI"`.

Below we create two new portfolio objects. Note that we areassigning new names for the portfolios. This re-uses the constraints from `init.portfolio` and adds the objectives specified below to `minSD.portfolio` and `meanES.portfolio` while leaving `init.portfolio` unchanged. This is useful for testing multiple portfolios with different objectives using the same constraints because the constraints only need to be specified once and several new portfolios can be created using an initial portfolio object.

```
# Add objective for portfolio to minimize portfolio standard deviation  
minSD.portfolio <- add.objective(portfolio=init.portfolio,   
                                 type="risk",   
                                 name="StdDev")  
  
# Add objectives for portfolio to maximize mean per unit ES  
meanES.portfolio <- add.objective(portfolio=init.portfolio,   
                                  type="return",   
                                  name="mean")  
  
meanES.portfolio <- add.objective(portfolio=meanES.portfolio,   
                                  type="risk",   
                                  name="ES")  

```Note that the `name` argument in `add.objective` can be any valid R function. Several functions are provided in the PerformanceAnalytics package that can be specified as the `name` argument such as ES/ETL/CVaR, StdDev, etc.

The following objective types are supported:  

*   return
*   risk
*   risk\_budget
*   weight\_concentration

As demonstrated above, the `add.constraint` and `add.objective` functions were designed to be very flexible and modular so that constraints and objectives can easily be specified and added to `portfolio` objects.

PortfolioAnalytics provides a `print` method so that we can easily view the assets, constraints, and objectives that we have specified for the portfolio.

```
print(minSD.portfolio)  

``````
## **************************************************  
## PortfolioAnalytics Portfolio Specification   
## **************************************************  
##   
## Call:  
## portfolio.spec(assets = funds)  
##   
## Assets  
## Number of assets: 6   
##   
## Asset Names  
## [1] "Convertible Arbitrage" "CTA Global"            "Distressed Securities"  
## [4] "Emerging Markets"      "Equity Market Neutral" "Event Driven"           
##   
## Constraints  
## Number of constraints: 2   
## Number of enabled constraints: 2   
## Enabled constraint types  
##      - full_investment   
##      - long_only   
## Number of disabled constraints: 0   
##   
## Objectives  
## Number of objectives: 1   
## Number of enabled objectives: 1   
## Enabled objective names  
##      - StdDev   
## Number of disabled objectives: 0  

``````
print(meanES.portfolio)  

``````
## **************************************************  
## PortfolioAnalytics Portfolio Specification   
## **************************************************  
##   
## Call:  
## portfolio.spec(assets = funds)  
##   
## Assets  
## Number of assets: 6   
##   
## Asset Names  
## [1] "Convertible Arbitrage" "CTA Global"            "Distressed Securities"  
## [4] "Emerging Markets"      "Equity Market Neutral" "Event Driven"           
##   
## Constraints  
## Number of constraints: 2   
## Number of enabled constraints: 2   
## Enabled constraint types  
##      - full_investment   
##      - long_only   
## Number of disabled constraints: 0   
##   
## Objectives  
## Number of objectives: 2   
## Number of enabled objectives: 2   
## Enabled objective names  
##      - mean   
##      - ES   
## Number of disabled objectives: 0  

```Now that we have portfolios set up with the desired constraints and objectives, we use `optimize.portfolio` to run the optimizations. The examples below use `optimize_method="ROI"`, but several other solvers are supported including the following:

*   DEoptim (differential evolution)
*   random portfolios
    *   sample
    *   simplex
    *   grid
*   GenSA (generalized simulated annealing)
*   pso (particle swarm optimization)
*   ROI (R Optimization Infrastructure)
    *   Rglpk
    *   quadprog

The objective to minimize standard deviation can be formulated as a quadratic programming problem and can be solved quickly with `optimize_method="ROI"`.

```
# Run the optimization for the minimum standard deviation portfolio  
minSD.opt <- optimize.portfolio(R = returns, portfolio = minSD.portfolio,   
    optimize_method = "ROI", trace = TRUE)  
  
print(minSD.opt)  

``````
## ***********************************  
## PortfolioAnalytics Optimization  
## ***********************************  
##   
## Call:  
## optimize.portfolio(R = returns, portfolio = minSD.portfolio,   
##     optimize_method = "ROI", trace = TRUE)  
##   
## Optimal Weights:  
## Convertible Arbitrage            CTA Global Distressed Securities   
##                0.0000                0.0652                0.0000   
##      Emerging Markets Equity Market Neutral          Event Driven   
##                0.0000                0.9348                0.0000   
##   
## Objective Measure:  
##   StdDev   
## 0.008855  

```The objective to maximize mean return per ES can be formulated as a linear programming problem and can be solved quickly with `optimize_method="ROI"`.

```
# Run the optimization for the maximize mean per unit ES  
meanES.opt <- optimize.portfolio(R = returns, portfolio = meanES.portfolio,   
    optimize_method = "ROI", trace = TRUE)  
  
print(meanES.opt)  

``````
## ***********************************  
## PortfolioAnalytics Optimization  
## ***********************************  
##   
## Call:  
## optimize.portfolio(R = returns, portfolio = meanES.portfolio,   
##     optimize_method = "ROI", trace = TRUE)  
##   
## Optimal Weights:  
## Convertible Arbitrage            CTA Global Distressed Securities   
##                0.0000                0.2940                0.2509   
##      Emerging Markets Equity Market Neutral          Event Driven   
##                0.0000                0.4552                0.0000   
##   
## Objective Measure:  
##     mean   
## 0.006635   
##   
##   
##      ES   
## 0.01837  

```The PortfolioAnalytics package provides functions for charting to better understand the optimization problem through visualization. The `plot` function produces a plot of of the optimal weights and the optimal portfolio in risk-return space. The optimal weights and chart in risk-return space can be plotted separately with `chart.Weights` and `chart.RiskReward`.

```
plot(minSD.opt, risk.col="StdDev", chart.assets=TRUE,   
     main="Min SD Optimization",  
     ylim=c(0, 0.0083), xlim=c(0, 0.06))  

```

[![](http://4.bp.blogspot.com/-bLrvc7w1wJ8/Uy99ONrSmeI/AAAAAAAAANU/08dJ2PN9-eY/s400/unnamed-chunk-102.png)](http://4.bp.blogspot.com/-bLrvc7w1wJ8/Uy99ONrSmeI/AAAAAAAAANU/08dJ2PN9-eY/s1600/unnamed-chunk-102.png)

```
plot(meanES.opt, chart.assets=TRUE,   
     main="Mean ES Optimization",  
     ylim=c(0, 0.0083), xlim=c(0, 0.16))  

```

[![](http://3.bp.blogspot.com/-2RRkbXaQy0s/Uy99i2-Q2LI/AAAAAAAAANc/6eRenUhx-X8/s400/unnamed-chunk-101.png)](http://3.bp.blogspot.com/-2RRkbXaQy0s/Uy99i2-Q2LI/AAAAAAAAANc/6eRenUhx-X8/s1600/unnamed-chunk-101.png)

This post demonstrates how to construct a portfolio object, add constraints, and add objectives for two simple optimization problems; one to minimize portfolio standard devation and another to maximize mean return per unit expected shortfall. We then run optimizations on both portfolio objects and plot the results of each portfolio optimization. Although this post demonstrates fairly simple constraints and objectives, PortfolioAnalytics supports complex constraints and objectives as well as many other features that will be covered in subsequent posts.

The PortfolioAnalytics package is part of the [ReturnAnalytics](http://r-forge.r-project.org/projects/returnanalytics/) project on R-Forge. For additional examples and information, refer to the several vignettes and demos are provided in the package.