library(ggplot2)
library(dplyr)

if (!file.exists("summarySCC_PM25.rds")) {
        stop("Data file is not available, download it first!")
}


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
NEI <- transform(NEI, factor(type))

NEI_balt  <- subset(NEI, fips=="24510")

NEI_balt  <- group_by(NEI_balt,year, type)
NEI_balt  <- summarise(NEI_balt,Total_Emissions=sum(Emissions))

png("plot3.png", width=480, height=480)
#print(qplot(year, Total_Emissions, data=NEI_balt, color=type, xlab="Year", ylab="Total Emissions (Tons)"))

# gplot<-ggplot(plotdata3,aes(year,sum))
# gplot+geom_point()+facet_grid(.~type)+labs(title="PM2.5 Emission in Baltimore city",
# y="total PM2.5 emission each year")
# qplot(year, total, data=NEI_summary, facets=type~., geom=c("line"),
#       main="Baltimore City's Total Emission per Type",
#       xlab="Year", ylab="Total PM2.5 Emission (tons)")
g <- ggplot(NEI_balt, aes(x=year, y=Total_Emissions, colour=type, group=type)) + geom_line() + geom_point() + labs(x="Year",y="Total Emissions (Tons)")
print (g)

dev.off()

