library(shiny)
library(plotrix)
numberofvisitors <<- 0
autoloanmonthlypayments  <- function(loanamount, loanyears, loanapr) round(loanamount*(0.01*loanapr/12)/(1-(1+0.01*loanapr/12)^(-1*12*loanyears)), 2)
autoloanmonthlyinterest  <- function(loanamount, loanyears, loanapr) round(loanamount*(0.01*loanapr/12)/(1-(1+0.01*loanapr/12)^(-1*12*loanyears))-loanamount/(12*loanyears),2)
autoloanmonthlyprincipal <- function(loanamount, loanyears, loanapr) round(loanamount/(12*loanyears), 2)

shinyServer(
  function(input, output) {
    numberofvisitors         <<- numberofvisitors + 1
    output$inputValue1       <- renderPrint({input$loanamount})
    output$inputValue2       <- renderPrint({input$loanyears})
    output$inputValue3       <- renderPrint({input$loanapr})    
    output$monthlypayments   <- renderPrint({autoloanmonthlypayments(input$loanamount, input$loanyears, input$loanapr)})
    output$monthlyinterest   <- renderPrint({autoloanmonthlyinterest(input$loanamount, input$loanyears, input$loanapr)})
    output$monthlyprincipal  <- renderPrint({autoloanmonthlyprincipal(input$loanamount, input$loanyears, input$loanapr)})
    output$text              <- renderText({paste("You are the number", numberofvisitors, "visitors.")})

    output$plot <- renderPlot({
        slices <- c(autoloanmonthlyinterest(input$loanamount, input$loanyears, input$loanapr), autoloanmonthlyprincipal(input$loanamount, input$loanyears, input$loanapr)) 
        lbls   <- c("Interest", "Principal")
#        pie3D(slices,labels=lbls,explode=0.1, main="Pie Chart of Montyly Payments ")
        pie(slices, labels = lbls, main="Pie Chart of Monthly Payments")
        
    })


  }
)
