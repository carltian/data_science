rankall <- function(outcome, num = "best") {
## Read outcome data
## Check that state and outcome are valid
## For each state, find the hospital of the given rank
## Return a data frame with the hospital names and the
## (abbreviated) state name

        hospital_name <- vector()
        state_name <- vector()

        best_name <- c("heart attack","heart failure","pneumonia")
        if (!is.element(outcome, best_name)) stop("invalid outcome")

        outcome <- strsplit(outcome, " ")[[1]]
        outcome <- paste(toupper(substring(outcome, 1,1)), substring(outcome, 2), sep="", collapse=" ")
        outcome <- gsub(" ", ".", outcome)

        name <- paste("Hospital.30.Day.Death..Mortality..Rates.from.", outcome, sep ="")

        outcome_data <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available")
        good_outcome_data <- outcome_data[!is.na(outcome_data[[name]]),]
        good_outcome_data <- split(good_outcome_data, good_outcome_data$State)
                
        for (state in state.abb) {
                s <- good_outcome_data[[state]]            
                s <- s[order(s[[name]],s$Hospital.Name),]
                #print (head(s[c("Hospital.Name","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","State")])) 
                if (num=="best") {
                        best_outcome_data <- s[1,]
                        hospital_name <- append(hospital_name, as.character(best_outcome_data$Hospital.Name))
                        state_name <- append(state_name, state)
                } else if (num=="worst") {        
                        worst_outcome_data <- s[nrow(s),]
                        hospital_name <- append(hospital_name, as.character(worst_outcome_data$Hospital.Name))                       
                        state_name <- append(state_name, state)
                } else if (as.numeric(num) > nrow(s)) {
                        hospital_name <- append(hospital_name, NA)
                        state_name <- append(state_name, state)
                } else {
                       for (i in as.numeric(num)) {
                               hospital_name <- append(hospital_name, as.character(s[i,]$Hospital.Name))
                               state_name <- append(state_name, state)
                       }
                }
        }
        ranking <- data.frame(hospital_name,state_name)
        names(ranking)[names(ranking)=="hospital_name"] <- "hospital"
        names(ranking)[names(ranking)=="state_name"] <- "state"
        ranking <- ranking[order(ranking$state),]
        rownames(ranking) <- ranking$state
        return (ranking)
}