# Reading SCC Data, and subsetting it to get only motor vehicle emissions related rows
SCC <- readRDS("Source_Classification_Code.rds")
mvSCC <- SCC[grepl("Vehicle", SCC$EI.Sector, ignore.case=TRUE) | grepl("Motor", SCC$EI.Sector, ignore.case=TRUE), ]
mvSCC <- mvSCC[, c("SCC")]
mvSCC <- levels(droplevels(mvSCC))

# Reading NEI Data, and subsetting it to get only Baltimore City rows
NEI <- readRDS("summarySCC_PM25.rds")
Data <- NEI[NEI$fips == "24510", ]
Data <- Data[Data$SCC %in% mvSCC, ]

# Processing the data to find out the total emissions per year 
totalEmissions <- aggregate(Data$Emissions, list(Year = Data$year, SCC = Data$SCC), sum)
totalEmissions <- aggregate(totalEmissions$x, list(Year = totalEmissions$Year), sum)

#creating the plot
png("plot5.png", width=480, height= 480)
plot(totalEmissions$Year, totalEmissions$x, type = "l", lwd=2, col= "lightblue", ylab= "Emissions", xlab= "Year", main= "Total Motor Vehicle Emissions per year for Baltimore City")
dev.off()