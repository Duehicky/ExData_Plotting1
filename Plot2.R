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

##plot2
png(file="plot2.png")
with(subsetData, plot(DateTime,Global_active_power, type="l", ylab ="Global Active Power (kilowatts)", xlab=""))
dev.off()