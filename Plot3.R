# Download file from the website, unzip the file and read it into R 

if(!file.exists("./data")){dir.create("./data")}
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235//household_power_consumption.zip"
download.file(url, destfile = "./data/house_power_consumption.zip")
unzip(zipfile = "./data/house_power_consumption.zip", exdir = "./data")
e_usage <- read.table("./data/household_power_consumption.txt", sep =";", header = TRUE, na.strings = "?")

Sys.setlocale("LC_TIME", "English")

#load package dplyr as we will use mutate()
library(dplyr)

#select dates - 1/2/2007 & 1/2/2007
selected_usage <- subset(e_usage, e_usage$Date == "1/2/2007" | e_usage$Date == "2/2/2007")
selected_usage$Global_active_power <- as.numeric(selected_usage$Global_active_power)
selected_usage <- mutate(selected_usage, Date_Time = paste(Date,Time))
selected_usage$Date_Time <- as.POSIXct(selected_usage$Date_Time, format = "%d/%m/%Y %H:%M:%S")

#start and format the plot device
png("plot3.png", width=480, height=480)

plot(selected_usage$Date_Time, selected_usage$Sub_metering_1, xlab = "", ylab ="Energy sub metering", type = "l")
lines(selected_usage$Date_Time, selected_usage$Sub_metering_2, col = "red")
lines(selected_usage$Date_Time, selected_usage$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty =1)


dev.off()