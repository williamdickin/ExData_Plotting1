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

#Plot 3
png(filename = "plot3.png")
plot(x = power_df$DateTime,
     y = power_df$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(x = power_df$DateTime,
      y = power_df$Sub_metering_2,
      col = "red")
lines(x = power_df$DateTime,
      y = power_df$Sub_metering_3,
      col = "blue")
legend("topright", legend = paste0("Sub_metering_", 1:3), col = c("black", "red", "blue"), lwd = 1)
dev.off()
