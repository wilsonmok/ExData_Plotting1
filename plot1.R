# Using the UC Irvine Machine Learning Repository - Electric power consumption
#  dataset to create an exploratory graph.  This graph shows the relationship
#  between Global Active Power and Frequency.  This plot is outputted to 
#  plot1.png file

library(dplyr)

datafile <- "data/household_power_consumption.txt"
plotfile <- "plot1.png"

# Read data from the household_power_consumption.txt.
# limit the dataset to only 2007 Feb 01 and 02.
data <- read.table(file=datafile, header=TRUE, sep=";", na.strings = "?")
data <- mutate(data,Date=as.Date(Date, format="%d/%m/%Y")) %>% 
    subset(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create the plot and output to png file.
png(plotfile, width=480, height=480, units="px")

with(data, hist(Global_active_power, 
                col="red",
                main="Global Active Power",
                xlab="Global Active Power (kilowatts)",
                ylab="Frequency"))

dev.off()