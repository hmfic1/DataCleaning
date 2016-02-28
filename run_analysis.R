##  run_analysis.R

##    load appropriate R packages

library(plyr) 
library(dplyr)
library(tidyr)

##    To start off clean, delete any previous files and directories

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

##    Read files into datasets in current working directory

features <- read.table("./UCI HAR Dataset/features.txt")
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

XTestfile <- read.table("./UCI HAR Dataset/test/X_test.txt", strip.white = TRUE)
SubjectTestFile <- read.table("./UCI HAR Dataset/test/subject_test.txt")
ActivityTestFile <- read.table("./UCI HAR Dataset/test/y_test.txt")

XTrainfile <- read.table("./UCI HAR Dataset/train/X_train.txt", strip.white = TRUE)
SubjectTrainFile <- read.table("./UCI HAR Dataset/train/subject_train.txt")
ActivityTrainFile <- read.table("./UCI HAR Dataset/train/y_train.txt")

##    We are only getting the variables for mean (mean) and standard deviation (std) 
##    Determine columns and get the column names for mean() and std() variables

stdColumns <- grep(".std\\().", features$V2)
stdColumnNames <- grep(".std\\().", features$V2, value = TRUE)
meanColumns <- grep(".mean\\().", features$V2)
meanColumnNames <- grep(".mean\\().", features$V2, value = TRUE)

##     Now we know which columns ("stdColumns" and "meanColumns") have the data we want to evaluate
##     Subset test and training datasets ("Xtestfile" and "Xtrainfile"), getting only the mean() and std() columns 

XTestSelectedstd <- XTestfile[,stdColumns]
XTestSelectedmean <- XTestfile[,meanColumns]

XTrainSelectedstd <- XTrainfile[,stdColumns]
XTrainSelectedmean <- XTrainfile[,meanColumns]

##    The Subject and Activity datasets have the information about which test subject and which activity were performed
##    cbind the subject and activity data with the std and mean data

yy <- cbind(SubjectTestFile, ActivityTestFile, XTestSelectedstd, XTestSelectedmean)
zz <- cbind(SubjectTrainFile, ActivityTrainFile, XTrainSelectedstd, XTrainSelectedmean)

##     Merge the two data sets; this will be the dataset from which we can use dplyr and tidyr to evaluate the data

FinalData <- rbind(yy, zz)

##     Replace replace variable names using the colnames function

colnames(FinalData) <- c("Subject", "Activity", stdColumnNames, meanColumnNames)

##     Replace Activity values with text for easier evaluation

FinalData$Activity <- as.character(FinalData$Activity)
FinalData$Activity[FinalData$Activity == "1"] <- "WALKING"
FinalData$Activity[FinalData$Activity == "2"] <- "WALKING_UPSTAIRS"
FinalData$Activity[FinalData$Activity == "3"] <- "WALKING_DOWNSTAIRS"
FinalData$Activity[FinalData$Activity == "4"] <- "SITTING"
FinalData$Activity[FinalData$Activity == "5"] <- "STANDING"
FinalData$Activity[FinalData$Activity == "6"] <- "LAYING"


##     Gather the data based on the measurements

xx <- FinalData %>%
  gather(Measure, Measurement, `tBodyAcc-std()-X`:`fBodyGyro-mean()-Z`)

##     Now group the data and summarize

rr <- xx %>%
  group_by(Subject, Activity, Measure)
ss <- rr %>%
  summarize(AvgMeasure = mean(Measurement))

##     Sort the data by Subject, Activity, and Measure

ss <- arrange(ss, Subject, Activity, Measure)

##    Write output file, making sure to write character variables without quotes

write.table(ss, file = "SamsungFile.txt", sep = " ", quote = FALSE, row.names = FALSE)

##    Cleanup

##    Delete downloaded files including the original downloaded zipped file and all the unzipped files

file.remove("data.zip")
unlink("UCI HAR Dataset", recursive = TRUE)

##    Remove objects from environment

rm(list=ls())

##    End of Script
##
##    Check your working directory for the SamsungFile.txt file
##

