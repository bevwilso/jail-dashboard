library(shiny)
library(shinydashboard)
library(highcharter)
library(dplyr)
library(tidyr)
library(rdrop2)
library(lubridate)
library(RCurl)


data <- read.csv('jail_pop_summary.csv')    
data$Date <- as.Date(data$Date, format="%m/%d/%Y")
y.limit <- max(data$Tot.Pop)
output.table <- data
Chg.Tot.Pop <- diff(data$Tot.Pop) 
daye <- lubridate::wday(data$Date, label=T, abbr = F)

k <- list()
for (i in 1:((length(daye)) - 1)) {
  k[i] <- (paste0(daye[i], " to ", daye[i+1], ""))   
}
Chg.Tot.Pop.Labels <- as.character(k)
change.data <- cbind.data.frame(Chg.Tot.Pop.Labels, Chg.Tot.Pop)
colnames(change.data ) <- c("Period", "Change in Total Population")

lval <- dim(data)[1]
lval <- lval * -1
data.sorted <- data[order(-1:lval),] 


