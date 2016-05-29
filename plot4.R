library(dplyr)
library(lubridate)

setwd("~/Documents/Coursera/ExData_Plotting1") #set working directory and load data
subset <- read.csv("./data/hpc_subset.txt", colClasses = c(rep("character", 2), rep("numeric", 7)))
subset <- mutate(subset, DateTime = ymd_hms(paste(Date, Time), locale = "en_US.utf8")) #create a new column DateTime
subset <- mutate(subset, Date = ymd(Date), Time = hms(Time)) #change type of Date and Time column

#get range for y axis
min_y = min(subset$Sub_metering_1, subset$Sub_metering_2, subset$Sub_metering_3)
max_y = max(subset$Sub_metering_1, subset$Sub_metering_2, subset$Sub_metering_3)

png(filename = "plot4.png", width = 480, height = 480) #open png device

par(mfrow=c(2,2))

#first plot
with(subset, plot(DateTime, Global_active_power, xlab = "",
                  ylab = "Global Active Power", type ="l"))

#second plot
with(subset, plot(DateTime, Voltage, xlab="datetime", type ="l"))

#third plot
plot(subset$DateTime, subset$Sub_metering_1, main=NULL, xlab="",
     ylab="Energy sub metering", ylim=c(min_y, max_y), type="n")
with(subset, lines(DateTime, Sub_metering_1, col="black"))
with(subset, lines(DateTime, Sub_metering_2, col="red"))
with(subset, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), col = c("black", "red", "blue"), bty="n", pt.cex=1, cex = 0.35)
#cex is misbehaving :(

#fourth plot
with(subset, plot(DateTime, Global_reactive_power, xlab = "datetime", type ="l"))

dev.off()
