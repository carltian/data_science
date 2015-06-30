library(sqldf)
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
png(file="plot2.png",width=480,height=480)
df <- read.csv.sql("household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007')",header=TRUE,sep=";")
df$datetime <- paste(df$Date, df$Time)
df$datetime <- strptime(df$datetime, format = "%d/%m/%Y %H:%M:%S")
df$weekdays <- as.factor(weekdays(df$datetime))
with(df, plot(datetime, Global_active_power, ylab="Global Active Power (kilowatts)",type="l",xlab=""))
dev.off()
