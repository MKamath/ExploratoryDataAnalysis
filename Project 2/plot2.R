# Reading NEI Data, and subsetting it to get only Baltimore City rows
NEI <- readRDS("summarySCC_PM25.rds")
Data <- NEI[NEI$fips == "24510", ]

# Processing the data to find out the total emissions per year
totalEmissions <- aggregate(Data$Emissions, list(Year = Data$year, SCC = Data$SCC), sum)
totalEmissions <- aggregate(totalEmissions$x, list(Year = totalEmissions$Year), sum)

#creating the plot
png("plot2.png", width=480, height= 480)
plot(totalEmissions$Year, totalEmissions$x, type = "l", lwd=2, col= "lightblue", ylab= "Emissions", xlab= "Year", main= "Total Emissions per year for Baltimore city")
dev.off()