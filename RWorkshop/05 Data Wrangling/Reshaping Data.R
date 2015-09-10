# install.packages("devtools")
# devtools::install_github("rstudio/EDAWR")
require(EDAWR)
?storms
?cases
?pollution
?tb
# Tidy Data is best, i.e., each variable is its own column and each observation is its own row. Which of the above dataframes is tidy?
storms # This is claimed to be tidy
cases  # This is claimed to be not tidy
tcases <- cases %>% gather(year, value, 2, 3, 4); tcases
utcases <- tcases %>% spread(year, value); utcases; cases

pollution # Is claimed to be untidy
tpollution <- pollution %>% spread(size, amount); tpollution
names(pollution)
utpollution <- tpollution %>% gather(size, amount, 2, 3); utpollution; pollution

