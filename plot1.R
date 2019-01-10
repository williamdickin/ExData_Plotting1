#Load packages
library(tidyverse)

#Set working directory
###

#Download and unzip file
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "power.zip")
unzip("power.zip")

#Get size of file
cat(file.info("power/household_power_consumption.txt")$size/1000000, "mb")

#Read in data
power_df <- read.table("power/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", stringsAsFactors = FALSE)

#Create datetime column and filter to dates
power_df <-
    power_df %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %T")) %>%
    select(DateTime, Global_active_power:Sub_metering_3)

#Plot 1
png(filename = "plot1.png")
hist(power_df$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()
