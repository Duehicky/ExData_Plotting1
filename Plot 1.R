library(data.table) ##need for fread
library(lubridate) ##date conversions
library(dplyr) ##not needed, but allows to mutate all columns at once

##read in data using fread since read.table even with colClasses and rows specified was slow
data <- fread("household_power_consumption.txt", na.string="?")
subsetData <- subset(data, Date =="1/2/2007"|Date == "2/2/2007")

##Due to the ? as na most of the columns were read as characters, I'm now converting them (colClasses doesn't work with the ?)
subsetData <- mutate(subsetData, 
                    Date = as.Date(dmy(Date)), 
                    Global_active_power = as.numeric(Global_active_power),
                    Global_reactive_power=as.numeric(Global_reactive_power),
                    Voltage=as.numeric(Voltage),
                    Global_intensity=as.numeric(Global_intensity),
                    Sub_metering_1=as.numeric(Sub_metering_1),
                    Sub_metering_2=as.numeric(Sub_metering_2),
                    Sub_metering_3=as.numeric(Sub_metering_3),
                    DateTime=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

##subsetData$Date <- as.Date(dmy(subsetData$Date))
##subsetData$Global_active_power <- as.numeric(subsetData$Global_active_power)
##subsetData$Global_reactive_power <- as.numeric(subsetData$Global_reactive_power)
##subsetData$Voltage <- as.numeric(subsetData$Voltage)
##subsetData$Global_intensity <- as.numeric(subsetData$Global_intensity)
##subsetData$Sub_metering_1 <- as.numeric(subsetData$Sub_metering_1)
##subsetData$Sub_metering_2 <- as.numeric(subsetData$Sub_metering_2)
##subsetData$Sub_metering_3 <- as.numeric(subsetData$Sub_metering_3)
##add a column combining the data ande time
##subsetData$DateTime <- with(subsetData, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

hist(subsetData$Global_active_power, xlab ="Global Active Power (kilowatts)", main = "Global Active Power", col = "red") 
dev.copy(png, file="plot1.png")
dev.off()

with(subsetData, plot(DateTime,Global_active_power, type="l", ylab ="Global Active Power (kilowatts)", xlab=""))
dev.copy(png, file="plot2.png")
dev.off()

with(subsetData, plot(DateTime,Sub_metering_1, type="l", ylab ="Energy Sub Metering", xlab=""))
with(subsetData, lines(DateTime,Sub_metering_2, col="red"))
with(subsetData, lines(DateTime,Sub_metering_3, col="blue"))
dev.copy(png, file="plot3.png")
dev.off()

par(mfrow=c(2,2))
with(subsetData, plot(DateTime,Global_active_power, type="l", ylab ="Global Active Power (kilowatts)", xlab=""))

with(subsetData, plot(DateTime,Voltage, type="l", ylab ="Voltage", xlab="datetime"))

with(subsetData, plot(DateTime,Sub_metering_1, type="l", ylab ="Energy Sub Metering", xlab=""))
with(subsetData, lines(DateTime,Sub_metering_2, col="red"))
with(subsetData, lines(DateTime,Sub_metering_3, col="blue"))
with(subsetData, plot(DateTime,Global_reactive_power, type="l", ylab ="Global_reactive_power", xlab="datetime"))
dev.copy(png, file="plot4.png")
dev.off()