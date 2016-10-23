require("jsonlite")
require("RCurl")
# Change the USER and PASS below to be your UTEid
df <- data.frame(fromJSON(getURL(URLencode('oraclerest.cs.utexas.edu:5001/rest/native/?query="select * from titanic where sex is not null"'),httpheader=c(DB='jdbc:oracle:thin:@aevum.cs.utexas.edu:1521/f16pdb', USER='cs329e_UTEid', PASS='orcl_uteid', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
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
        geom="point",
        params=list(), 
        stat="identity", 
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
        geom="point",
        params=list(),
        stat="identity",
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )