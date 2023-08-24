library(shiny)
library(shinythemes)
####################################
# User Interface                   #
####################################
ui <- fluidPage(theme = shinytheme("united"),
                navbarPage(
                  
                  HTML("<h4 style='color:White;align:top;'><B><p style='font-size:19px;font-family:calibri;padding: 0px 10px 5px 10px;' class='fas'>&#9798;&#9829;&#9798;&nbsp;&nbsp;&nbsp;Heart Disease Prediction System</p></B></h4>"),
                           
                           tabPanel("BMI Calculator",
                                    # Input values
                                    sidebarPanel(
                                      HTML("<br><br><br><h1>Please input your parameters to check BMI: </h1><br><br><br><br>"),
                                      sliderInput("height",
                                                  label = HTML("<h3>Height in CM</h3>"), 
                                                  value = 175, 
                                                  min = 40, 
                                                  max = 300),
                                      HTML("<br><br><br>"),
                                      sliderInput("weight", 
                                                  label = HTML("<h3>Weight in KG</h3>"), 
                                                  value = 70, 
                                                  min = 20, 
                                                  max = 250),
                                      HTML("<br><br><br>"),
                                      
                                      actionButton("submitbutton", 
                                                   "Submit", 
                                                   class = "btn btn-primary")
                                    ),
                                   
                                    mainPanel(
                                      
                                      tags$label(h1('Status is:')), # Status/Output Text Box
                                      verbatimTextOutput('contents'),
                                      tableOutput('tabledata') # Results table
                                    ) # mainPanel()
                                    
                           ), 
                           
                           tabPanel("Heart Analysis by BMI ", 
                           titlePanel("Analysis:"), 
                           div(includeMarkdown("about.md"), 
                               align="justify")
                                      ), #tabPanel(), About
                  
                           tabPanel("Heart Disease Statistics", 
                                    titlePanel("Statistics:"), 
                                    div(includeMarkdown("output report prediction/output report prediction.md"), 
                                        align="justify")
                           ), 
                          
                           
                           
                           tags$footer("All rights reserved", align = "right", style = "position:fixed;left:0;bottom:0;width:100%;height:50px;color: white;background-color:#b45f06;z-index: 1000;text-align:center;")
                         
                ) # navbarPage()
) # fluidPage()


####################################
# Server                           #
####################################
server <- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    bmi <- input$weight/( (input$height/100) * (input$height/100) )
    bmi <- data.frame(bmi)
    names(bmi) <- "BMI IS AS BELOW:"
    print(bmi)
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}


####################################
# Create Shiny App                 #
####################################
shinyApp(ui = ui, server = server)





