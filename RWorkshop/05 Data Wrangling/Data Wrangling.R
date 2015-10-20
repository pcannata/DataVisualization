require(tidyr)
require(dplyr)
require(ggplot2)

tbl_df(diamonds)
View(diamonds)

# select
select(diamonds, cut, clarity) %>% tbl_df # Equivalent SQL: select cut, clarity from diamonds;
diamonds %>% select(cut, clarity) %>% tbl_df
diamonds %>% select(., cut, clarity) %>% tbl_df
diamonds %>% select(color:price) %>% tbl_df # Equivalent SQL: none
diamonds %>% select(-cut, -clarity) %>% tbl_df # Equivalent SQL: none
x <- diamonds %>% select(cut, clarity) %>% tbl_df
x

# filter
diamonds %>% select(cut, clarity) %>% filter(cut == "Good") %>% tbl_df # Equivalent SQL: select cut, clarity from diamonds where cut = 'Good';
diamonds %>% select(cut, clarity) %>% filter(cut %in% c("Good", "Fair")) %>% tbl_df # Equivalent SQL: select cut, clarity from diamonds where cut in ('Good', 'Fair');# or Equivalent SQL:  select cut, clarity from diamonds where cut = 'Good' or cut = 'Fair';
diamonds %>% select(cut, clarity) %>% filter(cut %in% c("Good", "Fair"), clarity == "VS1") %>% tbl_df # Equivalent SQL:  select cut, clarity from diamonds where (cut = 'Good' or cut = 'Fair') and clarity = 'VS1';
diamonds %>% select(cut, clarity) %>% filter(cut %in% c("Good", "Fair"), clarity == "VS1" | is.na(cut)) %>% tbl_df # Equivalent SQL:  select cut, clarity from diamonds where ((cut = 'Good' or cut = 'Fair') and clarity = 'VS1') or cut is null;
# diamonds %>% select(cut, clarity) %>% filter(carat > 2) %>% tbl_df # This will give an error
# Equivalent SQL:  select cut, clarity  from diamonds  where carat > 2;
diamonds %>% filter(carat > 2) %>% select(cut, clarity) %>% tbl_df # This does not give an error.
diamonds %>% select(carat, clarity) %>% filter(carat > 2) %>% tbl_df # Equivalent SQL:  select carat, clarity  from diamonds  where carat > 2;

# arrange
data.frame(x=c(1,1,1,2,2), y=c(5:1), z=(1:5)) %>% arrange(desc(x)) %>% tbl_df
data.frame(x=c(1,1,1,2,2), y=c(5:1), z=(1:5)) %>% arrange(desc(x), y) %>% tbl_df
diamonds %>% arrange(carat) %>% tbl_df # Equivalent SQL:  select * from diamonds order by carat;
diamonds %>% arrange(desc(carat)) %>% tbl_df # Equivalent SQL:select * from diamonds order by carat desc;

# rename
diamonds %>% rename(tbl= table) %>% tbl_df # Equivalent: select tbl as "table" from diamonds;

# mutate
diamonds %>% select(cut, clarity, x, y, z) %>% filter(cut %in% c("Good", "Fair"), clarity == "VS1" | is.na(cut)) %>% mutate(sum = x+y+z) %>% tbl_df # Equivalent: select cut, clarity, x+y+z as sum from diamonds where ((cut = 'Good' or cut = 'Fair') and clarity = 'VS1') or cut is null
ndf <- diamonds %>% select(cut, clarity, x, y, z) %>% filter(cut %in% c("Good", "Fair"), clarity == "VS1" | is.na(cut)) %>% mutate(sum = x+y+z) %>% tbl_df
ndf

# Useful mutate functions:
    # diamonds$ID<-seq.int(nrow(diamonds)) # Add a sequince number column
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

