x <- c(1,2,3,4,5) # This is creates a vector in variable x
y <- 3 * x        # This is creates a vector in variable y
y1 <- 2 ** x      # This is creates a vector in variable y1
x
y
y1
df <- data.frame(x, y, y1) # This creates an R Data Frame from the three vectors
df
library(reshape2)
mdf <- melt(df, id.vars = "x", measure.vars = c("y", "y1"))
mdf
library(ggplot2)
ggplot(mdf, aes(x=x, y=value, color=variable)) + geom_line()
