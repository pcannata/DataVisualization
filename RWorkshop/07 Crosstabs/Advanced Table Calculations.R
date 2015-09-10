df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select row_id, department, category, sales, EXTRACT(YEAR FROM TO_DATE(order_date, \\\'yyyy-mm-dd\\\')) year
from AdvTblCalcs order by 2"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Tableau', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

sdf <- spread(df, YEAR, SALES) %>% select(2,3,4,5,6,7) %>% group_by(DEPARTMENT, CATEGORY) %>% arrange(DEPARTMENT)
tbl_df(sdf)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select * from (select department, category, sales, EXTRACT(YEAR FROM TO_DATE(order_date, \\\'yyyy-mm-dd\\\')) year
                from Adv_Xtabs_Superstore_Sub_Excel)
PIVOT (SUM(sales) AS sum_sales FOR (year) IN (2010, 2011, 2012, 2013))
order by 1"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Tableau', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select * from (select department, category, sales, EXTRACT(YEAR FROM TO_DATE(order_date, \\\'yyyy-mm-dd\\\')) year
               from Adv_Xtabs_Superstore_Sub_Excel)
PIVOT (avg(sales) AS avg_sales FOR (year) IN (2010, 2011, 2012, 2013))
order by 1"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Tableau', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select * from (select department, category, sales, EXTRACT(YEAR FROM TO_DATE(order_date, \\\'yyyy-mm-dd\\\')) year
               from Adv_Xtabs_Superstore_Sub_Excel)
PIVOT (sum(sales) AS sum_sales, avg(sales) AS avg_sales FOR (year) IN (2010, 2011, 2012, 2013))
order by 1"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Tableau', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); df

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select rownum, DEPARTMENT || \\\' \\\' || CATEGORY as CATEGORY, X2010_SUM_SALES, X2011_SUM_SALES, X2012_SUM_SALES, X2013_SUM_SALES,
round(((x2011_avg_sales - x2010_avg_sales) / x2010_avg_sales), 3) as YoY2011,
round(((x2012_avg_sales - x2011_avg_sales) / x2011_avg_sales), 3) as YoY2012,
round(((x2013_avg_sales - x2012_avg_sales) / x2012_avg_sales), 3) as YoY2013
from 
   (select * from (select department, category, sales, EXTRACT(YEAR FROM TO_DATE(order_date, \\\'yyyy-mm-dd\\\')) year
                   from Adv_Xtabs_Superstore_Sub_Excel)
   PIVOT (sum(sales) AS sum_sales, avg(sales) AS avg_sales FOR (year) IN (2010 as x2010, 2011 as x2011, 2012 as x2012, 2013 as x2013))
   order by 1) t"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Tableau', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); df

require(scales) # This is needed for scale_y_continuous(labels = comma)
p0 <- ggplot(df, aes(x = reorder(CATEGORY, -ROWNUM), y = X2010_SUM_SALES)) + geom_bar(stat="identity") + scale_fill_gradient2(low='red', high='green') + scale_y_continuous(limits=c(0, 500000), labels=comma) + coord_flip() + theme(legend.position="none")
p1 <- ggplot(df, aes(x = reorder(CATEGORY, -ROWNUM), y = X2011_SUM_SALES, fill=YOY2011)) + geom_bar(stat="identity") + scale_fill_gradient2(low='red', high='green') + scale_y_continuous(limits=c(0, 500000), labels=comma) + coord_flip() + theme(axis.title.y=element_blank(), legend.position="none", axis.text.y=element_blank(), axis.ticks=element_blank())
p2 <- ggplot(df, aes(x = reorder(CATEGORY, -ROWNUM), y = X2012_SUM_SALES, fill=YOY2012)) + geom_bar(stat="identity") + scale_fill_gradient2(low='red', high='green') + scale_y_continuous(limits=c(0, 500000), labels=comma) + coord_flip() + theme(axis.title.y=element_blank(), legend.position="none", axis.text.y=element_blank(), axis.ticks=element_blank())
p3 <- ggplot(df, aes(x = reorder(CATEGORY, -ROWNUM), y = X2013_SUM_SALES, fill=YOY2013)) + geom_bar(stat="identity") + scale_fill_gradient2(low='red', high='green', name = "YoY Average Sales") + scale_y_continuous(limits=c(0, 500000), labels=comma) + coord_flip() + theme(axis.title.y=element_blank(), axis.text.y=element_blank(), axis.ticks=element_blank())
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 12)))   
print(p0, vp = viewport(layout.pos.row = 1, layout.pos.col = 1:4))  
print(p1, vp = viewport(layout.pos.row = 1, layout.pos.col = 5:6))
print(p2, vp = viewport(layout.pos.row = 1, layout.pos.col = 7:8))
print(p3, vp = viewport(layout.pos.row = 1, layout.pos.col = 9:11))
