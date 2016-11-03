df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select * from (
     select dept_nm department, cal_year year, amount spending from austin_city_spending)
PIVOT (sum(amount) AS sum_amount FOR (year) IN (2008 as x2008, 2009 as x2009, 2010 as x2010, 2011 as x2011, 2012 as x2012, 2013 as x2013, 2014 as x2014, 2015 as x2015))"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='cs370_jhk924', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

sdf <- spread(df, CAL_YEAR, SPENDING)

tbl_df(sdf)