library(dplyr)

if (!file.exists("summarySCC_PM25.rds")) {
        stop("Data file is not available, download it first!")
}
png(file="plot2.png",width=480,height=480)


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

NEI_balt  <- subset(NEI, fips=="24510")

NEI_balt  <- group_by(NEI_balt,year)
NEI_balt  <- summarise(NEI_balt,Total_Emissions=sum(Emissions))
par(mar=c(5.1,4.2,4.1,2.1))

with(NEI_balt, {
        plot(Total_Emissions~year, xlab="Year", ylab="Total Emissions (Tons)", type="n")
        points(year, Total_Emissions, pch = 16, col = "red")
        lines(year, Total_Emissions,  col = "blue")
})

dev.off()

