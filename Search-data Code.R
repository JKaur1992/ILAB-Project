setwd("C:/Users/jkaur/Desktop/MDSI/ILAB 1")

library(readxl)    #for reading excel
library(tidyverse) #for tidy
library(tidytext)  #for text analysis
library(dplyr)     #for dissecting data
library(Amelia)    #for missing data identification
library(tm)
library(wordcloud)

search <- read.csv("data/Searchpythonexport.csv")
XAdata <- read.csv("data/data.csv")

dim(search)
str(search)
names(search)

unique(search$text_clean)
unique(search$Market.Region) #only 3 regions shown - ANZ, Asia and EMEA. what about NA or LATAM??
unique(search$Account.Name)
unique(search$Practice)
unique(search$Program)
unique(search$Product)
unique(search$Unique.Searches)
unique(search$Web.V2.Contact.Role)

#drop spread of key term alignement/count
search = select(search, Year, Practice, Program, Product, Search, Contact.CEB.ID, Web.V2.Contact.Role, 
                First.Name, Last.Name, Title, Email, Account.Name, Market.Region, Industry, 
                Opportunity.Owner.First.Name, Opportunity.Owner.Last.Name, Unique.Searches, text_clean)

missmap(search, main = "Missing values vs observed") #why is this not showing any missing data?

#drop unnecessary variables
search2 = select(search, Year, Program, Product, Web.V2.Contact.Role, Title, Market.Region, Industry, Search, text_clean)
str(search2)
missmap(search2, main = "Missing values vs observed") #why is this not showing any missing data?

#start filtering out observations that are either incorrent, blank or not required

#remove blanks and CEB employee values from contact role

data <- search2 %>%
  filter(Web.V2.Contact.Role == "User" | Web.V2.Contact.Role == "Seniormost")

#this has remove Umang Kaur from Program and Product respectively, cleaning them up - CHECK to confirm
unique(data$Web.V2.Contact.Role)
unique(data$Program)
unique(data$Product)

#try to populate Market.Region data - fill in the blanks
Asia <- data %>%
  filter(Product == "CLC-TR Asia" | Product == "CLC-R Asia" | Product == "CLC-LD Asia" | Product == "CLC-Asia" | Product == "CLC-HR Asia")

#replace blank spaces with Asia - HOW???? I need this - #if product=X, then Market.region=Asia
Asia[,6] <- as.character(Asia$Market.Region)
Asia$Market.Region[which(Asia$Market.Region == "")] <- "Asia"

#none of these worked
#levels(Asia$Market.Region)[levels(Asia$Market.Region) == " "] <- "Asia"
#Asia$Market.Region <- ifelse(nchar(Asia$Market.Region)==" ", "Asia", Asia$Market.Region)

#Now do the same for LATAM
LATAM <- data %>%
  filter(Product == "CLC-LATAM")

LATAM[,6] <- as.character(LATAM$Market.Region)
str(LATAM)
LATAM$Market.Region[which(LATAM$Market.Region == "")] <- "LATAM"

#Now merge these datasets back into OG

#export the data
write.csv(data, "data/Clean_Search_data_Jas.csv", row.names = F)
