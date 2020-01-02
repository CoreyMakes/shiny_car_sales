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
              sliderInput("priceInput", "Price in thousands", 0, 100, c(10, 50), pre = "$"),
              radioButtons("typeInput", "Vehicle type",
                           choices = c("Car", "Passenger"),
                           selected = "Car"),
              fluidRow(uiOutput("ManufacturerOutput")),
            
            #page2 content
            tabItem(tabName = "page2",
              fluidRow(box(title = "PLOT2", collapsible = TRUE, plotOutput("p2")))
            
        )
      )
    )
  )
)

server <- function(input, output){
  output$ManufacurerOutput <- renderUI({
    selectInput("ManufacturerInput", "Manufacturer",
                sort(unique(df$Manufacturer)),
                selected = "Acura")
  })
  
  filtered <- reactive({
    if (is.null(input$ManufacturerInput)) {
      return(NULL)
    }    
    
    df %>%
      filter(Sales_in_thousands >= input$priceInput[1],
             Sales_in_thousands <= input$priceInput[2],
             Vehicle_type == input$typeInput,
             Manufacturer == input$ManufacturerInput
      )
  })
  
  output$p1 <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Horsepower)) +
      geom_histogram()
  })
}

shinyApp(ui = ui, server = server)
