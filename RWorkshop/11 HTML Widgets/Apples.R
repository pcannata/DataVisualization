# install.packages("devtools")
# library("devtools")
# devtools::install_github("rstudio/dygraphs")

# ui.R
library(dygraphs)
library(shiny)

ui <- shinyUI(fluidPage(
  titlePanel("Apples Prices"),
  
  sidebarLayout(
    sidebarPanel(
      uiOutput("productnames"),
      uiOutput("counts")
    ),
    
    mainPanel(
      dygraphOutput("applesgraph"))
  )))

# server.R
library(shiny)
library(dygraphs)
library(dplyr)
library(xts)

server <- shinyServer(function(input, output) {
  data <- read.csv("www/cleanApples.csv") %>% dplyr::filter(Quantity > 10) 
  View(data)
  print(names(data))
  # xts(data$Price, as.Date(data$date, format = "%m/%d/%y")) %>% dygraph()
  #the first graph which is price over time (input: variety, count, date)
  output$applesgraph <- renderDygraph({
    if (is.null(input$productname) || is.null(input$counts)) return(NULL)
    filtered <- data # %>% dplyr::filter(Variety == input$productname, Count == input$counts )
    xts(filtered$Price, as.Date(filtered$date, format = "%m/%d/%y")) %>%
      dygraph()
  })
  
  output$productnames <- renderUI({
    selectInput("productname", "Select your product",
                choices = levels(data$Variety))
  })
  
  output$counts <- renderUI({
    selectInput("counts",  "Select your size",
                choices = levels(data$Count))
  })
})

shinyApp(ui = ui, server = server)