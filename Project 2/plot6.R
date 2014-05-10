# Reading NEI Data, and subsetting it to get only Baltimore City rows
SCC <- readRDS("Source_Classification_Code.rds")
mvSCC <- SCC[grepl("Vehicle", SCC$EI.Sector, ignore.case=TRUE) | grepl("Motor", SCC$EI.Sector, ignore.case=TRUE), ]
mvSCC <- mvSCC[, c("SCC")]
mvSCC <- levels(droplevels(mvSCC))

# Reading NEI Data, and subsetting it to get only Baltimore City & Los Angeles County rows
NEI <- readRDS("summarySCC_PM25.rds")
Data <- NEI[NEI$fips == "24510" | NEI$fips == "06037", ]
Data <- Data[Data$SCC %in% mvSCC, ]

# Processing the data to find out the total emissions per year per Fips
totalEmissions <- aggregate(Data$Emissions, list(Fips = Data$fips, Year = Data$year, SCC = Data$SCC), sum)
totalEmissions <- aggregate(totalEmissions$x, list(Fips = totalEmissions$Fips, Year = totalEmissions$Year), sum)
for (i in 1:nrow(totalEmissions)) {
        tmp <- totalEmissions[i, ]
        if (tmp$Fips=="24510") {
                totalEmissions[i, c("Fips")] <- "Baltimore City"
        }
        else {
                totalEmissions[i, c("Fips")] <- "Los Angeles County"
        }
}

#creating the plot
png("plot6.png", width=480, height= 480)
qplot(Year, x, data = totalEmissions, geom=c("point","line"), color=Fips, ylab= "Emissions", xlab= "Year", main= "Total Motor Vechile Emissions per year")
dev.off()