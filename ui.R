library(shiny)
library(reshape2)
require(datasets)
phones <- data.frame(WorldPhones)
phones$year<-row.names(phones)
phones <-dcast(melt(phones), ...~year)
phones<-phones[,-1]
phones$laender <- c("Bayern", "Berlin", "Saxony", "Hesse", "Saarland", "Thuringia", "Bremen")
shinyUI(fluidPage(
        # App title
        titlePanel("Germany's Some Numbers"),
        # Sidebar with controls to select the year to display in Geo Chart
        sidebarLayout(sidebarPanel(
                selectInput("dataYear", "Select Year:", choices=colnames(phones[,-8])),hr()),
                # Show the google map
                mainPanel(h3(textOutput("dataYear")),htmlOutput("view")))))