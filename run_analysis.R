#Load library
library(dplyr)

#Create directory and download file
if (!file.exists("./gcdata")) {
  dir.create("gcdata")
}

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./gcdata/dataset.zip")

#Unzip
unzip(zipfile = "./gcdata/dataset.zip", exdir = "gcdata")


# Read the test and train text files in data frames
x_train <- read.table("./gcdata/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./gcdata/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./gcdata/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./gcdata/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./gcdata/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./gcdata/UCI HAR Dataset/test/subject_test.txt")

# Read the features and the activity labels
features <- read.table("./gcdata/UCI HAR Dataset/features.txt")

activityLabels <- read.table("./gcdata/UCI HAR Dataset/activity_labels.txt")
colnames(activityLabels) <- c("activityNumber", "activityName")

# Use the features and activity labels to name the columns of the data frames

colnames(x_train) <- features[, 2]
colnames(x_test) <- features[, 2]

colnames(y_train) <- "activityNumber"
colnames(y_test) <- "activityNumber"

colnames(subject_train) <- "subjectNumber"
colnames(subject_test) <- "subjectNumber"

#MERGE THE DATA FRAMES

train <- cbind(subject_train, x_train, y_train)
test <- cbind(subject_test, x_test, y_test)

fullData <- rbind(train, test)

# EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

mean_and_sd <- grepl("activityNumber|subjectNumber|mean|std", colnames(fullData))
mean_and_sd_data <- fullData[, mean_and_sd]

#USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

dataWithActivityNames <- merge(mean_and_sd_data, activityLabels, by = "activityNumber", all.x = TRUE)

# LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

colnames(dataWithActivityNames) <- gsub("^t", "time", colnames(dataWithActivityNames))
colnames(dataWithActivityNames) <- gsub("Acc", "Accelerometer", colnames(dataWithActivityNames))
colnames(dataWithActivityNames) <- gsub("^f", "frequency", colnames(dataWithActivityNames))
colnames(dataWithActivityNames) <- gsub("Gyro", "Gyroscope", colnames(dataWithActivityNames))
colnames(dataWithActivityNames) <- gsub("Mag", "Magnitude", colnames(dataWithActivityNames))
colnames(dataWithActivityNames) <- gsub("BodyBody", "Body", colnames(dataWithActivityNames))

# CREATE A TIDY DATASET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

tidyData <- dataWithActivityNames %>% 
  group_by(subjectNumber, activityNumber, activityName) %>% 
  summarize_all(mean)

return(tidyData)