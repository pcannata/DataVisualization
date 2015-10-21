# The following is equivalent to KPI Story 2 Sheet 2 and Parameters Story 3 in "Crosstabs, KPIs, Barchart.twb"

# These will be made to more resemble Tableau Parameters when we study Shiny.
KPI_Low_Max_value = 4750     
KPI_Medium_Max_value = 5000

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select color, clarity, sum_price, round(sum_carat) as sum_carat, kpi as ratio, 
case
when kpi < "p1" then \\\'03 Low\\\'
when kpi < "p2" then \\\'02 Medium\\\'
else \\\'01 High\\\'
end kpi
from (select color, clarity, 
   sum(price) sum_price, sum(carat) sum_carat, 
   sum(price) / sum(carat) kpi
   from diamonds
   group by color, clarity)
order by clarity;"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_UTEid', PASS='orcl_UTEid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=KPI_Low_Max_value, p2=KPI_Medium_Max_value), verbose = TRUE))); View(df)

# df <- diamonds %>% group_by(color, clarity) %>% summarize(sum_price = sum(price), sum_carat = sum(carat)) %>% mutate(ratio = sum_price / sum_carat) %>% mutate(kpi = ifelse(ratio <= KPI_Low_Max_value, '03 Low', ifelse(ratio <= KPI_Medium_Max_value, '02 Medium', '01 High'))) %>% rename(COLOR=color, CLARITY=clarity, SUM_PRICE=sum_price, SUM_CARAT=sum_carat, RATIO=ratio, KPI=kpi)

spread(df, COLOR, SUM_PRICE) %>% View

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Diamonds Crosstab\nSUM_PRICE, SUM_CARAT, SUM_PRICE / SUM_CARAT') +
  labs(x=paste("COLOR"), y=paste("CLARITY")) +
  layer(data=df, 
        mapping=aes(x=COLOR, y=CLARITY, label=SUM_PRICE), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black"), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=COLOR, y=CLARITY, label=SUM_CARAT), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", vjust=2), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=COLOR, y=CLARITY, label=round(RATIO, 2)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", vjust=4), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=COLOR, y=CLARITY, fill=KPI), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.50), 
        position=position_identity()
  )

# The following is equivalent to Windowing Story 5 Sheet 4 in "Crosstabs, KPIs, Barchart.twb"

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select color, clarity, avg_price, 
avg(avg_price) 
OVER (PARTITION BY clarity ) as window_avg_price
from (select color, clarity, avg(price) avg_price
   from diamonds
   group by color, clarity)
order by clarity;"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_UTEid', PASS='orcl_UTEid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=KPI_Low_Max_value, p2=KPI_Medium_Max_value), verbose = TRUE))); View(df)

# df <- diamonds %>% group_by(color, clarity) %>% summarize(AVG_PRICE = mean(price)) %>% rename(COLOR=color, CLARITY=clarity)
# df1 <- df %>% ungroup %>% group_by(CLARITY) %>% summarize(WINDOW_AVG_PRICE=mean(AVG_PRICE))
# df <- inner_join(df, df1, by="CLARITY")

spread(df, COLOR, AVG_PRICE) %>% View

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  facet_wrap(~CLARITY, ncol=1) +
  labs(title='Diamonds Crosstab') +
  labs(x=paste("COLOR"), y=paste("AVG_PRICE")) +
  layer(data=df, 
        mapping=aes(x=COLOR, y=AVG_PRICE), 
        stat="identity", 
        stat_params=list(), 
        geom="bar",
        geom_params=list(colour="blue"), 
        position=position_identity()
  ) + coord_flip() +
  layer(data=df, 
        mapping=aes(x=COLOR, y=AVG_PRICE, label=round(AVG_PRICE)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", hjust=-0.5), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=COLOR, y=AVG_PRICE, label=round(WINDOW_AVG_PRICE)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", hjust=-2), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=COLOR, y=AVG_PRICE, label=round(AVG_PRICE - WINDOW_AVG_PRICE)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", hjust=-5), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(yintercept = WINDOW_AVG_PRICE), 
        geom="hline",
        geom_params=list(colour="red")
  ) 
