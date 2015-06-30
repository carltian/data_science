if (!file.exists("pml-training.csv")) {
    url="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
    download.file(url, destfile="./pml-training.csv", method="curl")
    dateDownloaded <- date()
}
if (!file.exists("pml-testing.csv")) {
    url="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
    download.file(url, destfile="./pml-testing.csv", method="curl")
    dateDownloaded <- date()
}

# read in the data sets, both training and testing
training <- read.csv("pml-training.csv", na.strings=c("NA","","#DIV/0!"), sep=",")
testing  <- read.csv("pml-testing.csv",  na.strings=c("NA","","#DIV/0!"), sep=",")
# subset the data and keeps rows from 8 to the end
training <- training[,c(8:160)]
testing  <- testing[,c(8:160)]
# only keep the rows with less than 50% of missing values
col_to_keep = c()
for (i in 1:dim(training)[2]) {
  if ((sum(is.na(training[,i]))/nrow(training))<0.5) {
    col_to_keep <- append(col_to_keep, i)
  }
}
training <- training[,col_to_keep]
testing  <- testing[,col_to_keep]

library(caret)
require(imputation)
set.seed(2015)
# 10-fold CV, and repeated 3 times
fitControl <- trainControl(method="repeatedcv", number = 10, repeats = 3)
# fit a boosted tree model 
glmFit <- train(factor(classe) ~ ., data=training, method="glm", preProcess="knnImpute", trControl=fitControl, verbose = TRUE)

