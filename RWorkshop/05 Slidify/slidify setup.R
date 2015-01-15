install.packages("devtools")
library("devtools", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
install_github('slidify', 'ramnathv')
install_github('slidifyLibraries', 'ramnathv')
# Make 06 Slidify the current Working Directory - click on "05 Slidify", then click on More->Set as Working Directory
library(slidify)
author("mydeck")
# cd to mydeck
# Edit index.Rmd, add a Title, Subtitle, and Author
# Knit index.Rmd