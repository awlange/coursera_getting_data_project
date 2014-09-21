Course Project 
=============================

This is my Course Project for Coursera: Getting and Cleaning Data.

## Project prompt (copied from Coursera)
You should create one R script called run_analysis.R that does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Submitted Script Description

The R script for the project (run_analysis.R) does the above, though some of the details in the prompt
are a little unclear. The data for project is contained in the directory 
[UCI HAR Dataset](https://github.com/awlange/coursera_getting_data_project/tree/master/UCI%20HAR%20Dataset),
which also contains the code book describing the variables produced in the analysis.

The script works by reading the whitespace delimited files for the "test" and "train" data and loading
this data into respective data frames. Because the prompt asks only for those features that are means and
standard deviations of the measurements of the raw data, the script applies a filter to remove
feature columns that don't comply based on grep-ing for "mean()" and "std()" within the name for each
feature. The filtered test and train data frame are then combined into a single data frame. Subsequently,
per the prompt, the activity column is mapped from integer value to character string value (e.g. 1 -> WALKING).
Finally, the script loops through all combinations of subjects and activities to compute the average of each
feature (i.e. the mean and standard deviation features). This data is then written to a text file named "output.txt",
which was submitted to Coursera separately.