pmin(1:5, 5:1) # Pairwise min
diamonds %>% mutate(minxy = pmin(x,y)) %>% tbl_df
pmax(1:5, 5:1) # Pairwise max
c(1,1,2,0,4,3,5) %>% cummin()
diamonds %>% mutate(cummin_x = cummin(x)) %>% tbl_df
c(1,1,2,5,4,3,5) %>% cummax()
c(1,1,2,3,4,3,5) %>% cumsum()
diamonds %>% arrange(x) %>% mutate(cumsum_x = cumsum(x)) %>% ggplot(aes(x = x, y = cumsum_x)) + geom_point()
c(1,1,2,3,4,3,5) %>% cumprod()
c(1,1,2,3,4,3,5) %>% between(2,4)
diamonds %>% mutate(between_x = between(x,4,4.1)) %>% tbl_df
c(1:5) %>% cummean()
c(1:5) %>% lead()
c(1:5) %>% lead() - c(1:5)
diamonds %>% mutate(lead_z = lead(z)-z) %>% tbl_df
c(1:5) %>% lag()
c(1:5) %>% lag() - c(1:5)
diamonds %>% mutate(lag_z = z-lag(z)) %>% tbl_df
c(1:10)
c(1:10) %>% ntile(4) # bucket edges are rounded
diamonds %>% mutate(ntile_z = ntile(z,100)) %>% arrange(desc(ntile_z)) %>% tbl_df
diamonds %>% mutate(ntile_z = ntile(z,100)) %>% group_by(ntile_z) %>% summarise(n=n()) %>% tbl_df

c(1,1,2,5,4,3,5) %>% cume_dist()
c(1:5) %>% cume_dist()
c(1,1:5) %>% cume_dist()
# c(TRUE, TRUE, FALSE, FALSE, TRUE) %>% cumall()
# c(FALSE, TRUE, FALSE, FALSE, TRUE) %>% cumany()
# Now let's try them in the mutate function
diamonds %>% mutate(price_percent = cume_dist(price)) %>% arrange(desc(price_percent)) %>% tbl_df # Equivalent SQL: 
# select d.*, cume_dist() OVER (order by price) cume_dist from diamonds d order by 11 desc;
# select d.*, cume_dist() OVER (PARTITION BY cut order by price) cume_dist from (select * from diamonds where rownum < 100) d order by cut desc, 11 desc;
# Can also try rank(), last_value, nth_value

bottom20_diamonds <- diamonds %>% mutate(price_percent = cume_dist(price)) %>% filter(price_percent <= .20) %>% arrange(desc(price_percent)) %>% tbl_df
diamonds %>% mutate(price_percent = cume_dist(price)) %>% filter(price_percent >= .80) %>% arrange(desc(price_percent)) %>% tbl_df
top20_diamonds <- diamonds %>% mutate(price_percent = cume_dist(price)) %>% filter(price_percent >= .80) %>% arrange(desc(price_percent)) %>% tbl_df
diamonds %>% mutate(price_percent = cume_dist(price)) %>% filter(price_percent <= .20 | price_percent >= .80) %>% ggplot(aes(x = price, y = carat, color = cut)) + geom_point()

# summarize (summarise)
diamonds %>% summarize(max_price = max(price)) # Equivalent SQL:select max(price) as max_price from diamonds;
diamonds %>% summarize(mean = mean(x), sum = sum(x,y,z), n = n()) # Equivalent SQL:select avg(x) as avg, sum(x)+sum(y)+sum(z) as sum, count(*) as n from diamonds;
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

# group_by
d <- diamonds %>% group_by(cut,color) %>% summarise(n = n()) %>% arrange(n) %>% tbl_df # Equivalent SQL: select cut, color, count(*) n from diamonds group by cut, color order by n;
diamonds %>% group_by(cut,color) %>% summarise(mean = mean(x), sum = sum(x,y,z), n = n())
diamonds %>% group_by(cut,color) %>% summarise(mean = mean(x), sum = sum(x,y,z), n = n()) %>% ungroup %>% summarize(sum(n))

diamonds %>% group_by(cut,color) %>% summarise(mean = mean(x), sum = sum(x,y,z), n = n()) %>% arrange(n)
diamonds %>% group_by(cut,color) %>% summarise(mean = mean(x), sum = sum(x,y,z), n = n()) %>% arrange(desc(n), cut, color)

diamonds %>% group_by(cut, color, clarity) %>% summarise(mean_carat = mean(carat)) %>% ggplot(aes(x=cut, y=mean_carat, color=color)) + geom_point() + facet_wrap(~clarity)

# reshaping - see 00 Overview/Overview.R
require(tidyr)
diamonds$ID<-seq.int(nrow(diamonds))
head(diamonds) 
head(diamonds) %>% select(ID, cut, color) %>% gather(variable, value, -ID) %>% tbl_df
# head(diamonds) %>% select(ID, cut, color) %>% gather(variable, value, -ID) %>% gather(variable, value) %>% spread(variable, value) %>% tbl_df

