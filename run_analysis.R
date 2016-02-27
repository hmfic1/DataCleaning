##  run_analysis.R

##    load appropriate packages

library(plyr)
library(dplyr)
library(tidyr)

##    delete any previous files and directories

if(file.exists("SamsungFile.txt")) {
  file.remove("SamsungFile.txt")
}

if(file.exists("SamsungFile2.txt")) {
  file.remove("SamsungFile2.txt")
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

##     get Activity names into Activity files, then replace variable names

ActivityTestIdx <- merge(ActivityTestFile, activityLabels)
colnames(ActivityTestIdx) <- c("Activity Number", "Activity")
ActivityTrainIdx <- merge(ActivityTrainFile, activityLabels)
colnames(ActivityTrainIdx) <- c("Activity Number", "Activity")

##     replace variable name in Subject files

colnames(SubjectTestFile) <- c("Subject")
colnames(SubjectTrainFile) <- c("Subject")

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

#    merge the mean() and std() datasets, and add the activity and subject variables

XTest0 <- cbind(XTestSelectedstd, XTestSelectedmean)
XTest1 <- cbind(ActivityTestIdx["Activity"], XTest0)
XTest2 <- cbind(SubjectTestFile, XTest1)

XTrain0 <- cbind(XTrainSelectedstd, XTrainSelectedmean)
XTrain1 <- cbind(ActivityTrainIdx["Activity"], XTrain0)
XTrain2 <- cbind(SubjectTrainFile, XTrain1)

##  merge the two data sets

FinalData <- rbind(XTest2, XTrain2)


##  gather, then separate

xx <- FinalData %>%
  gather(Measure, Measurement, `tBodyAcc-std()-X`:`fBodyGyro-mean()-Z`)
yy <- xx %>%
  separate(Measure, into=c("ActType", "MeasureType", "Axis"), sep ="\\-")
zz <- yy %>%
  group_by(Subject, Activity, ActType, MeasureType, Axis)
qq <- zz %>%
  summarize(AvgMeasure = mean(Measurement))

rr <- xx %>%
  group_by(Subject, Activity, Measure)
ss <- rr %>%
  summarize(AvgMeasure = mean(Measurement))

qq <- arrange(qq, Subject, Activity, ActType, MeasureType, Axis)
ss <- arrange(ss, Subject, Activity, Measure)

##    Initial Cleanup

##    Delete downloaded files

file.remove("data.zip")
unlink("UCI HAR Dataset", recursive = TRUE)

##    Write output file

write.table(qq, file = "SamsungFile.txt", sep = " ", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(ss, file = "SamsungFile2.txt", sep = " ", quote = FALSE, row.names = FALSE, col.names = FALSE)

##    Remove objects from environment

##    rm(list=ls())

print("End of Script")


##    Check your directory for the file "SamsungFile.txt

##    End
