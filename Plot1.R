
# Download file from the website, unzip the file and read it into R 
if(!file.exists("./data")){dir.create("./data")}
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235//household_power_consumption.zip"
download.file(url, destfile = "./data/house_power_consumption.zip")
unzip(zipfile = "./data/house_power_consumption.zip", exdir = "./data")
e_usage <- read.table("./data/household_power_consumption.txt", sep =";", header = TRUE, na.strings = "?")

#select dates - 1/2/2007 & 1/2/2007
selected_usage <- subset(e_usage, e_usage$Date == "1/2/2007" | e_usage$Date == "2/2/2007")
selected_usage$Global_active_power <- as.numeric(selected_usage$Global_active_power)

#start and format the plot device
png("plot1.png", width=480, height=480)

#plot 1 
hist(selected_usage$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")


dev.off()

