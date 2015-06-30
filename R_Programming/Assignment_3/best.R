# state: 2-character abbreviated name of the state
# outcome: an outcome name

best <- function(state,outcome) {
        # Read outcome data
	# Check that state and outcome are valid
	# Return hospital name in that state with lowest 30-day death rate

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

	min_outcome_data <- good_outcome_data[which(good_outcome_data[[name]] == min(good_outcome_data[[name]])),]
	hospital_name <- append(hospital_name, as.character(min_outcome_data$Hospital.Name))
	hospital_name <- sort(hospital_name)
	hospital_name
}