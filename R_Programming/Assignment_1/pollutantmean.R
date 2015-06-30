pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
	
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".        

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used

        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!

        for (ids in id) {
                 filename <- paste(formatC(ids,width=3,flag="0"),"csv",sep=".")
                 filename <- paste(directory,filename,sep="/")
                 
                 if (!exists("dataset")){
                         dataset <- read.csv(filename)
	         }
		 else {
                         temp_dataset <-read.csv(filename)
                         dataset<-rbind(dataset, temp_dataset)
                         rm(temp_dataset)
                 }
        }
        mean_pollutant = mean(dataset[[pollutant]],na.rm=TRUE)
        return (mean_pollutant)
}
