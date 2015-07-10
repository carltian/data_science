# How to run the code
1. Check out the code by 'git clone https://github.com/carltian/data_science/tree/master/Getting_and_Cleaning_Data/project_2'
1. Download the data files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the data file and link the UCI HAR Dataset to "data" for less typing
3. Load R/Rstudio, and run source ("run_analysis.R")
4. The tidy data is saved as tidydata.txt which has 180 rows and 68 columns. The first column is activities: WALKING, WALKING_UPSTAIRS,
   WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING; and the second column is subject 1-30. Columns 3-68 are the measured variables.