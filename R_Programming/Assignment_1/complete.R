complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases

        for (ids in id) {
                 filename <- paste(formatC(ids,width=3,flag="0"),"csv",sep=".")
                 filename <- paste(directory,filename,sep="/")
                 
		 dataset <- read.csv(filename)
		 good_dataset <- dataset[complete.cases(dataset),]

 		 if (!exists("id_num")){
		         id_num <- ids
                 }
                 else {
			 id_num <- c(id_num,ids)
                 }
 		 if (!exists("nobs_list")){
   		         nobs_list <- nrow(good_dataset)
                 }
                 else {	
			 nobs_list <- c(nobs_list, nrow(good_dataset))
		 }		 
	}

	nobs <- nobs_list[[1]]
	if (length(nobs_list)>1) {
	        for (i in 2:length(nobs_list)) {
		        nobs <- append(nobs, nobs_list[[i]])
		 }
	}

        df = data.frame(id_num, nobs, stringsAsFactors=FALSE)
        df
}
