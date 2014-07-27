# ui.R
library("shiny")

# Define UI 
shinyUI(
  pageWithSidebar(
    # Title
    headerPanel("Visualizing a Function of Two Variables")
    ,
    # User Input in sidebar panel
    sidebarPanel(
      
      helpText("This application can be used to visualize common functions of two variables.  First, select a function to consider.  Then, choose a method of visualization and use the sliders to select a domain.  Finally, the function can be evaluated at inputs specified by the user. "),
      
      h4("Function"),
      selectInput("fnc","Select Function to Visualize",c("x^2+y^2","exp(-(x^2+y^2))","x^2-y^2","x*y","cos(x)+sin(y)","x+y","sqrt(x^2+y^2)","-y^2")),
      
#       # Yes/No
#       checkboxInput("newfnc", "Input a Different Function to Visualize", FALSE), 
#       conditionalPanel(
#         condition="input.newfnc==true",
#         textInput("text","New Function",value="")        
#       ),
            
h4("Method"),

      selectInput("method","Method of Visualization",c("Surface Plot" = "surface","Contour Plot" = "contour","Table" = "table")),
h4("Input Domains"),
      sliderInput("xrange", "X-Axis Domain:", min = -100, max = 100, value = c(-5,5)),
      
      sliderInput("yrange", "Y-Axis Domain:", min = -100, max = 100, value = c(-5,5)),
     
h4("Evaluation"),
textInput("xeval","Value of x to Evaluate",value=""),
textInput("yeval","Value of y to Evaluate",value="")
    )# end sidebarPanel
    ,


    # Output in main panel
    # See output$myResults in server.R
    mainPanel(
            
      h4("Input Values"),
      tableOutput("myInputs"),
      h4(textOutput("caption")),
        conditionalPanel(condition="input.method=='surface'", plotOutput("SurfacePlot")),
        conditionalPanel(condition="input.method=='contour'", plotOutput("ContourPlot")),
        conditionalPanel(condition="input.method=='table'", uiOutput("Table")),
       
      h4(textOutput("evaluation"))
    ) #end mainPanel
  )#end pageWithSidebar
)#end shinyUI 



