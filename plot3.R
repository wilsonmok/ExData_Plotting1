# Using the UC Irvine Machine Learning Repository - Electric power consumption
#  dataset to create an exploratory graph.  This graph shows the energy usage
#  for each sub metering for the time period. This plot is outputted to 
#  plot3.png file

library(dplyr)

datafile <- "data/household_power_consumption.txt"
plotfile <- "plot3.png"

# Read data from the household_power_consumption.txt.
# limit the dataset to only 2007 Feb 01 and 02.
data <- read.table(file=datafile, header=TRUE, sep=";", na.strings = "?")
data <- mutate(data, Date=as.Date(Date, format="%d/%m/%Y")) %>% 
    subset(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) %>%
    mutate(DateTime=as.POSIXct(paste(Date, Time)))

# Create the plot and output to png file.
png(plotfile, width=480, height=480, units="px")

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
       lty=1, lwd=2, col=c("black", "red", "blue"))

dev.off()