# Using the UC Irvine Machine Learning Repository - Electric power consumption
#  dataset to create 4 exploratory graphs.
#    - Top left: Global Active Power by datetime
#    - Top right: Voltage by datetime
#    - Bottom left: Energy sub metering by datetime
#    - Bottom right: Global reactive power by datetime
#  This plot is outputted to plot4.png file

library(dplyr)

datafile <- "data/household_power_consumption.txt"
plotfile <- "plot4.png"

# Read data from the household_power_consumption.txt.
# limit the dataset to only 2007 Feb 01 and 02.
data <- read.table(file=datafile, header=TRUE, sep=";", na.strings = "?")
data <- mutate(data, Date=as.Date(Date, format="%d/%m/%Y")) %>% 
    subset(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) %>%
    mutate(DateTime=as.POSIXct(paste(Date, Time)))

# Create 4 plots and output to png file.
#  - Top left: Global Active Power by datetime
#  - Top right: Voltage by datetime
#  - Bottom left: Energy sub metering by datetime
#  - Bottom right: Global reactive power by datetime

png(plotfile, width=480, height=480, units="px")

# divide the plot area into 4
par(mfrow = c(2, 2)) 

# Top left
with(data, plot(Global_active_power ~ DateTime, type="l",
                xlab="",
                ylab="Global Active Power"))

# Top Right
with(data, plot(Voltage ~ DateTime, type="l",
                xlab="datetime",
                ylab="Voltage"))

# Bottom Left
with(data, plot(Sub_metering_1 ~ DateTime, type="l",
                col="black",
                xlab="",
                ylab="Energy sub metering"))
with(data, lines(Sub_metering_2 ~ DateTime, type="l", 
                 col="red"))
with(data, lines(Sub_metering_3 ~ DateTime, type="l", 
                 col="blue"))

legend("topright", c("Sub_metering_1", "Sub_metering_2", 
                     "Sub_metering_3"),
       lty=1, lwd=2, col=c("black", "red", "blue"),
       bty="n")

# Bottom Right
with(data, plot(Global_reactive_power ~ DateTime, type="l",
                xlab="datetime",
                ylab="Global_reactive_power"))

dev.off()