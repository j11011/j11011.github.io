

library(shiny)
library(shiny)
library(shinyjs)
library(scales)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  navbarPage("Simple algorithms",
             tabPanel("Introduction",
                      h3("The objective of this application is to teach about 3 basic algorithms 
                         quicksort, bubble sort and binary search, this application shows the
                         basic operation of each of the algorithms, every section has a instruccions section
                         that explains how to use the section",style="text-align: justify"),
                      h2("By ajss"),
                      h2("19-April-18")),
             navbarMenu("Binary search",
                        tabPanel("Aplication",
                                 titlePanel("Binary search"),
                                 numericInput("min1","Min value:",1),
                                 numericInput("max1","Max value:",100),
                                 numericInput("target1","Value to find",25),
                                 actionButton("buscar1","Search",class = "btn-primary"),
                                 verbatimTextOutput("text1")),
                        tabPanel("Instruccions",wellPanel(helpText("Insert a numeric value that is 
                                                                   in the min value and a grater value in the max value in the max value
                                                                   next put a value that is between the max and the min values
                                                                   in the search field")))),
             navbarMenu("Bubble sorting",
                        tabPanel("Aplication",
                                 titlePanel("Bubble sorting"),
                                 textInput("arr2","Vector:"),
                                 actionButton("ord2","Sort",class = "btn-primary"),
                                 verbatimTextOutput("text2")),
                        tabPanel("Instruccions",wellPanel(helpText("To use this application a vector need to be inserted in the
                                                                  vector field that vector need to be like this 1,4,6,7,8,9 in other 
                                                                  words it is just comma separeted numbers.
                                                                  That vector will be sorted by the bubble sort algorithm and 
                                                                  the process will be shown.")))),
             navbarMenu("Quicksort",
                        tabPanel("Aplication",
                                 titlePanel("Quicksort:"),
                                 textInput("arr3","Vector:"),
                                 actionButton("ord3","Sort",class = "btn-primary"),
                                 verbatimTextOutput("text3")),
                        tabPanel("Instruccions",wellPanel(helpText("To use this application a vector need to be inserted in the
                                                                   vector field that vector need to be like this 1,4,6,7,8,9 in other 
                                                                   words it is just comma separeted numbers.
                                                                   That vector will be sorted by the quicksort algorithm and 
                                                                   the process will be shown."))) )
             
  )
  
)
)
