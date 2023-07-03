install.packages("shinyWidgets")
install.packages("highcharter")

library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(timetk)
library(h2o)
library(modeltime)

ui = dashboardPage(
  dashboardHeader(title = "Walmart Sales Prediction"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Upload Data", tabName = "upload"),
      menuItem("Predictions", tabName = "predictions")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "upload",
              fileInput("data_file", "Upload Data",
                        accept = c(".xlsx"))),
      tabItem(tabName = "predictions",
              highchartOutput("chart"),
              dataTableOutput("predictions_table"))
    )
  )
)

server = function(input, output) {
  data = reactive({
    req(input$data_file)
    infile = input$data_file
    if (is.null(infile))
      return(NULL)
    timetk::read_excel(infile$datapath)
  })
  
  model_fit_h2o = reactive({
    train_size = floor(0.8 * nrow(data()))
    train_data = data()[1:train_size, ]
    test_data = data()[(train_size + 1):nrow(data()), ]
    
    h2o.init()
    model_spec_h2o = automl_reg(mode = "regression") %>% 
      set_engine(
        'h2o', max_runtime_secs = 360,
        nfolds = 5, seed = 123,
        verbosity = NULL,
        max_runtime_secs_per_model = 3)
    
    model_fit_h2o = model_spec_h2o %>% fit(Weekly_Sales ~ ., train_data)  
    model_fit_h2o
  })
  
  data_prepared = reactive({
    train_size = floor(0.8 * nrow(data()))
    train_data = data()[1:train_size, ]
    test_data = data()[(train_size + 1):nrow(data()), ]
    
    bind_rows(train_data, test_data)
  })
  
  predictions = reactive({
    refit = modeltime(model_fit_h2o()) %>% 
      modeltime_refit(data = data_prepared())
    
    future = data_prepared() %>% 
      group_by(id) %>% 
      future_frame(.length_out = '2 years', .date_var = Date) %>% 
      ungroup()
    
    future_prepared = refit %>% 
      modeltime_prepare_new_data(new_data = future)
    
    refit %>% 
      modeltime_forecast(
        new_data = future_prepared,
        actual_data = data_prepared(),
        keep_data = TRUE
      ) %>% 
      group_by(id) %>% 
      modeltime_table() %>%
      ungroup()
  })
  
  output$chart = renderHighchart({
    chart_data = predictions()
    
    highchart() %>%
      hc_title(text = "Walmart Sales Predictions") %>%
      hc_add_series_timeseries(chart_data, x = "Date", y = "Prediction") 
  })
  
  output$predictions_table = renderDataTable({
    predictions()
  })
}

shinyApp(ui, server)

