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
                selectInput("dataYear", "Select Year:", choices=colnames(phones[,-8])),hr(),
				br(),
				p(strong(em("Documentation:"))),
				br(),
				p(strong(em("1. Select the year in the drop down"))),
				br(),
				p(strong(em("2. GoogleViz chart will display Germany's Map"))),
				br(),
				p(strong(em("3. Enjoy the reactive output"))),
				br(),
				p(strong(em("Data: is purely simulated, just to demonstrate the reactivity"))),
				br(),
				p(strong(em("Github repository:",a("Developing Data Products - devdataprod",href="https://github.com/McCompexpert/devdataprod"))))	),
                # Show the google map
                mainPanel(h3(textOutput("dataYear")),htmlOutput("view")))))