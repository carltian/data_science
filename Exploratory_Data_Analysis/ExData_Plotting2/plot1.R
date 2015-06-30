library(dplyr)

if (!file.exists("summarySCC_PM25.rds")) {
        stop("Data file is not available, download it first!")
}
png(file="plot1.png",width=480,height=480)


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

#NEI  <- transform(NEI, year=factor(year))
#NEI0 <- ddply(NEI, .(year), summarize, sum=sum(Emissions))

NEI      <- group_by(NEI,year)
NEI0     <- summarise(NEI,Total_Emissions=sum(Emissions)/1000000)
par(mar=c(5.1,4.2,4.1,2.1))
with(NEI0, {
        plot(Total_Emissions~year, xlab="Year", ylab="Total Emissions (Million Tons)", type="n")
        points(year, Total_Emissions, pch = 16, col = "red")
        lines(year, Total_Emissions,  col = "blue")
})

#plot(levels(nei$year), tapply(nei$Emissions, nei$year, sum),
#     col="red", type="l", lwd=2, xlab="Year", ylab="Sum of Emissions", main="Sum of PM2.5 Emission per year")

dev.off()
