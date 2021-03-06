library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Auto Loan Monthly Payments Calculator"),
  sidebarPanel(
    numericInput('loanamount','Auto loan amount'            , value=20000, min=0.1, max=1000000, step=1000),
    helpText("The loan amount is the amount that you will borrow."),  
    numericInput('loanyears' ,'Auto loan term in years'     , value=5.0  , min=0.1, max=10.0   , step=1.0 ),
    helpText("The total duration of the loan in years."),
    numericInput('loanapr'   ,'Interest rate per year (APR)', value=3.0  , min=0.1, max=20     , step=0.01),
    helpText("The yearly interest rate (APR)."),
    submitButton("Calculate")
  ),
  mainPanel(    
    h3('Monthly Payments'),
    verbatimTextOutput("monthlypayments"),
    h4('Interest'),
    verbatimTextOutput("monthlyinterest"),
    h4('Principal'),
    verbatimTextOutput("monthlyprincipal"),
    textOutput('text'),
    plotOutput('plot')
  )
))
