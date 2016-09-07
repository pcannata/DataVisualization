---
title: "R Notebook"
output:
  html_document:
    toc: yes
  html_notebook:
    toc: yes
  pdf_document:
    toc: yes
---
R Technology Workshop
===
**R is the most popular free software environment for statistical computing and graphics. ggplot2 is a data visualization package for R that can be used to produce publication-quality graphics. This workshop is designed to introduce you to R and ggplot as well as RStudio, KnitR, Slidify, and Shiny.  
R is a central piece of the Big Data Analytics Revolution, for example, see http://opensource.com/business/14/7/interview-david-smith-revolution-analytics for an article entitled "Big data influencer on how R is paving the way"**

###This is how my RStudio is configured:

```r
sessionInfo()
```

```
## R version 3.3.1 (2016-06-21)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## Running under: OS X 10.11.6 (El Capitan)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  grid      methods  
## [8] base     
## 
## other attached packages:
## [1] knitr_1.14     extrafont_0.17 jsonlite_1.0   dplyr_0.5.0   
## [5] tidyr_0.6.0    reshape2_1.4.1 RCurl_1.95-4.8 bitops_1.0-6  
## [9] ggplot2_2.1.0 
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.6      assertthat_0.1   R6_2.1.3         plyr_1.8.4      
##  [5] Rttf2pt1_1.3.4   DBI_0.5          gtable_0.2.0     magrittr_1.5    
##  [9] evaluate_0.9     scales_0.4.0     stringi_1.1.1    extrafontdb_1.0 
## [13] tools_3.3.1      stringr_1.1.0    munsell_0.4.3    colorspace_1.2-6
## [17] tibble_1.2
```

You also need to install LaTeX if you want to generate PDF files from KnitR.    

![](./LaTex.png) http://latex-project.org/ftp.html
