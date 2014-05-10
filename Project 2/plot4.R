SCC <- readRDS("Source_Classification_Code.rds")
coalSCC <- SCC[grepl("Combustion", SCC$SCC.Level.One, ignore.case=TRUE) | grepl("Coal", SCC$SCC.Level.Three, ignore.case=TRUE), ]
coalSCC <- coalSCC[, c("SCC")]
coalSCC <- levels(droplevels(coalSCC))

NEI <- readRDS("summarySCC_PM25.rds")
Data <- NEI[NEI$SCC %in% coalSCC, ]

totalEmissions <- aggregate(Data$Emissions, list(Year = Data$year, SCC = Data$SCC), sum)
totalEmissions <- aggregate(totalEmissions$x, list(Year = totalEmissions$Year), sum)

#creating the plot
png("plot4.png", width=480, height= 480)
plot(totalEmissions$Year, totalEmissions$x, type = "l", lwd=2, col= "lightblue", ylab= "Emissions", xlab= "Year", main= "Total Coal Combustion Emissions per year")
dev.off()