
dashboardPage(
  dashboardHeader(title = "Champaign County Jail Population"),
  dashboardSidebar(
	sidebarMenu(
      menuItem("Dashboard", tabName = "Dashboard"),
      menuItem("Raw Data", tabName = "Rawdata")
	)
  ),
  dashboardBody(
	 tabItems(
      tabItem("Dashboard",
        fluidRow(
          valueBoxOutput("total"),
          valueBoxOutput("sentenced"),
          valueBoxOutput("unsentenced")
        ),
        fluidRow(
          box(
            width = 8, status = "info", solidHeader = TRUE,
            title = "Distribution by Location",
#            plotOutput("plot1")
		        highchartOutput("plot1") 
          ),
          box(
            width = 4, status = "info",
            title = "Change in Jail Population",
            tableOutput("table1")
          )
        ),
        fluidRow(
          valueBoxOutput("bookings"),
          valueBoxOutput("transfers"),
          valueBoxOutput("releases")
        )     
      ),
      tabItem("Rawdata",
        numericInput("maxrows", "Rows to show", 25, min=1, max=dim(data)[1]),
        verbatimTextOutput("rawtable"),
        downloadButton("downloadCsv", "Download All Data as CSV")
      )
    )
  )
)

