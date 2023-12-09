# created by Utpalraj Kemprai
# Analytics Dashboard for US Macro Economic Factors data from 2002 to 2022

# loading the libraries to be used
library(shiny)
library(shinythemes)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(ggthemes)

# load the dataset and do some minor mutations
load("Cleaned_US_Economic_Data.RData")
years <- substring(dataset$DATE,7,10)
dataset$DATE <- as.Date(dataset$DATE,tryFormats = c("%d-%m-%Y"))
colnames(dataset)[colnames(dataset) == "DATE"] = "Date"

# user interface
ui <- fluidPage(
  # fluidPage and fluidRow to be compatible with different screen dimensions
  fluidRow(theme = shinytheme("flatly"),
           # HTML for some customization in looks
                tags$style(HTML("
    /* Change the background color of tabs */
    .nav.nav-tabs > li.active > a,
    .nav.nav-tabs > li.active > a:hover,
    .nav.nav-tabs > li.active > a:focus {
      background-color: #607D8B; /* Change this to the desired color */
      color: #FFFFFF; /* Change this to the desired text color */
    }
    
    /* Change the text color of inactive tabs */
    .nav.nav-tabs > li > a {
      color: #333; /* Change this to the desired text color for inactive tabs */
    }
  ")),
  
    tags$head(
    tags$style(
      HTML("
        .custom-link {
          color: red;  /* Set your desired color */
        }
      ")
    )
  ),
        
  div(
    h3("US Macro Economic Data Analysis"),
    style = "background-color: #607D8B; color: #FFFFFF; padding: 10px;"
  ),
  
  # organizing plots and description in different tabs
                tabsetPanel(type = "tabs",
                # first tab
                tabPanel(h4("Data Description"),
                mainPanel(
                titlePanel("Data Description"),
                                             markdown("<h4> 
                                             <p> The data used contains month-wise details about macro-economic factors of US over two decades from May 2002 to May 2022. 
                                             <p>
                                             The 14 macro-economic factors in the dataset are:
                                             <p>
                                             
                                             - Unemployment rate(%) of US for a particular month
                                             - Consumer Confidence Index provided by Conference Board
                                             - Producers Purchase Index (PPI) - Construction Materials (PPI.CONST.MAT.)
                                             - Consumer Price Index- All Items for the US (CPIALLITEMS)
                                             - Inflation rate(%) in the US
                                             - Average Mortgage interest rate of all Weeks of a particular month(MORT.INT.AVG)
                                             - Median Household Income($) in the US
                                             - Corporate Bond Yield(%)
                                             - Monthly Home Supply (Ratio of new houses for sale to new houses sold.)
                                             - Share of Working Population (between the age 18 and 60) (WORKING.POP.SHARE)
                                             - GDP per capita($)
                                             - Quarterly Real GDP($)
                                             - Quarterly GDP Growth Rate (%)
                                             - S&P/Case-Shiller U.S. National Home Price Index given by FRED (CSUSHPISA)

                                             Details about the data source can be found <a href= 'https://www.kaggle.com/datasets/sagarvarandekar/macroeconomic-factors-affecting-us-housing-prices' class = 'custom-link'> here </a>.
                                             <h4>"),
                      width = 9
                                           ),
                                           
                                  ),
                                  # second tab
                                  tabPanel(h4("Time Series Data"),
                                           h2(""),
                                           sidebarPanel(
                                             selectInput("economic_factor","Economic factor:"
                                                         ,c("Unemployment Rate" = "`Unemployment Rate`",
                                                            "Consumer Confidence Index" = "`Consumer Confidence Index`",
                                                            "PPI for construction materials" = "`PPI for construction materials`",
                                                            "Consumer Price Index" = "`Consumer Price Index`",
                                                            "Inflation Rate" = "`Inflation Rate`",
                                                            "Avg. Mortgage Monthly Increase" = "`Avg. Mortgage Monthly Increase`",
                                                            "Median Household Income" = "`Median Household Income`",
                                                            "Corporate Bond Yield" = "`Corporate Bond Yield`",
                                                            "Monthly Home Supply" = "`Monthly Home Supply`",  
                                                            "Working Population Share" = "`Working Population Share`",
                                                            "GDP per capita" = "`GDP per capita`",
                                                            "Quarterly Real GDP" = "`Quarterly Real GDP`",
                                                            "Quarterly GDP growth" = "`Quarterly GDP growth`",
                                                            "Case and Shiller Index" = "`Case and Shiller Index`"),
                                                         selected = '`Inflation Rate`'
                                             ),
                                             dateRangeInput("date_range", "Select Time Range", 
                                                            start = as.Date("2002-05-01"), end = as.Date("2022-05-31"),
                                                            min = as.Date("2002-05-01"), max = as.Date("2022-05-31"),
                                                            format = "M-yyyy",width = '100%'),
                                             
                                             
                                             width = 2
                                           ),
                                           
                                           mainPanel(
                                           box(
                                             width = 8,
                                             plotlyOutput("plot_time_data",width = "auto",height = "auto")
                                           ),
                                           
                                           box(
                                             width = 4,
                                             background = NULL,
                                             plotlyOutput("boxplot",width = "auto",height = "auto")
                                           ),
                                           width = 10
                                           )
                                           ),
                                  # third tab
                                  tabPanel(h4("Scatterplot"),
                                           h2(""),
                                              sidebarPanel(
                                                selectInput("factor1","First variable (x)",
                                                            c("Unemployment Rate" = "`Unemployment Rate`",
                                                              "Consumer Confidence Index" = "`Consumer Confidence Index`",
                                                              "PPI for construction materials" = "`PPI for construction materials`",
                                                              "Consumer Price Index" = "`Consumer Price Index`",
                                                              "Inflation Rate" = "`Inflation Rate`",
                                                              "Avg. Mortgage Monthly Increase" = "`Avg. Mortgage Monthly Increase`",
                                                              "Median Household Income" = "`Median Household Income`",
                                                              "Corporate Bond Yield" = "`Corporate Bond Yield`",
                                                              "Monthly Home Supply" = "`Monthly Home Supply`",  # Modified variable name
                                                              "Working Population Share" = "`Working Population Share`",
                                                              "GDP per capita" = "`GDP per capita`",
                                                              "Quarterly Real GDP" = "`Quarterly Real GDP`",
                                                              "Quarterly GDP growth" = "`Quarterly GDP growth`",
                                                              "Case and Shiller Index" = "`Case and Shiller Index`"),
                                                            selected = "`Consumer Price Index`"
                                                            
                                                ),
                                                selectInput("factor2","Second variable (y)"
                                                            ,c("Unemployment Rate" = "`Unemployment Rate`",
                                                               "Consumer Confidence Index" = "`Consumer Confidence Index`",
                                                               "PPI for construction materials" = "`PPI for construction materials`" ,
                                                               "Consumer Price Index" = "`Consumer Price Index`",
                                                               "Inflation Rate" = "`Inflation Rate`",
                                                               "Avg. Mortgage Monthly Increase" = "`Avg. Mortgage Monthly Increase`",
                                                               "Median Household Income" = "`Median Household Income`",
                                                               "Corporate Bond Yield" = "`Corporate Bond Yield`",
                                                               "Monthly Home Supply" = "`Monthly Home Supply`",
                                                               "Working Population Share" = "`Working Population Share`",
                                                               "GDP per capita" = "`GDP per capita`",
                                                               "Quarterly Real GDP" = "`Quarterly Real GDP`",
                                                               "Quarterly GDP growth" = "`Quarterly GDP growth`",
                                                               "Case and Shiller Index" = "`Case and Shiller Index`" ),
                                                            selected = "`Corporate Bond Yield`"
                                                            
                                                ),
                                                width = 2
                                              ),
                                           
                                           mainPanel(         
                                          
                                           plotlyOutput("scatterplot",width = "auto",height = "auto"),
                                           width = 8
                                           )
                                              ),

                                 
                                  # Fourth Tab
                                  tabPanel(h4("About"),
                                           
                                             mainPanel(
                                               titlePanel("About"),
                                               markdown("<h4> This Shiny app was created as a Project on Data Visualisation by Utpalraj Kemprai (utpalraj.mds2023@cmi.ac.in), M.Sc Data Science student
                                               at CMI under the guidance of Dr. Sourish Das (CMI). 
                                                        <h4>"),
                                               width = 9
                                             )
                                           
                                           )
                                  
                      )
                    )
)




# server
server <- function(input, output) {
  
  filtered_data <- reactive(
    dataset[dataset$Date >= input$date_range[1] & dataset$Date <= input$date_range[2], ]
    
  )
    output$boxplot <- renderPlotly(
      # ggplotly to make ggplot interactive like Plotly
      ggplotly(
      ggplot(data = filtered_data(), aes_string(y = input$economic_factor)) +
        theme_economist_white() +
        geom_boxplot(fill = 'skyblue') +
        labs(x = '', y = '') +
        theme(axis.title.x=element_blank(),
              axis.text.x=element_blank(),
              axis.ticks.x=element_blank(),
              text = element_text(size = 10),
              axis.title = element_text(size = 10)) +
        ggtitle(as.character(substr(as.character(input$economic_factor),2,nchar(as.character(input$economic_factor))-1))) 
      )%>%
        config(modeBarButtonsToRemove = c("zoomIn2d", "zoomOut2d","lasso2d","zoom","select2d","pan2d"
                                          ,"autoScale2d"))
    )
    
    
    output$plot_time_data <- renderPlotly(
      ggplotly(
      ggplot(data = filtered_data(), aes_string(x = 'Date',y = input$economic_factor)) +
        
  scale_x_date(date_labels = "%b %Y",date_breaks = "1 year") +
  
  theme_economist_white() +
  # Define the geometry as points and lines
  geom_point(shape = 20, color = 'blue',size = 0.75) +
  geom_line(color = 'blue') +

  # Customize the axis labels and plot theme
  labs(x = NULL,y = substr(as.character(input$economic_factor),2,nchar(as.character(input$economic_factor))-1)) +

  # Add a plot title
  ggtitle(paste("Time Series Data Plot for",substr(as.character(input$economic_factor),2,nchar(as.character(input$economic_factor))-1))) +

  # Add a plot frame
  theme(text = element_text(size=10),axis.text.x = element_text(angle=45, hjust=0.5),
        axis.title = element_text(size = 13))
    )%>%
    config(modeBarButtonsToRemove = c("zoomIn2d", "zoomOut2d","lasso2d","zoom","select2d","pan2d",
                                      "autoScale2d")) 
  )
    
    output$scatterplot <- renderPlotly({
      ggplotly(
      ggplot(data = dataset,aes_string(x=input$factor1,y=input$factor2))  +
        theme_economist_white() +
        geom_point(aes(color=years),size = 1) +
        labs(color = NULL) +
        geom_smooth(col = "black",method = 'lm',se = FALSE,size = 0.55) +
        theme(legend.text = element_text(size=8),axis.title.x.bottom = element_text(size = 8)
              ,axis.title.y.left = element_text(size = 8),axis.text.x = element_text(size = 8)
              ,axis.text.y = element_text(size = 10),text =element_text(size = 10)
              ,axis.title = element_text(size = 13)) +
        ggtitle(paste(substr(as.character(input$factor1),2,nchar(as.character(input$factor1))-1)
                      ,"vs",substr(as.character(input$factor2),2,nchar(as.character(input$factor2))-1)))
      )%>%
        config(modeBarButtonsToRemove = c("zoomIn2d", "zoomOut2d","lasso2d","zoom","select2d","pan2d",
                                          "autoScale2d"))
        
    })
    
  }

# Run the application 
shinyApp(ui = ui, server = server)
