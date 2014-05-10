# Reading data into R:
Data <- read.table("./household_power_consumption.txt", sep=";", header=TRUE, quote= "", strip.white=TRUE, stringsAsFactors = FALSE, na.strings= "?")

# Subsetting the full data to obtain the data related to two days: 
sub<- subset(Data, (Data$Date == "1/2/2007" | Data$Date== "2/2/2007")) 

# creating plot1
png("plot1.png", width=480, height= 480)
hist(sub$Global_active_power, col= "red", xlab= "Global Active Power (kilowatts)", ylab= "Frequency", main= "Global Active Power")
dev.off()