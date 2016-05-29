library(dplyr)
library(lubridate)

setwd("~/Documents/Coursera/ExData_Plotting1") #set working directory and load data
subset <- read.csv("./data/hpc_subset.txt", colClasses = c(rep("character", 2), rep("numeric", 7)))
subset <- mutate(subset, DateTime = ymd_hms(paste(Date, Time), locale = "en_US.utf8")) #create a new column DateTime
subset <- mutate(subset, Date = ymd(Date), Time = hms(Time)) #change type of Date and Time column

png(filename = "plot2.png", width = 480, height = 480) #open png device
with(subset, plot(DateTime, Global_active_power, xlab = "",
                  ylab = "Global Active Power (kilowatts)", type ="l"))
dev.off() #close png device
