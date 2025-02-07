setwd("H:/School Again!/A.Coursera/2.Data Science Specialization/3.Getting and Cleaning Data/Quizzes/1.week1/Getting-Cleaning-Data") # setting the wd right
# checking if file/directory "data" exists, creating one if not
if(!file.exists("data")){
  dir.create("data")
}

##Question 1
# ----------
#The American Community Survey distributes downloadable data about United States communities.
#Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
#and load the data into R. The code book, describing the variable names is here: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
#How many properties are worth $1,000,000 or more?

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/idahoHousingSurveyData.csv")
list.files("./data")
dateDownloaded <- date()
dateDownloaded
setwd("./data") # setting the wd to directory "data"

myData <- read.csv("idahoHousingSurveyData.csv") # reading the downloaded file into R
sum(!is.na(myData$VAL[myData$VAL == 24]))
# Answer : 53

#Question 2
#Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?
#a)Each tidy data table contains information about only one type of observation.
#b)Tidy data has one variable per column.
#c)Numeric values in tidy data can not represent categories.
#d)Tidy data has variable values that are internally consistent.

#Answer : a)

#Question 3
#----------
#Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
#Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
#dat 
#What is the value of:
#sum(dat$Zip*dat$Ext,na.rm=T) 
#(original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)
install.packages("xlsx") # installing the package "xlsx" to help deal with xcel files
library(xlsx) # loading the 'xlsx' package into r

if(file.exists("data")){ 
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./naturalGaz.xlsx", mode = "wb")
dateDownloaded <- date()
list.files("./data")
dateDownloaded

colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./naturalGaz.xlsx", sheetIndex = 1, colIndex = colIndex,rowIndex = rowIndex )
sum(dat$Zip*dat$Ext, na.rm=T)
## Answer : [1] 36534720


#Question 4
#---------
#Read the XML data on Baltimore restaurants from here: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
#How many restaurants have zipcode 21231?

install.packages("XML")
library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile = "./baltimoreRestaurants.xml")
doc <- xmlTreeParse("./baltimoreRestaurants.xml", useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
# extracting all the zipcodes regardless
zipcodes1 <- xpathSApply(rootNode, "//zipcode ", xmlValue)
zipcodes2 <- sum (zipcodes1 == 21231)
zipcodes2

#or 
sum( xpathSApply(rootNode, "//zipcode", xmlValue) == 21231)
##Answer : 127

#Question 5
#---------
#The American Community Survey distributes downloadable data about United States communities.
#Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
#using the fread() command load the data into an R object
#DT 
#Which of the following is the fastest way to calculate the average value of the variable
#pwgtp15 
install.packages("data.table")
library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./idahoHousing.csv")
microdata <- read.csv("idahoHousing.csv")
file <- tempfile()
write.table(microdata, file = file, row.names = F, col.names = T, sep =",")
DT <- fread(file)

# answer: DT[,mean(pwgtp15),by=SEX]
