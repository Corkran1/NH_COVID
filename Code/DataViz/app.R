library(shiny); library(ggplot2); library(plotly)

Data <- read.csv("../../Data/Alec/full_Aug16_nh_data.csv", stringsAsFactors = F)

# Define UI 
ui <- bootstrapPage(
    tags$h2("NH Data Visualization"),
    # Select state
                selectInput(inputId = "state", label = "State:",
                            choices = c("All", unique(Data$state.x))),
                # Variable
                selectInput(inputId = "var", label = "Variable:",
                            choices = c('num_beds',
                                        'AIDHRD',# Aide staff hours per resident day
                                        'VOCHRD',# LPN staff hours per resident day
                                        'RNHRD',# Registered Nursing staff hours per resident day
                                        'TOTLICHRD',# Total nursing staff hours per resident day (VOCHRD+RNHRD)
                                        'TOTHRD',# Total staff hours per resident day (AIDHRD+VOCHRD+RNHRD)
                                        'PTHRD',# Physical Therapy hour per resident day
                                        'CM_AIDE',# Case mix for aide staff, used to calculate adjusted rates
                                        'CM_LPN',# Case mix for LPN staff, used to calculate adjusted rates
                                        'CM_RN',# Case mix for RN staff, used to calculate adjusted rates
                                        'CM_TOTAL',# Case mix for total nursing staff hours, used to calculate adjusted rates
                                        'ADJ_AIDE',# Adjusted aide staff hours per resident day
                                        'ADJ_LPN',# Adjusted LPN staff hours per resident day
                                        'ADJ_RN',# Adjusted RN staff hours per resident day
                                        'ADJ_TOTAL'# Total adjusted staff hours per resident day
                                        )),
                
                plotlyOutput("Plot")
)

################################
# ui <- fluidPage(
#     # Application title
#     titlePanel("NH Data Visualization"),
#     # Sidebar with a slider input for number of bins 
#     sidebarLayout(
#         sidebarPanel(
#             # Select state
#             selectInput(inputId = "state", label = "State:", 
#                         choices = c("All", unique(Data$state.x))),
#             # Variable
#             selectInput(inputId = "var", label = "Variable:", 
#                         choices = c('num_beds', 
#                                     'AIDHRD',# Aide staff hours per resident day
#                                     'VOCHRD',# LPN staff hours per resident day 
#                                     'RNHRD',# Registered Nursing staff hours per resident day
#                                     'TOTLICHRD',# Total nursing staff hours per resident day (VOCHRD+RNHRD)
#                                     'TOTHRD',# Total staff hours per resident day (AIDHRD+VOCHRD+RNHRD)
#                                     'PTHRD',# Physical Therapy hour per resident day
#                                     'CM_AIDE',# Case mix for aide staff, used to calculate adjusted rates
#                                     'CM_LPN',# Case mix for LPN staff, used to calculate adjusted rates
#                                     'CM_RN',# Case mix for RN staff, used to calculate adjusted rates
#                                     'CM_TOTAL',# Case mix for total nursing staff hours, used to calculate adjusted rates
#                                     'ADJ_AIDE',# Adjusted aide staff hours per resident day
#                                     'ADJ_LPN',# Adjusted LPN staff hours per resident day
#                                     'ADJ_RN',# Adjusted RN staff hours per resident day
#                                     'ADJ_TOTAL'# Total adjusted staff hours per resident day
#                                     ))
#         ),
# 
#         # Show a plot of the generated distribution
#         mainPanel(
#            plotlyOutput("Plot")
#         )
#     )
# )

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$Plot <- renderPlotly({
        # State plot
        if(input$state == "All"){
            P <- Data %>%
                plot_ly(data = ., y = ~eval(parse(text = input$var)), color = ~state.x, type = 'box') %>%
                layout(yaxis = list(title = input$var))
            
        }
        # County plot
        else if(input$state != 'All'){
           P <-  Data %>%
               filter(state.x == input$state) %>%
               plot_ly(data = ., y = ~eval(parse(text = input$var)), color = ~county.x, type = 'box') %>%
               layout(yaxis = list(title = input$var))
        }
        P
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
