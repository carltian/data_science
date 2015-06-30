library(ggplot2)
library(dplyr)
library(data.table)

if (!file.exists("summarySCC_PM25.rds") | !file.exists("Source_Classification_Code.rds")) {
        stop("Data file is not available, download it first!")
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Convert the dataframe to data table so the downstream analysis will be faster
NEI <- data.table(NEI)
SCC <- data.table(SCC)

## Merge two data tables by "SCC"
NEI_SCC <- merge(NEI, SCC, "SCC")

NEI_SCC_balt  <- subset(NEI_SCC, fips=="24510")

##  Selct "motor vehicle" only measurements
NEI_SCC_balt  <- NEI_SCC_balt[grepl("Vehicles",NEI_SCC_balt$EI.Sector),]

# NEI_SCC_balt <- group_by(filter(NEI_SCC, fips=="24510", grepl("Motor", Short.Name)), year)

NEI_SCC_balt  <- group_by(NEI_SCC_balt,year)
NEI_SCC_balt  <- summarise(NEI_SCC_balt,Total_Emissions=sum(Emissions))

# order the date
NEI_SCC_balt  <- NEI_SCC_balt[order(as.Date(as.character(NEI_SCC_balt$year),format="%Y"))]

# or using tapply
# NEI_SCC_balt  <- tapply(NEI_SCC_balt$Emissions, NEI_SCC_balt$year, sum)

png("plot5.png", width=480, height=480)
with(NEI_SCC_balt, {
        plot(Total_Emissions~year, xlab="Year", ylab="Total Emissions (Tons)", type="n")
        points(year, Total_Emissions, pch = 16, col = "red")
        lines(year, Total_Emissions,  col = "blue")
})

dev.off()

