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

NEI_SCC_balt  <- subset(NEI_SCC, fips=="24510" | fips=="06037")

##  Selct "motor vehicle" only measurements
NEI_SCC_balt  <- NEI_SCC_balt[grepl("Vehicles",NEI_SCC_balt$EI.Sector),]

NEI_SCC_balt  <- group_by(NEI_SCC_balt,year, fips)
NEI_SCC_balt  <- summarise(NEI_SCC_balt,Total_Emissions=sum(Emissions))

# order the date
NEI_SCC_balt  <- NEI_SCC_balt[order(as.Date(as.character(NEI_SCC_balt$year),format="%Y"))]

NEI_SCC_balt$fips <- gsub("24510","Baltimore",NEI_SCC_balt$fips)
NEI_SCC_balt$fips <-gsub("06037","Los Angeles County",NEI_SCC_balt$fips)

names(NEI_SCC_balt)[2] <- "City"

png("plot6.png", width=480, height=480)
g <- ggplot(NEI_SCC_balt, aes(x=year, y=Total_Emissions, colour=City, group=City)) + geom_line() + geom_point() + labs(x="Year",y="Total Emissions (Tons)")
print (g)

dev.off()

