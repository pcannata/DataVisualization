# "library("ggplot2")
options(java.parameters="-Xmx2g")

head(diamonds)

ggplot(data = diamonds) + geom_histogram(aes(x = carat))
ggplot(data = diamonds) + geom_density(aes(x = carat, fill = "gray50"))
ggplot(diamonds, aes(x = carat, y = price)) + geom_point()
p <- ggplot(diamonds, aes(x = carat, y = price)) + geom_point(aes(color = color))
p + facet_wrap(~color) # For ~, see http://stat.ethz.ch/R-manual/R-patched/library/base/html/tilde.html and http://stat.ethz.ch/R-manual/R-patched/library/stats/html/formula.html
p + facet_grid(cut ~ clarity)
p <- ggplot(diamonds, aes(x = carat)) + geom_histogram(aes(color = color), binwidth = max(diamonds$carat)/30)
p + facet_wrap(~color) 
p + facet_grid(cut ~ clarity)


