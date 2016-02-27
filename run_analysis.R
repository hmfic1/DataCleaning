##  run_analysis.R

##    set working directory
setwd("~")

##    load appropriate packages

library(plyr)
library(dplyr)

##    make sure that directories are set up correctly

if(dir.exists("data.zip")) {
  file.remove("data.zip")
}

if(dir.exists("UCI HAR Dataset")) {
  unlink("UCI HAR Dataset")
}

##    download and unzip data files

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip")
unzip("data.zip")

features <-read.table("~/UCI HAR Dataset/features.txt")
activityLabels <- read.table("~/UCI HAR Dataset/activity_labels.txt")

XTestfile <- read.table("~/UCI HAR Dataset/test/X_test.txt", strip.white = TRUE)
SubjectTestFile <- read.table("~/UCI HAR Dataset/test/subject_test.txt")
ActivityTestFile <- read.table("~/UCI HAR Dataset/test/y_test.txt")

XTrainfile <- read.table("~/UCI HAR Dataset/train/X_train.txt", strip.white = TRUE)
SubjectTrainFile <- read.table("~/UCI HAR Dataset/train/subject_train.txt")
ActivityTrainFile <- read.table("~/UCI HAR Dataset/train/y_train.txt")

head(names(XTestfile), 20)
head(XTestfile[1:3])
class(XTestfile$V1)

head(names(XTrainfile), 20)
head(XTrainfile[1:3])
class(XTrainfile$V1)

head(SubjectTestFile)
head(ActivityTestFile)
table(SubjectTestFile)
table(ActivityTestFile)

head(SubjectTrainFile)
head(ActivityTrainFile)
table(SubjectTrainFile)
table(ActivityTrainFile)

class(XTestfile$V1)


XTrain1 <- cbind(ActivitytrainFile, Xtrainfile)
Xtrain2 <- cbind(SubjecttrainFile, XTrain1)
head(Xtrain2[1:10])

XTest1 <- cbind(ActivityTestFile, XTestfile)
XTest2 <- cbind(SubjectTestFile, XTest1)
head(XTest2[1:10])

##  merge the two data sets



##  remove the unneeded columns

colnames(XTest2) <- c("Subject", "Activity", as.character(features$V2))

stdColumns <- grep(".std\\().", features$V2)
stdColumnNames <- grep(".std\\().", features$V2, value = TRUE)
meanColumns <- grep(".mean\\().", features$V2)
meanColumnNames <- grep(".mean\\().", features$V2, value = TRUE)

XTestSelectedstd <- XTestfile[,stdColumns]
colnames(XTestSelectedstd) <- stdColumnNames
XTestSelectedmean <- XTestfile[,meanColumns]
colnames(XTestSelectedmean) <- meanColumnNames
XTest0 <- cbind(XTestSelectedstd, XTestSelectedmean)
XTest1 <- cbind(Activity = ActivityTestFile, XTest0)
Xtest2 <- cbind(Subject = SubjectTestFile, XTest1)

##  contains(x, ignore.case = TRUE): selects all variables whose name contains x
head(select(XTest2, contains(".mean\\().")))


##  replace variable names



##  melt? data frame






