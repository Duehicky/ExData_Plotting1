##Overly verbose comments to explain code

##load libraries
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

##plot4
png(file="plot4.png")
par(mfrow=c(2,2))
with(subsetData, plot(DateTime,Global_active_power, type="l", ylab ="Global Active Power", xlab=""))

with(subsetData, plot(DateTime,Voltage, type="l", ylab ="Voltage", xlab="datetime"))

with(subsetData, plot(DateTime,Sub_metering_1, type="l", ylab ="Energy sub metering", xlab=""))
with(subsetData, lines(DateTime,Sub_metering_2, col="red"))
with(subsetData, lines(DateTime,Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, lty=1, col = c("black","red","blue"), bty="n")

with(subsetData, plot(DateTime,Global_reactive_power, type="l", ylab ="Global_reactive_power", xlab="datetime"))
dev.off()
