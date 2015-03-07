# devtools::install_github("ramnathv/htmlwidgets")
# devtools::install_github("bokeh/rbokeh")
require(rbokeh)
p <- figure() %>%
  ly_points(price, carat, data = diamonds,
            color = clarity, glyph = clarity,
            hover = list(price, carat))
p
