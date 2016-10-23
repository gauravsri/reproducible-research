
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(RCurl)
library(rjson)
library(stringr)
library(lubridate)
library(ggplot2)
library(dplyr)
library(googleVis)

orgList <- NULL
tryCatch(orgList <- readRDS(file="orgList.Rda"), warning = function(e) {
  print("No backup data found")
})

summaryTable <- select(orgList, -contains(as.character(year(now()))), -contains(as.character(year(now()) -1)))
enabledTable <- arrange(filter(orgList, 
                               status=="GROUP_NORMAL_SUBSCRIPTION"
), 
desc(enabled_users))

print("Server initialized")

shinyServer(function(input, output) {
  
  output$column_selector <- renderUI({
    checkboxGroupInput("column_selector", "Remove columns:", 
                       names(select(orgList, -contains("2016"), -contains("2015"))),
                       selected = input$column_selector)
  })
  
  output$enabled_plot_filter <- renderUI({
    value <- input$enabled_plot_filter
    if (is.null(value))
      value = c(1, max(enabledTable["enabled_users"]))
    
    sliderInput("enabled_plot_filter", 
                "Filter Enabled User Plot", 
                1, 
                max(enabledTable["enabled_users"]), 
                value, 
                step=5, ticks = FALSE)
  })
  
  output$userPlot <- renderGvis({ 
    
    filteredTable <- enabledTable
    
    if (!is.null(input$enabled_plot_filter))
    {
      filteredTable <- arrange(filter(orgList, 
                                      status=="GROUP_NORMAL_SUBSCRIPTION", 
                                      (enabled_users == input$enabled_plot_filter[1] | 
                                         enabled_users > input$enabled_plot_filter[1]) & 
                                        (enabled_users == input$enabled_plot_filter[2] |
                                           enabled_users < input$enabled_plot_filter[2])), 
                               desc(enabled_users))
    }
    
    gvisBarChart(filteredTable, 
                 xvar = "enterprise",
                 yvar=c("enabled_users", "disabled_users"),
                 options=list(title="Users per Company", isStacked=TRUE))
    
  })
  
  output$summary <- renderDataTable({ 
    
    if (!is.null(input$column_selector)) {
      select(summaryTable, -one_of(input$column_selector))
    }
    else
      summaryTable 
  }, options = list(orderClasses = TRUE))
  
  output$historyPlot <- renderPlot({ 
    
    filteredTable <- enabledTable
    
    if (!is.null(input$enabled_plot_filter))
    {
      filteredTable <- arrange(filter(orgList, 
                                      status=="GROUP_NORMAL_SUBSCRIPTION", 
                                      (enabled_users == input$enabled_plot_filter[1] | 
                                         enabled_users > input$enabled_plot_filter[1]) & 
                                        (enabled_users == input$enabled_plot_filter[2] |
                                           enabled_users < input$enabled_plot_filter[2])), 
                               desc(enabled_users))
    }
    
    op <- par(mar = c(5,16,4,2) + 0.1)
    
    gvisBarChart(filteredTable, 
                 xvar = "enterprise",
                 yvar=c("enabled_users", "disabled_users")
    )
    
    par(op)
    
  })
  
  output$history <- renderDataTable({ 
      orgList 
  }, options = list(orderClasses = TRUE))
  
})
