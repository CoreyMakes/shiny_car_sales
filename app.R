###################
# shiny car sales #
###################

#load packages
library(shiny)
library(shinydashboard)
library(tidyverse)

#import data
df <- read.csv("Car_sales.csv", stringsAsFactors = FALSE)

#app
ui <- dashboardPage(
        dashboardHeader(title = "Car sales"),
        
        dashboardSidebar(
          sidebarMenu(
            menuItem("Page1", tabName = "page1", icon = icon("folder")),
            menuItem("Page2", tabName = "page2", icon = icon("folder"))
          )
        ),
        
        dashboardBody(
          tabItems(
            #page1 content
            tabItem(tabName = "page1", 
              fluidRow(box(title = "PLOT1", collapsible = TRUE, plotOutput("p1"))),
            
            #page2 content
            tabItem(tabName = "page2",
              fluidRow(box(title = "PLOT2", collapsible = TRUE, plotOutput("p2")))
            
        )
      )
    )
  )
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
