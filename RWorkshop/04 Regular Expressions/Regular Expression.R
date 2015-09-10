tbl_df(diamonds)
require(stringr)
Good <- with(diamonds, str_detect(string=cut, pattern="Good"))
Good %>% head
names(diamonds)
diamonds[Good, c('carat', 'cut', 'color')] %>% tbl_df
diamonds[!Good, c('carat', 'cut', 'color')] %>% tbl_df

# Ignore case while searching
Good <- with(diamonds, str_detect(string=cut, pattern=ignore.case("good")))
Good %>% head
names(diamonds)
diamonds[Good, c('carat', 'cut', 'color')] %>% tbl_df

# Using grep instead of str_detect
# Twelve characters have special meanings in grep regular expressions: the backslash \, the caret ^, the dollar sign $, the period or dot ., the vertical bar or pipe symbol |, the question mark ?, the asterisk or star *, the plus sign +, the opening parenthesis (, the closing parenthesis ), the  square brackets [], and the curly braces {} (I don't have an example of this). These special characters are often called "metacharacters".                                                                                                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                                                                                                        
with(diamonds, grep("Good", cut, perl=TRUE, value=FALSE)) %>% diamonds[., c('carat', 'cut', 'color')] %>% tbl_df
with(diamonds, grep("G+", cut, perl=TRUE, value=FALSE)) %>% diamonds[., c('carat', 'cut', 'color')] %>% tbl_df
with(diamonds, grep("^G+", cut, perl=TRUE, value=FALSE)) %>% diamonds[., c('carat', 'cut', 'color')] %>% tbl_df
with(diamonds, grep("^G..d", cut, perl=TRUE, value=FALSE)) %>% diamonds[., c('carat', 'cut', 'color')] %>% tbl_df
with(diamonds, grep("^Go*d", cut, perl=TRUE, value=FALSE)) %>% diamonds[., c('carat', 'cut', 'color')] %>% tbl_df
with(diamonds, grep("^G.*d", cut, perl=TRUE, value=FALSE)) %>% diamonds[., c('carat', 'cut', 'color')] %>% tbl_df
with(diamonds, grep("^Go+d", cut, perl=TRUE, value=FALSE)) %>% diamonds[., c('carat', 'cut', 'color')] %>% tbl_df
with(diamonds, grep("^[Gg]o+d", cut, perl=TRUE, value=FALSE)) %>% diamonds[., c('carat', 'cut', 'color')] %>% tbl_df
with(diamonds, grep("^[Gg]o+d|Fair", cut, perl=TRUE, value=FALSE)) %>% diamonds[., c('carat', 'cut', 'color')] %>% tbl_df
with(diamonds, grep("(Very|Highly) Good", cut, perl=TRUE, value=FALSE)) %>% diamonds[., c('carat', 'cut', 'color')] %>% tbl_df

# Changing column values based upon a regular expression
# d <- with(diamonds, gsub("(Very|Highly) Good", "Great", cut)) %>% diamonds["cut", .]
