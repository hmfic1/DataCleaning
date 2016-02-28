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
##     Then, replace replace variable names using the colnames function

XTestSelectedstd <- XTestfile[,stdColumns]
colnames(XTestSelectedstd) <- stdColumnNames

XTestSelectedmean <- XTestfile[,meanColumns]
colnames(XTestSelectedmean) <- meanColumnNames

XTrainSelectedstd <- XTrainfile[,stdColumns]
colnames(XTrainSelectedstd) <- stdColumnNames

XTrainSelectedmean <- XTrainfile[,meanColumns]
colnames(XTrainSelectedmean) <- meanColumnNames

##    The Subject and Activity datasets have the information about which test subject and which activity were performed
##    cbind the subject and activity data, replace the variable names, and replace the activity values with descriptive names
##    Because we're doing this for both the test data and the training data, we'll perform the activities twice

yy <- cbind(SubjectTestFile, ActivityTestFile)
colnames(yy) <- c("Subject", "Activity")

yy$Activity <- as.character(yy$Activity)
yy$Activity[yy$Activity == "1"] <- "WALKING"
yy$Activity[yy$Activity == "2"] <- "WALKING_UPSTAIRS"
yy$Activity[yy$Activity == "3"] <- "WALKING_DOWNSTAIRS"
yy$Activity[yy$Activity == "4"] <- "SITTING"
yy$Activity[yy$Activity == "5"] <- "STANDING"
yy$Activity[yy$Activity == "6"] <- "LAYING"

zz <- cbind(SubjectTrainFile, ActivityTrainFile)
colnames(zz) <- c("Subject", "Activity")

zz$Activity <- as.character(zz$Activity)
zz$Activity[zz$Activity == "1"] <- "WALKING"
zz$Activity[zz$Activity == "2"] <- "WALKING_UPSTAIRS"
zz$Activity[zz$Activity == "3"] <- "WALKING_DOWNSTAIRS"
zz$Activity[zz$Activity == "4"] <- "SITTING"
zz$Activity[zz$Activity == "5"] <- "STANDING"
zz$Activity[zz$Activity == "6"] <- "LAYING"

##     cbind the data for the std() and mean() extracted data, then add the descriptors (subject, activity to the front)

XTest0 <- cbind(XTestSelectedstd, XTestSelectedmean)
XTest1 <- cbind(yy, XTest0)

XTrain0 <- cbind(XTrainSelectedstd, XTrainSelectedmean)
XTrain1 <- cbind(zz, XTrain0)

##     Merge the two data sets; this will be the dataset from which we can use dplyr and tidyr to evaluate the data

FinalData <- rbind(XTest1, XTrain1)

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

##    Initial Cleanup

##    Delete downloaded files including the original downloaded zipped file and all the unzipped files

file.remove("data.zip")
unlink("UCI HAR Dataset", recursive = TRUE)

##    Write output file, making sure to write character variables without quotes and to write data without headers

write.table(ss, file = "SamsungFile.txt", sep = " ", quote = FALSE, row.names = FALSE, col.names = FALSE)

##    Remove objects from environment

rm(list=ls())

print("End of Script")
print("Check your directory for the file SamsungFile.txt")

##    End


