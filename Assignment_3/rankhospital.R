rankhospital <- function(state, outcome, num = "best") {
## Read outcome data
## Check that state and outcome are valid
## Return hospital name in that state with the given rank
## 30-day death rate

        hospital_name <- vector()

        if (!is.element(state, state.abb)) stop("invalid state")

        best_name <- c("heart attack","heart failure","pneumonia")
        if (!is.element(outcome, best_name)) stop("invalid outcome")

        outcome <- strsplit(outcome, " ")[[1]]
        outcome <- paste(toupper(substring(outcome, 1,1)), substring(outcome, 2), sep="", collapse=" ")
        outcome <- gsub(" ", ".", outcome)

        name <- paste("Hospital.30.Day.Death..Mortality..Rates.from.", outcome, sep ="")

        outcome_data <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available")
        good_outcome_data <- outcome_data[!is.na(outcome_data[[name]]),]
        good_outcome_data <- split(good_outcome_data, good_outcome_data$State)
        good_outcome_data <- good_outcome_data[[state]]
        good_outcome_data <- good_outcome_data[order(good_outcome_data[[name]],good_outcome_data$Hospital.Name),]
        #print (head(good_outcome_data[c("Hospital.Name","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","State")]))

        if (num=="best") {
                best_outcome_data <- good_outcome_data[1,]
                hospital_name <- append(hospital_name, as.character(best_outcome_data$Hospital.Name))
        } else if (num=="worst") {        
                worst_outcome_data <- good_outcome_data[nrow(good_outcome_data),]
                hospital_name <- append(hospital_name, as.character(worst_outcome_data$Hospital.Name))                       
        } else if (as.numeric(num) > nrow(good_outcome_data)) {
                hospital_name <- append(hospital_name, NA)
        } else {
               for (i in as.numeric(num)) {
                       hospital_name <- append(hospital_name, as.character(good_outcome_data[i,]$Hospital.Name))
               }
        }
        return (hospital_name)
}
