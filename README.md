# Getting and Cleaning Data
## Final Project
### February, 2016

####   Backgroud
This project takes data from experiments performed by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto from the Università degli Studi di Genova.

The experiments were carried out with a group of 30 volunteers, age 19-48. Each volunteer performed six activities (Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, and Laying) wearing a Samsung Galaxy S II smartphone on the waist. Using the embedded accelerometer and gyroscope, the project team captured linear acceleration and angular velocity on three axes. 

Data was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

Additional information about the experiments can be found at:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

####    Running the R script

Before running the run_analysis.R script:
  
* Ensure that you have an internet connection established
* Open R Studio
* Ensure that you have the following packages installed: plyr, dplyr, tidyr
* Set your working directory to the directory of your choice
    + This script will download a zip file to your working directory
    + It will then unzip the downloaded file and read data from the directories and subdirectories created from the unzip command
* Open the run_analysis.R script in R Studio

This script will download the raw data into the current working directory. It will then unzip the data.

The script will perform various functions to merge data from the training and test files. It will then tidy the data by grouping and summarizing 

The script cleans up after itself. Data files downloaded (and unzipped) are eventually deleted. Additionally, the environment is cleaned of objects by the use of the rm(list=ls()) command at the end of the script.

Before cleaning the environment, the script will write the data out to a text file. The test file name will be SamsungFile.txt.


### Citation

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.