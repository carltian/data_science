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
png(file="plot3.png",width=480,height=480)
df <- read.csv.sql("household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007')",header=TRUE,sep=";")
df$datetime <- paste(df$Date, df$Time)
df$datetime <- strptime(df$datetime, format = "%d/%m/%Y %H:%M:%S")
df$weekdays <- as.factor(weekdays(df$datetime))
with(df, plot(datetime, Sub_metering_1, main="", type = "n", xlab="", ylab="Energy sub metering"))
with(subset(df,select=Sub_metering_1), points(df$datetime, df$Sub_metering_1, type="l"))
with(subset(df,select=Sub_metering_2), points(df$datetime, df$Sub_metering_2, type="l", col="red"))
with(subset(df,select=Sub_metering_3), points(df$datetime, df$Sub_metering_3, type="l", col="blue"))
legend("topright", col=c("black","blue","red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=2)
dev.off()
