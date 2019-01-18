library(shiny)
library(tidyverse)
library(shinythemes)
library(RColorBrewer)

# Now we'll get our data:

marvel <- read_csv("marvel-wikia-data.csv")

marvel$SEX[is.na(marvel$SEX)] <- "Not Specified" # R uses NAs for specific purposes, but I want to keep this data

# create the user interface
ui <- fluidPage(
  
  theme = shinytheme("slate"),
  titlePanel("Marvel Characters"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("side",
                   "Choose a side",
                   c("Good Characters",
                     "Bad Characters",
                     "Neutral Characters"))
    ),
    
    mainPanel(
      plotOutput(outputId = "marvelplot")
    )
  )
  
)

server <- function(input, output) { # should this be input, output?
  
  output$marvelplot <- renderPlot({
    
    ggplot(filter(marvel, ALIGN == input$side), aes(x = Year)) + # connect widget in ui with server and data
    geom_bar(aes(fill = SEX), position = "fill") +
    theme_dark()
    
  })
  
}


# Run the application # write about this
shinyApp(ui = ui, server = server)

# script!!!
