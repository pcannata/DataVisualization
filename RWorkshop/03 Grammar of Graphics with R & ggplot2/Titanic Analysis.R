require("jsonlite")
require("RCurl")
# Change the USER and PASS below to be your UTEid
df <- data.frame(fromJSON(getURL(URLencode('oraclerest.cs.utexas.edu:5001/rest/native/?query="select * from dept"'),httpheader=c(DB='jdbc:oracle:thin:@aevum.cs.utexas.edu:1521/utpdb', USER='cannata', PASS='Cenne!e49', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
df
df <- data.frame(fromJSON(getURL(URLencode('ec2-52-34-29-13.us-west-2.compute.amazonaws.com:5011/rest/native/?query="select * from LeaseApplication l join Tenant t on(l.Customer_ID = t.Customer_ID) join LA_Lease x on(l.Lease_ID = x.Lease_ID) join Status s on (l.Lease_id = s.Lease_ID) join Property p on (l.lease_id = p.lease_id) join address a on (p.property_id = a.property_id)"'),httpheader=c(DB='OracleNoSQL', USER='C##cs329e_UTEid', PASS='orcl_UTEid', MODE='rdf_mode', MODEL='A0', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
df
df <- data.frame(fromJSON(getURL(URLencode('localhost:5011/rest/native/?query="select * from LeaseApplication l join Tenant t on(l.Customer_ID = t.Customer_ID)"'),httpheader=c(DB='OracleNoSQL', USER='C##cs329e_UTEid', PASS='orcl_UTEid', MODE='rdf_mode', MODEL='A0', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
df
save(df, file="/Users/pcannata/Downloads/R2Tableau.RData")

summary(df)
head(df)

require(extrafont)
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  #facet_wrap(~SURVIVED) +
  facet_grid(.~SURVIVED, labeller=label_both) + # Same as facet_wrap but with a label.
  #facet_grid(PCLASS~SURVIVED, labeller=label_both) +
  labs(title='Titanic') +
  labs(x="Age", y=paste("Fare")) +
  layer(data=df, 
        mapping=aes(x=as.numeric(as.character(AGE)), y=as.numeric(as.character(FARE)), color=SEX), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  #facet_grid(PCLASS~SURVIVED, labeller=label_both) +
  labs(title='Titanic') +
  labs(x="SURVIVED", y=paste("FARE")) +
  layer(data=df, 
        mapping=aes(x=SEX, y=as.numeric(as.character(FARE)), color=as.character(SURVIVED)), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )