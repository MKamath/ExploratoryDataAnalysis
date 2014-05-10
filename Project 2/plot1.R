# Reading NEI Data
NEI <- readRDS("summarySCC_PM25.rds")

# Processing the data to find out the total emissions per year
totalEmissions <- aggregate(NEI$Emissions, list(Year = NEI$year, SCC = NEI$SCC), sum)
totalEmissions <- aggregate(totalEmissions$x, list(Year = totalEmissions$Year), sum)

#creating the plot
png("plot1.png", width=480, height= 480)
plot(totalEmissions$Year, totalEmissions$x, type = "l", lwd=2, col= "lightblue", ylab= "Emissions", xlab= "Year", main= "Total Emissions per year")
dev.off()
