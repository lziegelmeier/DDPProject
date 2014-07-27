# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {

  # Compute the formula text in a reactive expression 
  formulaText <- reactive({
                    paste("Display Using Method:", input$method)
                    })

  # Return the formula text for printing as a caption
  output$caption <- renderText({
                      formulaText()
                      })


  # Generate surface plot
  output$SurfacePlot <- renderPlot({
                          myfun <- function (x,y) {
                            eval(parse(text=input$fnc))
                          } 
                          #Create 10 y-inputs and 10 x-inputs
                          xstep=(input$xrange[2]-input$xrange[1])/20
                          ystep=(input$yrange[2]-input$yrange[1])/20
                          x=round(seq(from=input$xrange[1],to=input$xrange[2],by=xstep),2)
                          y=round(seq(from=input$yrange[1],to=input$yrange[2],by=ystep),2)
                          z=outer(x,y,myfun) #creates outer product to create matrix
                          persp(x,y,z,theta=30,d=10, ticktype="detailed")
                          })

  # Generate contour plot
  output$ContourPlot <- renderPlot({
                          myfun <- function (x,y) {
                            eval(parse(text=input$fnc))
                          }
                          #Create 10 y-inputs and 10 x-inputs
                          xstep=(input$xrange[2]-input$xrange[1])/20
                          ystep=(input$yrange[2]-input$yrange[1])/20
                          x=round(seq(from=input$xrange[1],to=input$xrange[2],by=xstep),2)
                          y=round(seq(from=input$yrange[1],to=input$yrange[2],by=ystep),2)
                          z=outer(x,y,myfun) #creates outer product to create matrix
                          filled.contour(x,y,z,xlab="x",ylab="y",nlevels=15,color = terrain.colors)
                          
                         # plotFun(as.formula(paste(input$fnc,"~x&y")),xlim=range(input$xrange),ylim=range(input$yrange))
                          })

  # Generate table of values
  output$Table <- renderTable({
                        myfun <- function (x,y) {
                          eval(parse(text=input$fnc))
                        }
                        #Create 10 y-inputs and 10 x-inputs
                        xstep=(input$xrange[2]-input$xrange[1])/9
                        ystep=(input$yrange[2]-input$yrange[1])/9
                        xvals=round(seq(from=input$xrange[1],to=input$xrange[2],by=xstep),2)
                        yvals=round(seq(from=input$yrange[1],to=input$yrange[2],by=ystep),2)
                        tabvals=outer(xvals,yvals,myfun) #creates outer product to create matrix
                        colnames(tabvals)=paste("x=",xvals,sep="")
                        rownames(tabvals)=paste("y=",yvals,sep="")
                        tabvals
                        
                        })

  # Show input values
  output$myInputs <- renderTable({
                        f<-c("Function",input$fnc)
                        r1 <- c("x min",input$xrange[1])
                        r2 <- c("x max",input$xrange[2])
                        r3 <- c("y min",input$yrange[1])
                        r4 <- c("y max",input$yrange[2])
                        
                        myTable <- do.call(rbind, list(f,r1,r2,r3,r4))
                        myTable
                        }
                        , align = c("lcc")
                        , include.rownames = FALSE
                        , include.colnames = FALSE
                        , sanitize.text.function = function(x) x
                        )#end renderTable  

  # Compute the function evaluated at given input values in a reactive expression 
  EvaluationText <- reactive({
                        myfun <- function (x,y) {
                          eval(parse(text=input$fnc))
                        }
                        val=myfun(as.numeric(input$xeval),as.numeric(input$yeval))
                        paste("Function evaluated at x=", input$xeval, "and y=", input$yeval, "is:", val)
                        })

  # Return the formula text for printing evaluation points and function output
  output$evaluation <- renderText({
                          EvaluationText()
                          })


})


