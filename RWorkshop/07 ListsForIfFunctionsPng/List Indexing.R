# An R List is like a Python Dictionary

l <- list(a = 1:10, b = 11:20)
l
l[1]
l[2]
l[[1]]
l[[2]]
l$a
l$b

ll <- list(1:10, 11:20)
ll
ll[1]
ll[2]
ll[[1]]
ll[[2]]

lll <- list()
lll
lll[['a']] <- 111
lll
lll[1]
lll[['a']]
lll[[1]]
