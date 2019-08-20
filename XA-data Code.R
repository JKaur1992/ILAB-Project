setwd("C:/Users/jkaur/Desktop/MDSI/ILAB 1")

library(readxl)    #for reading excel
library(tidyverse) #for tidy
library(tidytext)  #for text analysis
library(dplyr)     #for dissecting data
library(Amelia)    #for missing data identification
library(tm)
library(wordcloud)

XAdata <- read.csv("data/data.csv")
POCdata <- read.csv("data/POCdata.csv")

str(XAdata)
names(XAdata)
unique(XAdata$Entitlement)

XAdata = select(XAdata, Type, FULLFILMENT_DT, Quarter, Aligned.Core.Topic, Primary.KI, Client.Question, Client.Title, Entitlement, 
                Account.Region, Account.Country, Account.Sector, Account.Sub.Sector, Hashtags, Advice.and.Impact)

XAdata <- XAdata %>%
  separate(.,"FULLFILMENT_DT",c("Year","Month"),sep="-")

#export the data
write.csv(XAdata, "data/clean_XAdata_Jas.csv", row.names = F)
