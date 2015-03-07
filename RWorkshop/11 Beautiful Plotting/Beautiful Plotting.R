#  Table of Contents (Generated using: nl -b a Beautiful\ Plotting.R | grep "[0-9]* *#")
#Line Number: 62 ### Working with the title - page 4 of the Beautiful Plots pdf
#Line Number: 64    # Add a title
#Line Number: 66	  # or
#Line Number: 68	  # Make title bold and add a little space at the baseline (face,vjust)
#Line Number: 70	  # Use a non-traditional font in your title (family)
#Line Number: 73	  # Change spacing in multi-line text (lineheight)
#Line Number: 76	### Working with axes - page 8 of the Beautiful Plots pdf
#Line Number: 77	  # Add x and y axis labels (labs(),xlab())
#Line Number: 79	  # Get rid of axis ticks and tick text (theme(),axis.ticks.y)
#Line Number: 81	  # Change size of and rotate tick text (axis.text.x)
#Line Number: 83	  # Move the labels away from the plot (and add color) (theme(), axis.title.x)
#Line Number: 88	  # Limit an axis to a range (ylim(),scale_x_continuous(), coord_cartesian())
#Line Number: 90	  # or
#Line Number: 92	  # Use a function to alter labels (label=function(x){})
#Line Number: 97	### Working with Legends - page 15 of the Beautiful Plots pdf
#Line Number: 106	  # Turn off the legend title (legend.title)
#Line Number: 108	  # Change the styling of the legend title (legend.title)
#Line Number: 110	  # Change the title of the legend (name), this also splits the legends
#Line Number: 112	  # Change the background boxes in the legend (legend.key)
#Line Number: 115	  # Change the size of the symbols in the legend only (guides(), guide_legend)
#Line Number: 117	  # This is a bad example but it shows how to turn off a legend layer.
#Line Number: 120	  # Manual Legends - page 23 of the Beautiful Plots pdf
#Line Number: 124	### Background Colors - page 27 of the Beautiful Plots pdf
#Line Number: 126	  # Change the panel color (panel.background)
#Line Number: 128	  # Change the grid lines (panel.grid.major)
#Line Number: 132	  # Change the plot background (not the panel) color (plot.background)
#Line Number: 134	### Creating multi-panel plots - page 30 of the Beautiful Plots pdf
#Line Number: 135	  # Changing the plot margin (plot.margin)
#Line Number: 137	### Creating multi-panel plots - page 32 of the Beautiful Plots pdf
#Line Number: 139	  # Allow scales to roam free (scales)
#Line Number: 141	  # Put two (potentially unrelated) plots side by side (pushViewport())
#Line Number: 148	### Working with themes - page 37 of the Beautiful Plots pdf - see also https://github.com/jrnold/ggthemes
#Line Number: 152	  # Creating a custom theme - See page 39 of the Beautiful Plots pdf
#Line Number: 153	### Working with colors - page 41 of the Beautiful Plots pdf
#Line Number: 154	  # Categorical variables: manually select the colors (scale_color_manual())
#Line Number: 155	ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_point() + scale_color_manual(values=c("dodgerblue4", "darkolivegreen4", "darkorchid3", "goldenrod1")) # Uncomment this to get an error
#Line Number: 158	  # Categorical variables: try a built-in palette (based on colorbrewer2.org) (scale_color_brewer()):
#Line Number: 160	  # How about using the Tableau colors (but you need the library ggthemes):
#Line Number: 162	  # Color choice with continuous variables (scale_color_gradient(), scale_color_gradient2())
#Line Number: 168	### Working with annotation - page 47 of the Beautiful Plots pdf
#Line Number: 169	  # Add text annotation in the top-right, top-left etc. (annotation_custom() andtextGrob())
#Line Number: 170	  # The grobTreefunction (from grid) creates a grid graphical object and textGrobcreates the text graphical object. The annotation_custom() function comes from ggplot2and is designed to use a grob as input.
#Line Number: 178	### Working with coordinates - page 49 of the Beautiful Plots pdf
#Line Number: 183	### Working with plot types - page 50 of the Beautiful Plots pdf
#Line Number: 184	  # Box plot
#Line Number: 186	  # Alternative to a box plot: plot of points
#Line Number: 193	  # Alternative to a box plot: violin plot perhaps (geom_violin())
#Line Number: 199	  # Add a ribbon to your plot (geom_ribbon())
#Line Number: 201	  # The following are commented out because they take a very long time to run.
#Line Number: 202	  # ggplot(joindf, aes(x=year(SALES_DATE), y=tbl)) + geom_line()
#Line Number: 204	  # ggplot(joindf, aes(x=year(SALES_DATE), y=tbl)) + geom_line() + geom_ribbon(aes(ymin=0,ymax=tbl),fill="lightpink3")
#Line Number: 206	### Working with smooths - page 60 of the Beautiful Plots pdf
# End Table of Contents

require("tidyr")
require("dplyr")
require("jsonlite")
i = 'cut'
r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\", count(*) n from DIAMONDS group by \\\""i"\\\" "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
names(r) <- c("x", "n")
### Working with the title - page 4 of the Beautiful Plots pdf
g <- ggplot(r, aes(x=x, y=n)) + geom_point(color="firebrick"); g
  # Add a title
g <- g + ggtitle('Cut'); g
  # or
g + labs(title='Cut')
  # Make title bold and add a little space at the baseline (face,vjust)
g <- g + theme(plot.title=element_text(size=20, face="bold", vjust=2)); g
  # Use a non-traditional font in your title (family)
library(extrafont)
g <- g + theme(plot.title=element_text(size=30, face="bold", vjust=1, family="Bauhaus93")); g
  # Change spacing in multi-line text (lineheight)
g <- g + labs(title='This is a longer\ntitle than expected'); g
g <- g + theme(plot.title=element_text(size=30, face="bold", vjust=1, lineheight=1.0)); g
### Working with axes - page 8 of the Beautiful Plots pdf
  # Add x and y axis labels (labs(),xlab())
g <- g + labs(x="Cut", y=paste("Cut", "Numbers")); g
  # Get rid of axis ticks and tick text (theme(),axis.ticks.y)
g + theme(axis.ticks.y=element_blank(), axis.text.y=element_blank())
  # Change size of and rotate tick text (axis.text.x)
g <- g + theme(axis.text.x=element_text(angle=50, size=20, vjust=0.5)); g
  # Move the labels away from the plot (and add color) (theme(), axis.title.x)
g <- g + theme(
  axis.title.x=element_text(color="forestgreen", vjust=0.35),
  axis.title.y=element_text(color="cadetblue", vjust=0.35)
); g 
  # Limit an axis to a range (ylim(),scale_x_continuous(), coord_cartesian())
g + ylim(c(0,10000))
  # or
g + scale_y_continuous(limits=c(0,10000))
  # Use a function to alter labels (label=function(x){})
g + scale_y_continuous(label=function(x){return(paste("My cut number is ",x))}, limits=c(0,10000))

r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\"clarity\\\", \\\""x"\\\", count(*) n from DIAMONDS group by \\\"clarity\\\", \\\""x"\\\" "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', x=i),verbose = TRUE)))

### Working with Legends - page 15 of the Beautiful Plots pdf
names(r) <- c("legend", "x", "n")
g <- ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_point(); g
g <- g + labs(title='Cut') +
  labs(x="Cut", y=paste("Cut", "Numbers")) + 
  theme(
    axis.title.x=element_text(color="forestgreen", vjust=0.35),
    axis.title.y=element_text(color="cadetblue", vjust=0.35)
  ); g
  # Turn off the legend title (legend.title)
g + theme(legend.title=element_blank())
  # Change the styling of the legend title (legend.title)
g + theme(legend.title=element_text(colour="chocolate",size=16,face="bold"))
  # Change the title of the legend (name), this also splits the legends
g + scale_color_discrete(name="The types of\nclarity are:")
  # Change the background boxes in the legend (legend.key)
s <- g + theme(legend.key=element_rect(fill='blue')); s
s <- g + theme(legend.key=element_rect(fill=NA)); s
  # Change the size of the symbols in the legend only (guides(), guide_legend)
g + guides(colour=guide_legend(override.aes=list(size=6)), show_guide=FALSE)
  # This is a bad example but it shows how to turn off a legend layer.
s <- g + geom_histogram(aes(x=x)); s 
s <- g + geom_histogram(aes(x=x), show_guide=FALSE); s
  # Manual Legends - page 23 of the Beautiful Plots pdf
g <- ggplot(r, aes(x=x, y=n)) + geom_line(color="grey") + geom_point(color="red"); g
g <- g + geom_line(aes(color="Important line")) + geom_point(aes(color="My points")); g
g <- g + scale_colour_manual(name='',values=c('Important line'='red','My points'='blue')); g
### Background Colors - page 27 of the Beautiful Plots pdf
g <- ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_point(); g
  # Change the panel color (panel.background)
g <- g + theme(panel.background=element_rect(fill='grey75')); g
  # Change the grid lines (panel.grid.major)
g <- g + theme(
    panel.grid.major=element_line(colour="orange",size=2),
    panel.grid.minor=element_line(colour="blue")); g
  # Change the plot background (not the panel) color (plot.background)
g <- g + theme(plot.background=element_rect(fill='blue')); g
### Creating multi-panel plots - page 30 of the Beautiful Plots pdf
  # Changing the plot margin (plot.margin)
g <- g + theme(plot.margin=unit(c(1,6,1,6),"cm")); g
### Creating multi-panel plots - page 32 of the Beautiful Plots pdf
g <- ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_point() + facet_wrap(~legend,nrow=1); g
  # Allow scales to roam free (scales)
ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_point() + facet_wrap(~legend, nrow=1,scale="free")
  # Put two (potentially unrelated) plots side by side (pushViewport())
p1 <- ggplot(r, aes(x=legend, y=n, size=x, color=x)) + geom_point()
p2 <- ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_point()
require(grid)
pushViewport(viewport(layout=grid.layout(1,2)))
print(p1,vp=viewport(layout.pos.row=1,layout.pos.col=1))
print(p2,vp=viewport(layout.pos.row=1,layout.pos.col=2))
### Working with themes - page 37 of the Beautiful Plots pdf - see also https://github.com/jrnold/ggthemes
g <- ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_point() + facet_wrap(~legend,nrow=1); g
require(ggthemes)
g + theme_economist()+scale_colour_economist()
  # Creating a custom theme - See page 39 of the Beautiful Plots pdf
### Working with colors - page 41 of the Beautiful Plots pdf
  # Categorical variables: manually select the colors (scale_color_manual())
  # ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_point() + scale_color_manual(values=c("dodgerblue4", "darkolivegreen4", "darkorchid3", "goldenrod1")) # Uncomment this to get an error
ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_point() + 
  scale_color_manual(values=c("dodgerblue4","darkolivegreen4", "darkorchid3", "goldenrod1", "blue","green","yellow","red"))
  # Categorical variables: try a built-in palette (based on colorbrewer2.org) (scale_color_brewer()):
ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_point() + scale_color_brewer(palette="Set1")
  # How about using the Tableau colors (but you need the library ggthemes):
ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_point() + scale_colour_tableau()
  # Color choice with continuous variables (scale_color_gradient(), scale_color_gradient2())
ggplot(r, aes(x=x, y=n, color=n)) + geom_point() + scale_color_gradient(low="darkkhaki",high="darkgreen")

mid <- mean(r$n)
ggplot(r, aes(x=x, y=n, color=n)) + geom_point() +
  scale_color_gradient2(midpoint=mid, low="green", mid= "yellow",high="red")
### Working with annotation - page 47 of the Beautiful Plots pdf
  # Add text annotation in the top-right, top-left etc. (annotation_custom() andtextGrob())
  # The grobTreefunction (from grid) creates a grid graphical object and textGrobcreates the text graphical object. The annotation_custom() function comes from ggplot2and is designed to use a grob as input.

require(grid)
my_grob=grobTree(textGrob("This text stays in place!",x=0.1, y=0.95,hjust=0, gp=gpar(col="blue",fontsize=15,fontface="italic")))
g <- ggplot(r, aes(x=x, y=n, color=n)) + geom_point() +
  scale_color_gradient2(midpoint=mid, low="green", mid= "yellow",high="red") +
  annotation_custom(my_grob); g
g + facet_wrap(~legend)
### Working with coordinates - page 49 of the Beautiful Plots pdf
g <- ggplot(r, aes(x=x, y=n, color=n)) + geom_point() +
  scale_color_gradient2(midpoint=mid, low="green", mid= "yellow",high="red") +
  facet_wrap(~legend); g
g + coord_flip()
### Working with plot types - page 50 of the Beautiful Plots pdf
  # Box plot
ggplot(r, aes(x=x, y=n)) + geom_boxplot(fill="darkseagreen4")
  # Alternative to a box plot: plot of points
p1 <- ggplot(r, aes(x=x, y=n)) + geom_point()
p2 <- ggplot(r, aes(x=x, y=n)) + geom_jitter(alpha=1,aes(color=legend),position=position_jitter(width=.3))
require(grid)
pushViewport(viewport(layout=grid.layout(1,3)))
print(p1,vp=viewport(layout.pos.row=1,layout.pos.col=1))
print(p2,vp=viewport(layout.pos.row=1,layout.pos.col=2:3))
  # Alternative to a box plot: violin plot perhaps (geom_violin())
g <- ggplot(r, aes(x=x, y=n)) + geom_jitter(alpha=1,aes(color=legend),position=position_jitter(width=.1)) + geom_violin(alpha=0.5,color="gray"); g
g + coord_flip()

joindf <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from DIAMONDS d join diam_sale s on (d.\\\"diamond_id\\\" = s.diamond_id) join diam_retailer r on (s.retailer_id = r.retailer_id)"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

  # Add a ribbon to your plot (geom_ribbon())
require(lubridate)
  # The following are commented out because they take a very long time to run.
  # ggplot(joindf, aes(x=year(SALES_DATE), y=tbl)) + geom_line()

  # ggplot(joindf, aes(x=year(SALES_DATE), y=tbl)) + geom_line() + geom_ribbon(aes(ymin=0,ymax=tbl),fill="lightpink3")

### Working with smooths - page 60 of the Beautiful Plots pdf
ggplot(joindf, aes(x=day(SALES_DATE), y=tbl)) + geom_point() + stat_smooth()
