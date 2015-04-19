<<<<<<< HEAD
# Getting-Cleaning-Data-Project
This repository hosts the R code and documentation files for the Data Science's course "Getting and Cleaning data", on Coursera.
The dataset used: Human Activity Recognition Using Smartphones
The working directory is called "UCI HAR Dataset" 

# Summary description of the project instructions:
You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set. 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set 
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Methodology
Begin by setting working directory and to locate folder that was downloaded for this project.
For Q1, I began by exploring the dataset, simple head/dim function
Note: Need to do a rbind followed by cbind or vice versa
Note: y = activity where x = subject 

First, I imported all test, training data by activity, subject, features, with header set as False. 

Second, rbind and cbind data, by activity then by subject and finally features. 

Third, I ensure proper naming of columns.

For Q2, It's a matter of researching the right function to use (happens to be select and matches to subject|activity|mean|SD

For Q3, I used the merge function to add the activityType label to the dataset based on activityId; followed by cleansing and sorting

For Q4, used the gsub function to remove double words, strip leading and trailing spaces, replace . with spaces and remove t and f prefixes. 

This is followed by recreation of column names for the dataset

For Q5, I begin by creating a datafram table (Dplyr). Next I create unique columns to avoid errors in summary. 

Next I group the data by subject and activitiy using group_by function 

Third, I calculate the mena for all features using Dplyr function (summarise_each)

Fourth, I reapply the clean column names and wrote table to create the tidy dataset from step 5. 

# Files to explore:
a) CodeBook.md  describes the variables, the data, and any transformations or work that was performed to clean up the data.
b) run_analysis.R  contains all the code to perform the analyses described in the 5 steps. 
c) The output of the 5th step is called  ProfCubetidy.txt.

# More on the data source
For each record,  there are three measurements for the  X ,  Y , and  Z  coordinates. The variables that start with  t = time domain, variables that start with  f  =  frequency domain. For every variable, there is a  mean  and an  std  measurement. To read a variable for example,  tBodyAcc.mean.X , is equal to the mean value for the  X  coordinate.

All the values are mean over all measurements for a particular subject and activity.
=======
# RepData_PeerAssessment1
>>>>>>> aa87ce1f9a4edd51d973e5463da2af9b80f08870
