# Data Set Description
Please see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for details.

# Attribute Inforamtion
The following are an excerpt from "features_info.txt".

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation

# Data acquisition, merge, clean up, create the summary and write to the summary file
1. Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, unzip it
2. A R script called **run_analysis.R** was created to perform the following procedures
   * Read both the 30% test sample "X_test.txt" as "testx", "y_test.txt" as "testy", and training sample "X_train.txt" as "trainx", "y_train.txt" as "trainy" into the memory.
   * Get all the attributes by reading "features.txt"
   * Assign the attributes' name to the data frame (testx, trainx)
   * Subsetting the data frame with only mean and std using R regex
   * Merge subsettted "testy" and "tesetx" as "test", "trainy" and "trainx" as "train" using **cbind**, and then merge "test" and "train" as "dt" using **rbind**
   * Rename the data frame names by removing "()" and replace "-" by "."
   * Rename the first column as "activity" and coerce it to be "factor" and replace by WALKING, etc instead of 1 ... 6
   * Using group_by to break the dataset to groups according to factor "activity"
   * Use summarise_each to get the means of all the columns
   * Write the tidy data to "activity_tidy.txt"
   
