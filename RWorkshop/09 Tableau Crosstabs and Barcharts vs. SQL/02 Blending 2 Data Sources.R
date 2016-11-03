require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)

# The following is equivalent to "04 Blending 2 Data Sources.twb"

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'oraclerest.cs.utexas.edu:5001/rest/native/?query=
"""select region || \\\' \\\' || \\\'Sales\\\' as measure_names, sum(sales) as measure_values from SUPERSTORE_SALES_ORDERS
where country_region = \\\'United States of America\\\'
group by region
union all
select market || \\\' \\\' || \\\'Coffee_Sales\\\' as measure_names, sum(coffee_sales) as measure_values from COFFEE_CHAIN
group by market
order by 1;"""
')), httpheader=c(DB='jdbc:oracle:thin:@aevum.cs.utexas.edu:1521/f16pdb', USER='cs329e_UTEid', PASS='orcl_uteid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); View(df)

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  #facet_wrap(~CLARITY, ncol=1) +
  labs(title='Blending 2 Data Sources') +
  labs(x=paste("Region Sales"), y=paste("Sum of Sales")) +
  layer(data=df, 
        mapping=aes(x=MEASURE_NAMES, y=MEASURE_VALUES),
        geom="bar",
        params=list(colour="blue"), 
        position=position_identity(),
        stat="identity",  
  ) + coord_flip() +
  layer(data=df, 
        mapping=aes(x=MEASURE_NAMES, y=MEASURE_VALUES, label=round(MEASURE_VALUES)), 
        stat="identity",  
        geom="text",
        params=list(colour="black", hjust=-0.5), 
        position=position_identity()
  ) 