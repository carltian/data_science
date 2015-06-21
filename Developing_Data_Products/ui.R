library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Auto Loan Monthly Payments Calculator"),
  sidebarPanel(
    numericInput('loanamount','Auto loan amount'            , value=20000, min=0.1, max=1000000, step=1000),
    numericInput('loanyears' ,'Auto loan term in years'     , value=5.0  , min=0.1, max=10.0   , step=1.0 ),
    numericInput('loanapr'   ,'Interest rate per year (APR)', value=3.0  , min=0.1, max=20     , step=0.01),
    submitButton("Calculate")
  ),
  mainPanel(
    h3('Monthly Payments'),
    verbatimTextOutput("monthlypayments"),
    h4('Interest'),
    verbatimTextOutput("monthlyinterest"),
    h4('Principal'),
    verbatimTextOutput("monthlyprincipal"),
    plotOutput("plot", width = 400, height = 300)
  )
))