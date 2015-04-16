df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select
CASE
WHEN grouping(job) = 1 THEN \\\'zTotal\\\'
ELSE job END as job_name,
CASE WHEN grouping(dname) = 1 THEN \\\'yTotal\\\'
ELSE dname END as dname, count(*) n
from emp e join dept d on(e.deptno=d.deptno) group by cube (job, dname)"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Scott', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

spread(df, DNAME, N)

# Basic Tableau Table Calculations
# http://onlinehelp.tableau.com/current/pro/online/mac/en-us/calculations_tablecalculations_definebasic.html

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT empno, deptno, sal, rank() 
OVER (PARTITION BY deptno order by sal desc) as DEPT_RANK 
FROM emp order by 2,3 desc"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Scott', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT empno, deptno, sal, rank() 
OVER (order by sal desc) as DEPT_RANK 
FROM emp "
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Scott', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT * FROM (SELECT empno, deptno, sal, rank() 
OVER (PARTITION BY deptno order by sal desc) as DEPT_RANK 
FROM emp) where DEPT_RANK = 1 "
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Scott', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select empno, deptno, sal, last_value(max_sal) 
OVER (PARTITION BY deptno order by sal) max_sal, last_value(max_sal) 
OVER (PARTITION BY deptno order by sal) - sal sal_diff
from
(SELECT empno, deptno, sal, max(sal)
OVER (PARTITION BY deptno) max_sal 
FROM emp) 
order by 2,3 desc"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Scott', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT empno, deptno, sal, nth_value(sal, 2)
OVER (PARTITION BY deptno) nth_sal 
FROM emp
order by 2,3 desc"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Scott', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select empno, deptno, sal, cume_dist() 
OVER (PARTITION BY deptno order by sal) cume_dist
from emp 
order by 2,3 desc"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Scott', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)
