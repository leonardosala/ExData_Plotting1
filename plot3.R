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

# Create the histogram
plot(graph_data$Timestamp, graph_data$Sub_metering_1, col = "black", type = "l", ylab = "Energy sub metering", xlab = "")
lines(graph_data$Timestamp, graph_data$Sub_metering_2, col = "red")
lines(graph_data$Timestamp, graph_data$Sub_metering_3, col = "blue")
legend("topright", pch = 45, col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Saving the image
dev.copy(png,'plot3.png')
dev.off()