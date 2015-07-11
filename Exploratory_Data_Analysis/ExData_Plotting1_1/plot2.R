rm(list=ls())
library(dplyr)
library(lubridate)

if (!file.exists("household_power_consumption.txt")) {
        if (!file.exists("household_power_consumption.zip")) {
                url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(url, destfile="./household_power_consumption.zip", method="curl")
                dateDownloaded <- date()
                unzip("household_power_consumption.zip")
         } else {
                unzip("household_power_consumption.zip")
         }
}

# read the data as dt object
dt <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = FALSE)
# another way to read the data in with subsetting is using the sqldf
# read.csv.sql("household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007')",header=TRUE,sep=";")

# subset the data  from the dates 2007-02-01 and 2007-02-02
dt <- dt[dt$Date == "1/2/2007" | dt$Date == "2/2/2007",]

# add a new variable weekday tells which weekday
dt <- dt %>% mutate(datetime = ymd_hms(dmy(Date)+hms(Time)), Global_active_power = as.numeric(Global_active_power))

png(file="plot2.png",width = 480, height = 480)
with(dt, plot(datetime, Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l", xlab=""))
dev.off()
