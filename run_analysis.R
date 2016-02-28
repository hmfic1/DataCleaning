##  run_analysis.R

##    load appropriate packages

library(plyr) 
library(dplyr)
library(tidyr)

##    delete any previous files and directories

if(file.exists("SamsungFile.txt")) {
  file.remove("SamsungFile.txt")
}

if(file.exists("data.zip")) {
  file.remove("data.zip")
}

if(dir.exists("UCI HAR Dataset")) {
  unlink("UCI HAR Dataset", recursive = TRUE)
}

##    download and unzip data files

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip")
unzip("data.zip")

##    read files into datasets

features <-read.table("./UCI HAR Dataset/features.txt")
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

XTestfile <- read.table("./UCI HAR Dataset/test/X_test.txt", strip.white = TRUE)
SubjectTestFile <- read.table("./UCI HAR Dataset/test/subject_test.txt")
ActivityTestFile <- read.table("./UCI HAR Dataset/test/y_test.txt")

XTrainfile <- read.table("./UCI HAR Dataset/train/X_train.txt", strip.white = TRUE)
SubjectTrainFile <- read.table("./UCI HAR Dataset/train/subject_train.txt")
ActivityTrainFile <- read.table("./UCI HAR Dataset/train/y_train.txt")

##     get columns and column names for mean() and std()

stdColumns <- grep(".std\\().", features$V2)
stdColumnNames <- grep(".std\\().", features$V2, value = TRUE)
meanColumns <- grep(".mean\\().", features$V2)
meanColumnNames <- grep(".mean\\().", features$V2, value = TRUE)

##     subset test and training datasets, getting only the mean() and std() columns, and replace variable names

XTestSelectedstd <- XTestfile[,stdColumns]
colnames(XTestSelectedstd) <- stdColumnNames

XTestSelectedmean <- XTestfile[,meanColumns]
colnames(XTestSelectedmean) <- meanColumnNames

XTrainSelectedstd <- XTrainfile[,stdColumns]
colnames(XTrainSelectedstd) <- stdColumnNames

XTrainSelectedmean <- XTrainfile[,meanColumns]
colnames(XTrainSelectedmean) <- meanColumnNames

#    

yy <- cbind(SubjectTestFile, ActivityTestFile)
colnames(yy) <- c("Subject", "Activity")

yy$Activity <- as.character(yy$Activity)
yy$Activity[yy$Activity == "1"] <- "WALKING"
yy$Activity[yy$Activity == "2"] <- "WALKING_UPSTAIRS"
yy$Activity[yy$Activity == "3"] <- "WALKING_DOWNSTAIRS"
yy$Activity[yy$Activity == "4"] <- "SITTING"
yy$Activity[yy$Activity == "5"] <- "STANDING"
yy$Activity[yy$Activity == "6"] <- "LAYING"

XTest0 <- cbind(XTestSelectedstd, XTestSelectedmean)
XTest1 <- cbind(yy, XTest0)

zz <- cbind(SubjectTrainFile, ActivityTrainFile)
colnames(zz) <- c("Subject", "Activity")

zz$Activity <- as.character(zz$Activity)
zz$Activity[zz$Activity == "1"] <- "WALKING"
zz$Activity[zz$Activity == "2"] <- "WALKING_UPSTAIRS"
zz$Activity[zz$Activity == "3"] <- "WALKING_DOWNSTAIRS"
zz$Activity[zz$Activity == "4"] <- "SITTING"
zz$Activity[zz$Activity == "5"] <- "STANDING"
zz$Activity[zz$Activity == "6"] <- "LAYING"

XTrain0 <- cbind(XTrainSelectedstd, XTrainSelectedmean)
XTrain1 <- cbind(zz, XTrain0)

##  merge the two data sets

FinalData <- rbind(XTest1, XTrain1)


##  gather, then separate

xx <- FinalData %>%
  gather(Measure, Measurement, `tBodyAcc-std()-X`:`fBodyGyro-mean()-Z`)
rr <- xx %>%
  group_by(Subject, Activity, Measure)
ss <- rr %>%
  summarize(AvgMeasure = mean(Measurement))

ss <- arrange(ss, Subject, Activity, Measure)

##    Initial Cleanup

##    Delete downloaded files

file.remove("data.zip")
unlink("UCI HAR Dataset", recursive = TRUE)

##    Write output file

write.table(ss, file = "SamsungFile.txt", sep = " ", quote = FALSE, row.names = FALSE, col.names = FALSE)

##    Remove objects from environment

##    rm(list=ls())
##    unloadNamespace("tidyr")
##    unloadNamespace("dplyr")
##    unloadNamespace("plyr")

print("End of Script")


##    Check your directory for the file "SamsungFile.txt

##    End


