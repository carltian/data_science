rm(list=ls())
library(data.table)
library(plyr)

## read the training and testing data set into R
X_test        <- read.table("test/X_test.txt", header=F, stringsAsFactors=FALSE)
y_test        <- read.table("test/y_test.txt", header=F, stringsAsFactors=FALSE)
subject_test  <- read.table("test/subject_test.txt", header=F, stringsAsFactors=FALSE)

X_train       <- read.table("train/X_train.txt", header=F, stringsAsFactors=FALSE)
y_train       <- read.table("train/y_train.txt", header=F, stringsAsFactors=FALSE)
subject_train <- read.table("train/subject_train.txt", header=F, stringsAsFactors=FALSE)

## read the features and take its second column's transpose
features <- read.table("features.txt", header=F)
features <- t(features[2])

## read the activity labels
activity <- read.table("activity_labels.txt", header=F)

## give names to the data set
names(X_test)  <- features
names(X_train) <- features
names(y_test)  <- c("activity")
names(y_train) <- c("activity")
names(subject_test)  <- c("subject")
names(subject_train) <- c("subject")

## subset X_test and X_train data set
X_test  <- X_test[grepl("mean\\(\\)|std\\(\\)", names(X_test))]
X_train <- X_train[grepl("mean\\(\\)|std\\(\\)", names(X_train))]
test  <- cbind(X_test, y_test)
test  <- cbind(test, subject_test)
train <- cbind(X_train, y_train)
train <- cbind(train, subject_train)
merged <- rbind(test, train)
merged$subject <- factor(merged$subject)
merged$activity <- factor(merged$activity)

## rename the activity levels from numbers to more descriptive characters
merged$activity <- mapvalues(merged$activity, from = as.character(activity[[1]]), to = as.character(activity[[2]]))

## split and calculate the ave using pipeline operations
sum_merged <- merged %>% group_by(activity, subject) %>% summarise_each(funs(mean))
## please note that the split/group_by and summarise can be done by calling apply functions

## write the tidy data to tidydata.txt with a dimension of 180 x 68 
write.table(sum_merged, file="tidydata.txt",row.names=FALSE)
