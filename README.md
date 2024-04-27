# Getting and Cleaning Data Course Project
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.  This repo explains how all of the scripts work and how they are connected.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 ### Repository Content
 This repository contains 4 files:
 1. README.md -> this file that describes the project's objective, the content of the repository and the files, how they were produced and the way the files are related;


 2. run_analysis.R -> the R script that contains the program which:
    Merges the training and the test sets to create one data set;
    Extracts only the measurements on the mean and standard deviation for each measurement;
    Uses descriptive activity names to name the activities in the data set;
    Appropriately labels the data set with descriptive variable names;
    Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

3. tidyData.txt -> the final tidy data set obtained from the process of cleaning the raw data with the steps contained in run_analysis.R;

4. codeBook.md ->  a code book that describes the variables, the data, and any transformations or work that has been performed to clean up the data.
