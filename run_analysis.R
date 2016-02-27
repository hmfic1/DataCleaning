##  run_analysis.R

##    setwd("/Users/Jim/DataCleaning")
setwd("~")

##    load appropriate packages

library(plyr)
library(dplyr)

##    set working directory
##    

##    set the base working directory
##    basewd <- getwd()
##    setwd(basewd)

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
setwd("UCI HAR Dataset")
##      features <- read.table("features.txt")
##      activityLabels <- read.table("activity_labels.txt")

features <-read.table("~/UCI HAR Dataset/features.txt")
activityLabels <- read.table("~/UCI HAR Dataset/activity_labels.txt")

##      setwd("test")

##      XTestfile <- read.table("X_test.txt", strip.white = TRUE)
XTestfile <- read.table("~/UCI HAR Dataset/test/X_test.txt", strip.white = TRUE)
##      SubjectTestFile <- read.table("subject_test.txt")
SubjectTestFile <- read.table("~/UCI HAR Dataset/test/subject_test.txt")
##      ActivityTestFile <- read.table("y_test.txt")
ActivityTestFile <- read.table("~/UCI HAR Dataset/test/y_test.txt")

##      setwd(basewd)
##      setwd("UCI HAR Dataset/train")

##      Xtrainfile <- read.table("X_train.txt", strip.white = TRUE)
##      SubjecttrainFile <- read.table("subject_train.txt")
##      ActivitytrainFile <- read.table("y_train.txt")

XTrainfile <- read.table("~/UCI HAR Dataset/train/X_train.txt", strip.white = TRUE)
SubjectTrainFile <- read.table("~/UCI HAR Dataset/train/subject_train.txt")
ActivityTrainFile <- read.table("~/UCI HAR Dataset/train/y_train.txt")

head(names(Xtrainfile), 20)
head(Xtrainfile[1:3])
class(Xtrainfile$V1)

head(SubjecttrainFile)
head(ActivitytrainFile)
table(SubjecttrainFile)
table(ActivitytrainFile)

head(names(XTestfile), 3)
head(names(XTestfile), 20)
head(XTestfile[1:3])

class(XTestfile$V1)


XTrain1 <- cbind(ActivitytrainFile, Xtrainfile)
Xtrain2 <- cbind(SubjecttrainFile, XTrain1)
head(Xtrain2[1:10])

XTest1 <- cbind(ActivityTestFile, XTestfile)
XTest2 <- cbind(SubjectTestFile, XTest1)
head(XTest2[1:10])

##  merge the two data sets



##  remove the unneeded columns

v <- as.character(features$V2)
colnames(XTest2) <- c("Subject", "Activity", as.character(features$V2))



grep

grep(".std\\().", features$V2, value = TRUE)
grep(".mean\\().", features$V2, value = TRUE)

##  contains(x, ignore.case = TRUE): selects all variables whose name contains x
head(select(XTest2, contains(".mean\\().")))


##  replace variable names



##  melt? data frame






