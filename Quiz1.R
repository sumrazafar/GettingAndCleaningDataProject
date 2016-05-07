setwd("~/Documents/Coursera/Getting and Cleaning Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url=fileUrl,destfile="idaho_housing.csv",mode="w",method="curl")
list.files(".")
dateDownloaded <- date()
dateDownloaded
idaho_housing <- read.csv("idaho_housing.csv")
head(idaho_housing)
length(idaho_housing$VAL[!is.na(idaho_housing$VAL) & idaho_housing$VAL==24])

#################
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url=fileUrl1, destfile="gov_NGAP.xlsx", mode="w", method="curl")
dateDownloaded <- date()
print(dateDownloaded)
library(xlsx)
rowIndex <- 18:23
colIndx <- 7:15
dat <- read.xlsx(file="gov_NGAP.xlsx",sheetIndex=1,colIndex=colIndx,startRow=18, endRow=23, header=TRUE)
head(dat)
sum(dat$Zip*dat$Ext,na.rm=T)


#######

library(XML)
fileUrl2 <- "http://d396qusza40orc.cloudfront.net/getdata/data/restaurants.xml"
doc <- xmlTreeParse(file=fileUrl2,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
zipcode <- xpathSApply(rootNode,"//zipcode",xmlValue)
length(zipcode[zipcode==21231])

#######

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url=fileUrl1, destfile="fsspid.csv", mode="w", method="curl")
dateDownloaded <- date()
print(dateDownloaded)
install.packages("data.table")
library(data.table)
DT <- fread(input="fsspid.csv", sep=",")
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15))  
system.time(mean(DT[DT$SEX==2,]$pwgtp15))


