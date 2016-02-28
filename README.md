# Getting and Cleaning Data
## Final Project
### February, 2016

This project takes data 


Before running the run_analysis.R script:
  
* Ensure that you have an internet connection established
* Open R Studio
* Ensure that you have the following packages installed: plyr, dplyr, tidyr
* Set your working directory to the directory of your choice
    + This script will download a zip file to your working directory
    + It will then unzip the file
* Open the run_analysis.R script in R Studio


The script cleans up after itself. Data files downloaded (and unzipped) are eventually deleted. Additionally, the environment is cleaned of objects by the use of the rm(list=ls()) command at the end of the script.




Citation:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.