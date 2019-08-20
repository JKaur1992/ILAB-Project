setwd("C:/Users/jkaur/Desktop/MDSI/ILAB 1")

library(readxl)
library(tidyverse)
library(tidytext)
library(tm)
library(wordcloud)

twitter <- read_excel("Data/twitterDataVerified_20190627_HJ.xlsx")
dim(twitter)
str(twitter)
names(twitter)

unique()
twitter = select(twitter, )