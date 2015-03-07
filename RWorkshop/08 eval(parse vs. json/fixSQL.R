fixSQL <- function(sql) {
  require(stringr)
  s <- str_replace_all(sql, "\"", "\\\\\\\"")
  s1 <- str_replace_all(s, '\'', '\\\\\'')
  s2 <- str_replace_all(s1, '`', '"')
  s2
}

s <- fixSQL("select \"cut\", `i` from 'dual'")
s