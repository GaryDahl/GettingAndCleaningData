# this function collects and cleans accelerometer data collected by Samsung Galaxy S smartphones
run_analysis <- function()
{
    # download and unzip source data, if that hasn't already been done
    dataFolder <- "UCI HAR Dataset"
    if(!file.exists(dataFolder))
    {
        dataURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        dataFile <- paste(dataFolder, "zip", sep=".")
        download.file(dataURL, paste(getwd(), dataFile, sep="/"))
        unzip(dataFile)
    }
    
    # read data into R
    features <- read.table(paste(dataFolder, "features.txt", sep="/"))
    activities <- read.table(paste(dataFolder, "activity_labels.txt", sep="/"))
    
    testData <- read.table(paste(dataFolder, "test", "X_test.txt", sep="/"))
    testSubject <- read.table(paste(dataFolder, "test", "subject_test.txt", sep="/"))
    testActivity <- read.table(paste(dataFolder, "test", "y_test.txt", sep="/"))
    
    trainData <- read.table(paste(dataFolder, "train", "X_train.txt", sep="/"))
    trainSubject <- read.table(paste(dataFolder, "train", "subject_train.txt", sep="/"))
    trainActivity <- read.table(paste(dataFolder, "train", "y_train.txt", sep="/"))
    
    # merge data
    # columns: subject, activity, then accelerometer measurements/features
    # rows: test data followed by train data
    testData <- cbind(testSubject, testActivity, testData)
    trainData <- cbind(trainSubject, trainActivity, trainData)
    data <- rbind(testData,trainData)
    
    # label columns
    features <- as.vector(features[,2])
    names(data) <- c("Subject", "Activity", features)

    # extract measurements that are not on the mean or standard deviation
    # (keeping the subject and activity fields)
    keepIndexes <- grepl("mean()",names(data),fixed=TRUE) | grepl("std()",names(data),fixed=TRUE)
    keepIndexes[1] <- TRUE
    keepIndexes[2] <- TRUE
    data <- data[,keepIndexes]
    
    # replace activity codes with descriptive activity names
    data$Activity <- activities[data$Activity,2]
    
    # find average of each variable for each activity and subject
    columnsToAverage <- seq(3,dim(data)[2])
    tidyData <- aggregate(data[,columnsToAverage], by=list(data$Subject,data$Activity), FUN=mean)
    names(tidyData)[1] <- "Subject"
    names(tidyData)[2] <- "Activity"
    
    # order data by subject first, and then by activity
    tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
    row.names(tidyData) <- NULL

    # save tidy data in a txt file
    tidyFilename <- "tidy UCI HAR Dataset.txt"
    write.table(tidyData, tidyFilename)
    # this tidy data can be read back into R with:
    tidyData <- read.table(tidyFilename)
    
    # return this tidy data
    tidyData
}

