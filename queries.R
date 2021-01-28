library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)
#DataDB <- dbGetQuery(MyDataBase, "select CountryCode, Percentage from CountryLanguage where Language = 'Spanish' ")
DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
head(DataDB)

spanish_perc <- DataDB %>% filter(Language == "Spanish") %>% select(CountryCode, IsOfficial,Percentage)
spanish_perc

ggplot(spanish_perc, aes(x = Percentage, y = CountryCode, fill = IsOfficial)) + geom_col()
