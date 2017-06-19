##Read in txt file, noting presence of header, and separating by semicolon; assign to object powerdata
powerdata <- read.table("household_power_consumption.txt", header=TRUE, sep = ";")

##Change format of date column to POSIXlt
powerdata$Date <- strptime(powerdata$Date, "%d/%m/%Y")
##Change format of date column to POSIXct
powerdata$Date <- as.POSIXct(powerdata$Date)

##Filter rows to only 2007-02-01 and 2007-02-02
powerdata.f <- filter(powerdata, Date=="2007-02-01" | Date=="2007-02-02")

##set variables to numeric
powerdata.f$Sub_metering_1 <- as.numeric(paste(powerdata.f$Sub_metering_1))
powerdata.f$Sub_metering_2 <- as.numeric(paste(powerdata.f$Sub_metering_2))
powerdata.f$Sub_metering_3 <- as.numeric(paste(powerdata.f$Sub_metering_3))
powerdata.f$Global_active_power <- as.numeric(paste(powerdata.f$Global_active_power))
powerdata.f$Global_reactive_power <- as.numeric(paste(powerdata.f$Global_reactive_power))
powerdata.f$Voltage <- as.numeric(paste(powerdata.f$Voltage))

##Concatenate Date and Time variables into new variable "DateTime"
powerdata.f$DateTime <- paste(powerdata.f$Date,powerdata.f$Time)

##Convert DateTime variable into POSIXct
powerdata.f$DateTime <- as.POSIXct(powerdata.f$DateTime)

##Open png graphics device, provide name of file and dimensions
png(file="plot4.png", height=480, width=480)

##Create plot with 2 rows and 2 columns of subplots
par(mfrow=c(2,2))

##Create top left plot
with(powerdata.f, plot(DateTime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power"))

##Create top right plot
with(powerdata.f, plot(DateTime, Voltage, type="l", xlab = "datetime"))

##Create bottom left plot
with(powerdata.f, plot(DateTime, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
with(powerdata.f, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(powerdata.f, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=c(1,1,1), bty="n", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##Create bottom right plot
with(powerdata.f, plot(DateTime, Global_reactive_power, type="l", xlab = "datetime"))

##Close graphics device
dev.off()