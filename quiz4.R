library(dplyr)

## q1
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
if(!file.exists("./data/housing_idaho.csv")){download.file(fileUrl1,destfile="./data/housing_idaho.csv",method="curl")}
if(!file.exists("./data/cookbook.pdf")){download.file(fileUrl2,destfile="./data/cookbook.pdf",method="curl")}

housingdata <- read.csv("./data/housing_idaho.csv")
list <-strsplit(names(housingdata),split="wgtp")
list[[123]]

## q2

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
if(!file.exists("./data/gdp.csv")){download.file(fileUrl1,destfile="./data/gdp.csv",method="curl")}

data <- read.csv("./data/gdp.csv",skip=4, nrows=190)
cleanedData <- gsub(",","",data$X.4)
cleanedData <- (as.numeric(cleanedData))
mean(cleanedData,na.rm = TRUE)

## q3

countryNames <- data$X.3
length(grep("^United",countryNames))

## q4

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
if(!file.exists("./data/gdpdata.csv")){download.file(fileUrl1,destfile="./data/gdpdata.csv",method="curl")}

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
if(!file.exists("./data/educationaldata.csv")){download.file(fileUrl1,destfile="./data/educationaldata.csv",method="curl")}

gdpdata <- read.csv("./data/gdpdata.csv",skip=4,nrows=190)
educationaldata <- read.csv("./data/educationaldata.csv")

# Merge the two datasets
mergedData <- merge(gdpdata,educationaldata,by.x="X", by.y="CountryCode")
fy.june <- grep('Fiscal year end: June', mergedData$Special.Notes)
length(fy.june)

## q5

library(quantmod)

amzn = getSymbols("AMZN",auto.assign=FALSE)

sampleTimes = index(amzn) 

year2012 <- grepl('2012-*', sampleTimes)
sampleTimes2012 <- subset(sampleTimes, year2012)
day <- format(sampleTimes2012, '%A')
table(day)
table(year2012)