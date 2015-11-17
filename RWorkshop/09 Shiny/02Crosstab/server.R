# server.R
require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)
require(shiny)

shinyServer(function(input, output) {
        
      KPI_Low_Max_value <- reactive({input$KPI1})     
      KPI_Medium_Max_value <- reactive({input$KPI2})
    
      df <- reactive({data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
            "select color, clarity, sum_price, round(sum_carat) as sum_carat, kpi as ratio, 
            case
            when kpi < "p1" then \\\'03 Low\\\'
            when kpi < "p2" then \\\'02 Medium\\\'
            else \\\'01 High\\\'
            end kpi
            from (select color, clarity, 
            sum(price) as sum_price, sum(carat) as sum_carat, 
            sum(price) / sum(carat) as kpi
            from diamonds
            group by color, clarity)
            order by clarity;"
            ')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_UTEid', PASS='orcl_UTEid', 
                 MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=KPI_Low_Max_value(), p2=KPI_Medium_Max_value()), verbose = TRUE)))
      })

      output$distPlot <- renderPlot({             
            plot <- ggplot() + 
                  coord_cartesian() + 
                  scale_x_discrete() +
                  scale_y_discrete() +
                  labs(title=isolate(input$title)) +
                  labs(x=paste("COLOR"), y=paste("CLARITY")) +
                  layer(data=df(), 
                        mapping=aes(x=COLOR, y=CLARITY, label=SUM_PRICE), 
                        stat="identity", 
                        stat_params=list(), 
                        geom="text",
                        geom_params=list(colour="black"), 
                        position=position_identity()
                  ) +
                  layer(data=df(), 
                        mapping=aes(x=COLOR, y=CLARITY, fill=KPI), 
                        stat="identity", 
                        stat_params=list(), 
                        geom="tile",
                        geom_params=list(alpha=0.50), 
                        position=position_identity()
                  )
            plot
      }) 
})
