# for (i in c("cut", "color", "clarity")) {group_by(diamonds, i) %>% summarize(n=n()) %>% tbl_df}

require("tidyr")
require("dplyr")
require("jsonlite")
q='Good'
r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from diamonds where \\\"cut\\\" = \\\'"q"\\\'"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q),verbose = TRUE)))

myplot <- function(df, x) {
  names(df) <- c("x", "n")
  ggplot(df, aes(x=x, y=n)) + geom_point()
}

categoricals <- eval(parse(text=substring(getURL(URLencode('http://129.152.144.84:5001/rest/native/?query="select * from diamonds"'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Diamonds', PASS='orcl', MODE='native_mode', MODEL='model', returnFor = 'R', returnDimensions = 'True'), verbose = TRUE), 1, 2^31-1)))

ddf <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from DIAMONDS"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)));

l <- list()
for (i in names(ddf)) { 
  if (i %in% categoricals[[1]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\", count(*) n from DIAMONDS group by \\\""i"\\\" "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- myplot(r,i)
    print(p) 
    l[[i]] <- p
  }
}

png("/Users/pcannata/Mine/UT/GitRepositories/DataVisualization/RWorkshop/00 Doc/categoricals.png", width = 25, height = 10, units = "in", res = 72)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 12)))   

print(l[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:4))
print(l[[2]], vp = viewport(layout.pos.row = 1, layout.pos.col = 5:8))
print(l[[3]], vp = viewport(layout.pos.row = 1, layout.pos.col = 9:12))

dev.off()


myplot1 <- function(df, x) {
  names(df) <- c("x")
  ggplot(df, aes(x=x)) + geom_histogram()
}
l <- list()
for (i in names(ddf)) {   
  # For details on [[...]] below, see http://stackoverflow.com/questions/1169456/in-r-what-is-the-difference-between-the-and-notations-for-accessing-the
  if (i %in% categoricals[[2]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\" from diamonds where \\\""i"\\\" is not null "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- myplot1(r,i)
    print(p) 
    l[[i]] <- p
  }
}

png("/Users/pcannata/Mine/UT/GitRepositories/DataVisualization/RWorkshop/00 Doc/categoricals2.png", width = 25, height = 20, units = "in", res = 72)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 12)))   

print(l[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:3))
print(l[[2]], vp = viewport(layout.pos.row = 1, layout.pos.col = 4:6))
print(l[[3]], vp = viewport(layout.pos.row = 1, layout.pos.col = 7:9))
print(l[[4]], vp = viewport(layout.pos.row = 1, layout.pos.col = 10:12))
print(l[[5]], vp = viewport(layout.pos.row = 2, layout.pos.col = 1:3))
print(l[[6]], vp = viewport(layout.pos.row = 2, layout.pos.col = 4:6))
print(l[[7]], vp = viewport(layout.pos.row = 2, layout.pos.col = 7:9))
print(l[[8]], vp = viewport(layout.pos.row = 2, layout.pos.col = 10:12))

dev.off()