require("jsonlite")
require(dplyr)

ddf <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from DIAMONDS"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE))); tbl_df(ddf)

sdf <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from diam_sale"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE))); tbl_df(sdf)

rdf <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from diam_retailer"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE))); tbl_df(rdf)

names(ddf);names(sdf);names(rdf)
# inner_join(ddf, sdf, by = "DIAMOND_ID") %>% tbl_df # This gives an error - cannot join on columns 'DIAMOND_ID' x 'DIAMOND_ID': index out of bounds
colnames(ddf) <- toupper(names(ddf)); dsdf <- inner_join(ddf, sdf, by = "DIAMOND_ID"); inner_join(dsdf, rdf, by = "RETAILER_ID") %>% tbl_df

colnames(ddf) <- toupper(names(ddf)); inner_join(ddf, sdf, by = "DIAMOND_ID") %>% inner_join(., rdf, by = "RETAILER_ID") %>% ggplot(aes(x=CARAT, y = NAME, color = CUT)) + geom_point()
                                                                                                                                        
joindf <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from DIAMONDS d join diam_sale s on (d.\\\"diamond_id\\\" = s.diamond_id) join diam_retailer r on (s.retailer_id = r.retailer_id)"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE))); joindf %>% ggplot(aes(x=carat, y = NAME, color = cut)) + geom_point()
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                

