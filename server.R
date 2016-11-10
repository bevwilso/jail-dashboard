
shinyServer(function(input, output) {
	output$plot1 <- renderHighchart({
	downtown <- subset(data, select=c(Tot.Pop.Downtown, Date))
	satellite <- subset(data, select=c(Tot.Pop.Satellite, Date))
	highchart() %>% 
      hc_chart(type="area") %>% 
      hc_xAxis(categories = unique(as.Date(downtown$Date, "%m/%d/%Y")),
               tickmarkPlacement = 'on') %>% 
      hc_yAxis(title = list(text = "Persons")) %>% 
	    hc_add_series(data=satellite$Tot.Pop.Satellite, name = "Satellite Facility", color="orange") %>%
	    hc_add_series(data=downtown$Tot.Pop.Downtown, name = "Downtown Facility", color = "dodgerblue") %>%
	    hc_add_theme(hc_theme_gridlight())
	})
	
  output$total <- renderValueBox({
    valueBox(
      value = data.sorted$Tot.Pop[1],
      subtitle = "Total Jail Population Today",
      icon = icon("area-chart"),
      color = "yellow"
    )
  })
  output$sentenced <- renderValueBox({
    valueBox(
      value = data.sorted$Tot.Pop.Sentenced[1],
      subtitle = "Total Inmates Sentenced",
      icon = icon("balance-scale"),
      color = "light-blue"
    )
  })

  output$unsentenced <- renderValueBox({
    valueBox(
      value = data.sorted$Tot.Pop.Unsentenced[1], 
      "Total Inmates Unsentenced",
      icon = icon("clock-o"),
      color = "aqua"
    )
  })

  
  output$bookings <- renderValueBox({
    valueBox(
      value = data.sorted$Bookings[1],
      subtitle = "Total Bookings Yesterday",
      icon = icon("book"),
      color = "yellow"
    )
  })
  output$transfers <- renderValueBox({
    valueBox(
      value = data.sorted$Transfers[1],
      subtitle = "Total Inmates Transferred",
      icon = icon("exchange"),
      color = "light-blue"
    )
  })
  
  output$releases <- renderValueBox({
    valueBox(
      value = data.sorted$Releases[1], 
      "Total Inmates Released Yesterday",
      icon = icon("sign-out"),
      color = "aqua"
    )
  })
  
  
  output$table1 <- renderTable({
    lval <- dim(change.data)[1]
    lval <- lval * -1
    change.data.display <- change.data[order(-1:lval),] 
    change.data.display <- head(change.data.display, 11)
  }, digits = 1, include.rownames=FALSE)
  
  output$downloadCsv <- downloadHandler(
    filename = "jail_pop_summary.csv",
    content = function(file) {
      write.csv(data, file)
    },
    contentType = "text/csv"
  )

  output$rawtable <- renderPrint({
    orig <- options(width = 1000)
    print((tail(data, input$maxrows)),row.names=FALSE)
    options(orig)
  })
})






