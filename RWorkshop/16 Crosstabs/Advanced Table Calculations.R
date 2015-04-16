df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select row_id, department, category, sales, EXTRACT(YEAR FROM TO_DATE(order_date, \\\'yyyy-mm-dd\\\')) year
from Adv_Xtabs_Superstore_Sub_Excel order by 2"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Tableau', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

sdf <- spread(df, YEAR, SALES) %>% select(2,3,4,5,6,7) %>% group_by(DEPARTMENT, CATEGORY) %>% arrange(DEPARTMENT)
tbl_df(sdf)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select * from (select department, category, sales, EXTRACT(YEAR FROM TO_DATE(order_date, \\\'yyyy-mm-dd\\\')) year
                from Adv_Xtabs_Superstore_Sub_Excel)
PIVOT (SUM(sales) AS sum_sales FOR (year) IN (2010, 2011, 2012, 2013))
order by 1"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Tableau', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); df

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select * from (select department, category, sales, EXTRACT(YEAR FROM TO_DATE(order_date, \\\'yyyy-mm-dd\\\')) year
               from Adv_Xtabs_Superstore_Sub_Excel)
PIVOT (avg(sales) AS avg_sales FOR (year) IN (2010, 2011, 2012, 2013))
order by 1"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Tableau', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); df

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select * from (select department, category, sales, EXTRACT(YEAR FROM TO_DATE(order_date, \\\'yyyy-mm-dd\\\')) year
               from Adv_Xtabs_Superstore_Sub_Excel)
PIVOT (sum(sales) AS sum_sales, avg(sales) AS avg_sales FOR (year) IN (2010, 2011, 2012, 2013))
order by 1"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Tableau', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); df

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select department, category, round(((x2011_avg_sales - x2010_avg_sales) / x2010_avg_sales), 3) as YoY2011,
                              round(((x2012_avg_sales - x2011_avg_sales) / x2011_avg_sales), 3) as YoY2012,
                              round(((x2013_avg_sales - x2012_avg_sales) / x2012_avg_sales), 3) as YoY2013
from 
   (select * from (select department, category, sales, EXTRACT(YEAR FROM TO_DATE(order_date, \\\'yyyy-mm-dd\\\')) year
                   from Adv_Xtabs_Superstore_Sub_Excel)
   PIVOT (avg(sales) AS avg_sales FOR (year) IN (2010 as x2010, 2011 as x2011, 2012 as x2012, 2013 as x2013))
   order by 1)"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Tableau', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); df

ggplot(df, aes(x = CATEGORY, y = YOY2011)) + geom_bar(stat="identity")