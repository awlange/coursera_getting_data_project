##
# Course Project for Coursera: Getting and Cleaning Data (September, 2014)
#
# Adrian W. Lange
##

## Load feature labels
featureLabels <- read.delim("UCI HAR Dataset/features.txt", sep="", header = FALSE, col.names=c("number", "labels"))
labels <- as.character(featureLabels[["labels"]])

## Load activity labels
activityLabels <- read.delim("UCI HAR Dataset/activity_labels.txt", sep="", header = FALSE, col.names=c("number", "activity"))
activities <- as.character(activityLabels[,"activity"])

## Determine which features we are keeping, which are the mean and standard deviation of the measurements only
keepLabels <- featureLabels[grepl("mean()", labels) | grepl("std()", labels),]
keepLabels$number <- paste("V", keepLabels[["number"]], sep="")

## Load all test data
print("Loading test data...")
test_data <- read.delim("UCI HAR Dataset/test/subject_test.txt", sep="", header = FALSE, col.names=c("Subject"))
test_data <- cbind(test_data, read.delim("UCI HAR Dataset/test/y_test.txt", sep="", header = FALSE, col.names=c("Activity")))
measurements <- read.delim("UCI HAR Dataset/test/X_test.txt", sep="", header = FALSE)
filter <- (colnames(measurements) %in% keepLabels$number)
measurements <- measurements[, filter]
colnames(measurements) <- keepLabels$labels
test_data <- cbind(test_data, measurements)

## Load all training data
print("Loading training data...")
train_data <- read.delim("UCI HAR Dataset/train/subject_train.txt", sep="", header = FALSE, col.names=c("Subject"))
train_data <- cbind(train_data, read.delim("UCI HAR Dataset/train/y_train.txt", sep="", header = FALSE, col.names=c("Activity")))
measurements <- read.delim("UCI HAR Dataset/train/X_train.txt", sep="", header = FALSE)
filter <- (colnames(measurements) %in% keepLabels$number)
measurements <- measurements[, filter]
colnames(measurements) <- keepLabels$labels
train_data <- cbind(train_data, measurements)


## Row bind both data into combined data frame
print("Merging data sets...")
## move row names up by the number of test data for merge
rownames(test_data) <- (nrow(train_data) + 1):(nrow(train_data) + nrow(test_data))
all_data <- rbind(test_data, train_data, all=TRUE)

## Map Activity number to label
all_ax <- all_data[["Activity"]]
for (i in 1:length(all_ax)) {
  all_data[i, "Activity"] <- activities[all_ax[i]]
}

## Now, compute the average of each variable for each activity and each subject.
## Per the provided notes, there are 30 subjects, numbered 1:30.
## Also, there are 6 activities. So, we will have 180 rows of data.

final_data <- data.frame(nrow=180, ncol=length(ncol(all_data)), col.names=colnames(all_data))




