# Leonardo Sala
# This script is the assignement for the Data Cleaning course, part if the Data Specialization

# Setting working Directory
setwd("C:/Users/Leonardo Sala/Desktop/COURSERA/Data_Science_Specialization/4_Exploratory_Data_Analysis/ASSIGNEMENT_WEEK1/GIT_HOME")
getwd()

# Reading Data
powerdf <- read.csv("../exdata_data_household_power_consumption/household_power_consumption.txt", header = FALSE, sep = ";")

# Renaming Headers
colnames(powerdf) <- as.character(unlist(powerdf[1,]))

# Remove Row 1
powerdf <- powerdf[-c(1), ]

# Converting Dates and Times
Paste <- paste(powerdf$Date, powerdf$Time)
Timestamp <- strptime(Paste, format = "%d/%m/%Y %H:%M:%S") 
powerdf$Timestamp <- Timestamp

# Subsetting relevant data
graph_data <- subset(powerdf, Timestamp > strptime("2007/02/01", format ="%Y/%m/%d") & Timestamp < strptime("2007/02/03", format ="%Y/%m/%d"))

# Matrix 2x2 of plots
par(mfrow = c(2, 2))

# Create chart 1
plot(graph_data$Timestamp,as.numeric(graph_data$Global_active_power)/(4000/7), ylab = "Global Active Power (kilowatts)", xlab = "", type ="l")

# Create chart 2
plot(graph_data$Timestamp,as.numeric(graph_data$Voltage)/(2200/247), ylab = "Voltage", xlab = "datetime", type ="l")

# Create chart 3
plot(graph_data$Timestamp, graph_data$Sub_metering_1, col = "black", type = "l", ylab = "Energy sub metering", xlab = "")
lines(graph_data$Timestamp, as.numeric(graph_data$Sub_metering_2)/(15/2), col = "red")
lines(graph_data$Timestamp, graph_data$Sub_metering_3, col = "blue")
legend("topright", pch = 45, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Create chart 4
plot(graph_data$Timestamp,as.numeric(graph_data$Global_reactive_power)/(250/0.5), ylab = "Global_reactive_power", xlab = "datetime", type ="l")

# Saving the image
dev.copy(png,'plot4.png')
dev.off()