# Reading data into R:
Data <- read.table("./household_power_consumption.txt", sep=";", header=TRUE, quote= "", strip.white=TRUE, stringsAsFactors = FALSE, na.strings= "?")

# Subsetting the full data to obtain the data related to two days: 
sub <- subset(Data, (Data$Date == "1/2/2007" | Data$Date== "2/2/2007")) 
sub$Date <- as.Date(sub$Date, format = "%d/%m/%Y")
sub$DateTime <- as.POSIXct(paste(sub$Date, sub$Time))

# Creating the plot2:
png("plot2.png", width=480, height= 480)
plot(sub$DateTime, sub$Global_active_power, type= "l", lwd=1, ylab= "Global Active Power (kilowatts)", xlab="")
dev.off()