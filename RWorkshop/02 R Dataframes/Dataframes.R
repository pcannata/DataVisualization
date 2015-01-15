
library("ggplot2")
"Displaying the top few rows of a dataframe:"
head(diamonds)
"Selecting a subset of columns from a dataframe:"
head(subset(diamonds, select = c(carat, cut)))
"Selecting a subset of rows from a dataframe:"
head(subset(diamonds, cut == "Ideal" & price > 5000))
"Find average price group by color (plyr package is needed)"
library("plyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
ddply(subset(diamonds, cut == "Ideal" & price > 5000),~color, summarise, o=mean(price, na.rm = TRUE))