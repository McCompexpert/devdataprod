library(shiny)
library(reshape2)
library(googleVis)
require(datasets)
phones <- data.frame(WorldPhones)
phones$year<-row.names(phones)
phones <-dcast(melt(phones), ...~year)
phones<-phones[,-1]
phones$laender <- c("Bavaria", "Berlin", "Saxony", "Hesse", "Saarland", "Thuringia", "Bremen")
shinyServer(function(input, output) {
        output$dataYear <- reactive({
         switch(input$dataYear,"1951" = "1951",
                "1956" = "1956", "1957" = "1957",
                "1958" = "1958", "1959" = "1959",
                "1960" = "1960","1961" = "1961")})
 output$view <- renderGvis({
 gvisGeoChart(phones, locationvar = "laender", colorvar = input$dataYear,options=list(region="DE",
displayMode="regions", resolution="provinces",width=600, height=400))})
})