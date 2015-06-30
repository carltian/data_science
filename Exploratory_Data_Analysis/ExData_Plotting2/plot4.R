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

# NEI_SCC <- join(NEI, SCC, by ="SCC", type = "left", match = "all")
# rm(SCC_Name)

##  Selct "coal combustion-related source" only measurements
NEI_SCC0 <- NEI_SCC[grepl("Coal",NEI_SCC$Short.Name),]
NEI_SCC1 <- NEI_SCC0[grepl("Comb",NEI_SCC0$Short.Name),]

NEI_SCC1  <- group_by(NEI_SCC1,year)
NEI_SCC1  <- summarise(NEI_SCC1,Total_Emissions=sum(Emissions))

png("plot4.png", width=480, height=480)
with(NEI_SCC1, {
        plot(Total_Emissions~year, xlab="Year", ylab="Total Emissions (Tons)", type="n")
        points(year, Total_Emissions, pch = 16, col = "red")
        lines(year, Total_Emissions,  col = "blue")
})

dev.off()

