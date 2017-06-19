##Read in txt file, noting presence of header, and separating by semicolon; assign to object powerdata
powerdata <- read.table("household_power_consumption.txt", header=TRUE, sep = ";")

##Change format of date column to POSIXlt
powerdata$Date <- strptime(powerdata$Date, "%d/%m/%Y")
##Change format of date column to POSIXct
powerdata$Date <- as.POSIXct(powerdata$Date)

##Filter rows to only 2007-02-01 and 2007-02-02
powerdata.f <- filter(powerdata, Date=="2007-02-01" | Date=="2007-02-02")

##set Sub_metering variables to numeric
powerdata.f$Sub_metering_1 <- as.numeric(paste(powerdata.f$Sub_metering_1))
powerdata.f$Sub_metering_2 <- as.numeric(paste(powerdata.f$Sub_metering_2))
powerdata.f$Sub_metering_3 <- as.numeric(paste(powerdata.f$Sub_metering_3))

##Concatenate Date and Time variables into new variable "DateTime"
powerdata.f$DateTime <- paste(powerdata.f$Date,powerdata.f$Time)

##Convert DateTime variable into POSIXct
powerdata.f$DateTime <- as.POSIXct(powerdata.f$DateTime)

##Open png graphics device, provide name of file and dimensions
png(file="plot3.png", height=480, width=480)

##Plot DateTime against Sub metering, make line graph, with y axis title specified, x axis title blank
with(powerdata.f, plot(DateTime, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))

##Create new line graph series for Sub_metering_2 and Sub_metering_3
with(powerdata.f, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(powerdata.f, lines(DateTime, Sub_metering_3, type="l", col="blue"))

##Create legend in top right corner
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##Close graphics device
dev.off()
