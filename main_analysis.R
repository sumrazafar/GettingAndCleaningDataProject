
library(reshape2)

filename <- "getdata_dataset.zip"

## Download the dataset if not present 
if(!file.exists(filename)){
	fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
	download.file(fileURL, filename, method="curl")
 }

## Check if unzip is not present - Unzip it
if (!file.exists("UCI HAR Dataset")) { 
	unzip(filename) 
}

## Load activity labels + features
	activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
	activityLabels[,2] <- as.character(activityLabels[,2])

	features <- read.table("UCI HAR Dataset/features.txt")
	features[,2] <- as.character(features[,2])

## Filter columns on mean and standard deviation - prepare dataset to be used as a reference 
	featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
## Subset
	featuresWanted.names <- features[featuresWanted,2]
	featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
	featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
## Cleaning
	featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)


## Load the training datasets
	training <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted] #pick on the template prepared above
	trainingActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
	trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

## merge the datasets loaded above
	train <- cbind(trainingSubjects, trainingActivities, training) #no columns specified, thus, binds on template specified above

## Load the test datasets
	test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
	testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
	testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

## merge the datasets loaded above
	test <- cbind(testSubjects, testActivities, test)

# merge the training and the test datasets 
allData <- rbind(train, test)

#add labels
colnames(allData) <- c("subject", "activity", featuresWanted.names)

# turn activities and subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)