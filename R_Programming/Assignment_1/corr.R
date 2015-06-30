corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!

        #files <- list.files(directory)	
	complete_data <- complete(directory)
	correlation <- vector()
	for (i in 1:nrow(complete_data)) {
     	        id <- complete_data[i,1]
                filename <- paste(formatC(id,width=3,flag="0"),"csv",sep=".")
                filename <- paste(directory,filename,sep="/")
         	dataset <- read.csv(filename)
		good <- complete.cases(dataset)
		good_dataset <- dataset[good,]	
	        if (complete_data[i,2]>threshold) {
                        correlation <- c(correlation, cor(good_dataset$sulfate, good_dataset$nitrate))
		}
	}
        return (correlation)
}