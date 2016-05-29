library(dplyr)
library(lubridate)

#set working directory and load data
setwd("~/Documents/Coursera/ExData_Plotting1")
epc_df <- read.csv("./data/household_power_consumption.txt", sep=";", na.strings = "?",
                   colClasses = c(rep("character", 2), rep("numeric", 7)))

epc_df <- mutate(epc_df, Date = dmy(Date), Time = hms(Time)) #change type of Date and Time column
span <- interval(ymd("2007-02-01"), ymd("2007-02-02")) #define an interval
subset <- filter(epc_df, Date %within% span) #extract proper rows

#export the subset for use in later r scirpts
write.csv(subset, "./data/hpc_subset.txt", row.names = F)

png(filename = "plot1.png", width = 480, height = 480) #open png device
hist(subset$Global_active_power, col="red", main = NULL, xlab = NULL) #plot histogram with no titles
title(main = "Global Active Power", xlab = "Global Active Power (kilowatts)") #add titles
dev.off() #close png device
