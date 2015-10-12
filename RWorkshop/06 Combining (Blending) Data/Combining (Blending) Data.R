require("jsonlite")
require("RCurl")
require(dplyr)

emp <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from emp"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_UTEid', PASS='orcl_UTEid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
View(emp)

dept <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from dept"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_UTEid', PASS='orcl_UTEid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
View(dept)

dplyr::inner_join(emp, dept, by="DEPTNO") %>% View
df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select * 
from emp e join dept d
on e.deptno = d.deptno"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_UTEid', PASS='orcl_UTEid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

dplyr::left_join(emp, dept, by="DEPTNO") %>% View
df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select * 
from emp e left join dept d
on e.deptno = d.deptno"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_UTEid', PASS='orcl_UTEid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

dplyr::right_join(emp, dept, by="DEPTNO") %>% Viewdf <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select * 
from emp e right join dept d
on e.deptno = d.deptno"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_UTEid', PASS='orcl_UTEid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)
dplyr::full_join(emp, dept, by="DEPTNO") %>% View
df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select * 
from emp e full outer join dept d
on e.deptno = d.deptno"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_UTEid', PASS='orcl_UTEid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

oneDept <- dept %>% filter(DEPTNO == 10)
dplyr::semi_join(emp, oneDept, by="DEPTNO") %>% tbl_df
df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT *
FROM emp e
WHERE EXISTS
  (SELECT 1
   FROM   dept d
   WHERE  e.deptno = 10)
ORDER BY deptno;"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_UTEid', PASS='orcl_UTEid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

dplyr::anti_join(emp, oneDept, by="DEPTNO") %>% View
df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT *
FROM emp e
WHERE NOT EXISTS
  (SELECT 1
   FROM   dept d
   WHERE  e.deptno = 10)
ORDER BY deptno;"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_UTEid', PASS='orcl_UTEid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)


dplyr::intersect(dept, oneDept) %>% tbl_df
dplyr::union(dept, oneDept) %>% tbl_df
dplyr::setdiff(dept, oneDept) %>% tbl_df
dplyr::bind_rows(dept, oneDept) %>% tbl_df
dplyr::bind_cols(dept, emp[1:4,]) %>% tbl_df
dplyr::bind_cols(dept, sample_n(emp, 4)) %>% tbl_df
           