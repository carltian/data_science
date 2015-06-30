library(plyr)
library(dplyr)
library(data.table)

# read test table X_test.txt and y_test.txt
testx <- read.table("test/X_test.txt", header=FALSE, stringsAsFactors=FALSE)
testy <- read.table("test/y_test.txt", header=FALSE, stringsAsFactors=FALSE)

# read test table X_train.txt and y_train.txt
trainx <- read.table("train/X_train.txt", header=FALSE, stringsAsFactors=FALSE)
trainy <- read.table("train/y_train.txt", header=FALSE, stringsAsFactors=FALSE)

# read the features txt file
labels        <- read.table("features.txt")
names(testx)  <- t(labels)[2,]
names(trainx) <- t(labels)[2,]

# subset rows with mean & std
mean_std <- grep("mean\\(\\)|std\\(\\)",names(testx),value=TRUE)

testx <- subset(testx, select = names(testx) %in% mean_std)
trainx <- subset(trainx, select = names(trainx) %in% mean_std)

# combine two tables
test  <- cbind(testy,testx)
train <- cbind(trainy,trainx)
dt    <- rbind(test,train)

names(dt)<-gsub("\\(\\)","", names(dt))
names(dt)<-gsub("-",".", names(dt))

colnames(dt)[1] <- "activity"
dt$activity     <- factor(dt$activity)

dt$activity <- mapvalues(dt$activity,from = c("1","2","3","4","5","6"), to =c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
dt0      <- group_by(dt,activity)
dt_tidy  <- summarise_each(dt0,funs(mean))

write.table(dt_tidy, file="activity_tidy.txt",row.names=FALSE)
