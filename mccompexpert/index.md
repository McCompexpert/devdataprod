---
title       : Developing Data Products - Shiny App Pitch
subtitle    : 
author      : mccompexpert
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---


## Pitch Overview

This pitch will walk you through my simple Shiny application:
http://mccompexpert.shinyapps.io/devdataprod/

In the next slides I will

1. Discribe my dataset
2. Show you the snipped of ui.R and server.R

---

## Dataset

* I take the WorldPhones dataset from datasets library
* and do some manupulations to fit my small Shiny app requirements:
 + I transpose the dataset to get years as column names
 + for this I use dcast and melt functions
 + I create a vector with a couple of German federal states
* Meaning that I am using the dataset as a dummy to map the numbers to German map        
* Making no sense but ok for Shiny app demonstration purpose


```r
# Data preparation steps
phones <- data.frame(WorldPhones)
phones$year<-row.names(phones)
phones <-dcast(melt(phones), ...~year)
phones<-phones[,-1]
phones$laender <- c("Bayern", "Berlin", "Saxony", 
                    "Hesse", "Saarland", "Thuringia", "Bremen")
```

---

## ui.R
* At the beginning of the ui.R we have library loads for
 + shiny, reshape2 and datasets
* Then we build up the html page as follows:

```r
shinyUI(fluidPage(
        # App title
        titlePanel("Germany's Some Numbers"),
        # Sidebar with controls to select the year to display in Geo Chart
        sidebarLayout(sidebarPanel(
                selectInput("dataYear", "Select Year:", choices=colnames(phones[,-8])),hr(),
        			br(),
				p(strong(em("Documentation:"))),
....
```

---

## Server.R

* In server.R we load the three above mentioned libraries as well
* for our nifty chart we use googleViz library
* The code for server.R looks like this:


```r
.....
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
```
