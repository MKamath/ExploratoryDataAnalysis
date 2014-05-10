NEI <- readRDS("summarySCC_PM25.rds")
Data <- NEI[NEI$fips == "24510", ]

totalEmissions <- aggregate(Data$Emissions, list(Year = Data$year, Type = Data$type, SCC = Data$SCC), sum)
totalEmissions <- aggregate(totalEmissions$x, list(Type = totalEmissions$Type, Year = totalEmissions$Year), sum)

#creating the plot
png("plot3.png", width=480, height= 480)
qplot(Year, x, data = totalEmissions, geom=c("point","line"), color=Type, ylab= "Emissions", xlab= "Year", main= "Total Emissions per year for Baltimore City")
dev.off()