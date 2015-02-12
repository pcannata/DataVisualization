require(tidyr)
require(dplyr)

tbl_df(diamonds)
View(diamonds)
select(diamonds, cut, clarity)
diamonds %>% select(cut, clarity)
x <- diamonds %>% select(cut, clarity) %>% tbl_df
diamonds %>% select(cut, clarity) %>% filter(cut == "Good") %>% tbl_df
diamonds %>% select(cut, clarity) %>% filter(cut %in% c("Good", "Fair")) %>% tbl_df
diamonds %>% select(cut, clarity) %>% filter(cut %in% c("Good", "Fair"), clarity == "VS1") %>% tbl_df
diamonds %>% select(cut, clarity) %>% filter(cut %in% c("Good", "Fair"), clarity == "VS1" | is.na(cut)) %>% tbl_df

diamonds %>% select(cut, clarity, x, y, z) %>% filter(cut %in% c("Good", "Fair"), clarity == "VS1" | is.na(cut)) %>% tbl_df
diamonds %>% select(cut, clarity, x, y, z) %>% filter(cut %in% c("Good", "Fair"), clarity == "VS1" | is.na(cut)) %>% mutate(sum = x+y+z) %>% tbl_df
ndf <- diamonds %>% select(cut, clarity, x, y, z) %>% filter(cut %in% c("Good", "Fair"), clarity == "VS1" | is.na(cut)) %>% mutate(sum = x+y+z) %>% tbl_df
ndf

# Useful mutate functions:
    # pmin(), pmax() Parallel, Element-wise min and max
    # cummin(), cummax() Cumulative min and max
    # cumsum(), cumprod() Cumulative sum and product
  # Windowing functions
    # between() Are values between a and b?
    # cume_dist() Cumulative distribution of values
    # cumall(), cumany() Cumulative all and any
    # cummean() Cumulative mean
    # lead(), lag() Copy with values one position
    # ntile() Bin vector into n buckets
    # dense_rank(), min_rank(),
    # percent_rank(), row_number() Various ranking methods

pmin(c(1:5), (5:1))
pmax(c(1:5), (5:1))
c(1,1,2,0,4,3,5) %>% cummin()
c(1,1,2,5,4,3,5) %>% cummax()
c(1,1,2,3,4,3,5) %>% cumsum()
c(1,1,2,3,4,3,5) %>% cumprod()

c(1,1,2,3,4,3,5) %>% between(2,4)
c(1,1,2,5,4,3,5) %>% cume_dist()
c(1:5) %>% cume_dist()
c(1,1:5) %>% cume_dist()
# c(TRUE, TRUE, FALSE, FALSE, TRUE) %>% cumall()
# c(FALSE, TRUE, FALSE, FALSE, TRUE) %>% cumany()
c(1:5) %>% cummean()
c(1:5) %>% lead() - c(1:5)
 c(1:5) %>% lag() - c(1:5)
c(1:10)
c(1:10) %>% ntile(4) # bucket edges are rounded

# Now let's try them in the mutate function
diamonds %>% mutate(price_percent = cume_dist(price)) %>% filter(price_percent <= .20) %>% arrange(desc(price_percent)) %>% tbl_df

TopBottom20_diamonds <- diamonds %>% mutate(price_percent = cume_dist(price)) %>% filter(price_percent <= .20 | price_percent >= .80)
ggplot(TopBottom20_diamonds, aes(x = price, y = carat)) + geom_point(aes(color=cut))

diamonds %>% mutate(minxy = pmin(x,y)) %>% tbl_df
diamonds %>% mutate(cummin_x = cummin(x)) %>% tbl_df
diamonds %>% mutate(cumsum_x = cumsum(x)) %>% tbl_df
diamonds %>% mutate(between_x = between(x,4,4.1)) %>% tbl_df
diamonds %>% mutate(between_x = lead(z)-z) %>% tbl_df
diamonds %>% mutate(between_x = lag(z)-z) %>% tbl_df
diamonds %>% mutate(between_x = ntile(z,100)) %>% tbl_df

# Useful Summary functions:
  # min(), max() Minimum and maximum values
  # mean() Mean value
  # median() Median value
  # sum() Sum of values
  # var, sd() Variance and standard deviation of a vector
  # first() First value in a vector
  # last() Last value in a vector
  # nth() Nth value in a vector
  # n() The number of values in a vector
  # n_distinct() The number of distinct values in a vector

diamonds %>% summarise(mean = mean(x), sum = sum(x,y,z), n = n())

diamonds %>% group_by(cut,color) %>% summarise(mean = mean(x), sum = sum(x,y,z), n = n())


# Order By
# arrange()
data.frame(x=c(1,1,1,2,2), y=c(5:1), z=(1:5)) %>% arrange(desc(x)) %>% tbl_df
data.frame(x=c(1,1,1,2,2), y=c(5:1), z=(1:5)) %>% arrange(desc(x),y) %>% tbl_df

diamonds %>% group_by(cut,color, clarity) %>% summarise(mean_carat = mean(carat)) %>% ggplot(aes(x=cut, y=mean_carat, color=color)) + geom_point() + facet_wrap(~clarity)

