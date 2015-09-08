# aes_string is used below, its usage is:
#    aes_string(...) 
# Arguments
#    ...    which is a list of name value pairs.

FigureNum <<- 0 # Global variable

ggplot_func <- function(df,
  Title = "Diamonds",
  Legend = "color",   # Notice how this is handled below using the aes_string() function
  PointColor = c("red", "blue", "green", "yellow", "grey", "black", "purple"), # See https://groups.google.com/forum/#!forum/ggplot2 for color choices.
  Sizes = c(.5,.5,.5,.5,.5,.5,.5,.5),
  AxisSize = 12,
  TitleSize = 16,
  LegendSize = 14,
  YMin = 0,
  YMax = max(df$price) * 1.1,
  XMin = 0,
  XMax = max(df$carat) * 1.1,
  YLabel = 'price',
  XLabel = 'carat',
  Background = "grey97",
  MinorGridColor = "snow2",
  MajorGridColor = "snow3",
  MinorGridSize = .5,
  MajorGridSize = .5,
  FigNum = -1,
  FigNumOffset = 0
) {
  
    if(FigNum != -1) FigNum = FigNum
    else FigNum = {
      FigureNum <<- FigureNum + 1
    }
    
    p1 = ggplot(df, aes(x = carat, y = price)) + 
    geom_point(aes_string(color = Legend)) + 
    scale_colour_manual(values = PointColor) + # See http://docs.ggplot2.org/0.9.3.1/scale_manual.html for more information.
    labs(y = YLabel, x = paste(XLabel, '\nFigure', toString(FigNumOffset + FigNum)), title=Title) +
    ylim(YMin, YMax) + xlim(XMin, XMax) + 
    scale_x_continuous(breaks=c(seq(XMin,XMax,by=1)), minor_breaks=seq(XMin,XMax,by=1))  + 
    # theme is now used, see http://docs.ggplot2.org/0.9.2.1/theme.html for more information.
    theme(legend.text = element_text(size = LegendSize, face = "bold")) + # see http://www.cookbook-r.com/Graphs/Legends_(ggplot2) for more information.
    theme(axis.text=element_text(size=12), axis.title=element_text(size=AxisSize,face="bold")) +
    theme(plot.title = element_text(size=TitleSize,face="bold")) +
    theme(panel.grid.major = element_line(colour=MajorGridColor, size=MajorGridSize)) +
    theme(panel.grid.minor = element_line(colour=MinorGridColor, size=MinorGridSize)) +
    theme(panel.background = element_rect(fill=Background, colour=Background))
    
    return(p1)
}

p1 <- ggplot_func(diamonds)
p1
p2 <- ggplot_func(diamonds, YMin = 5000, YMax = 15000)
p2
p3 <- ggplot_func(subset(diamonds, cut == "Premium"), Legend = "cut")
p3
p4 <- ggplot_func(diamonds, Legend = "clarity", PointColor = c("red", "blue", "green", "yellow", "grey", "black", "purple", "orange"))
p4

library("grid")

png("4diamonds.png", width = 25, height = 20, units = "in", res = 72)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2)))   

# Print Plots
print(p1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))  
print(p2, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(p3, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))  
print(p4, vp = viewport(layout.pos.row = 2, layout.pos.col = 2)) 

dev.off()
