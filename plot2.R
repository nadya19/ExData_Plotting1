##Read in txt file, noting presence of header, and separating by semicolon; assign to object powerdata
powerdata <- read.table("household_power_consumption.txt", header=TRUE, sep = ";")

##Change format of date column to POSIXlt
powerdata$Date <- strptime(powerdata$Date, "%d/%m/%Y")
##Change format of date column to POSIXct
powerdata$Date <- as.POSIXct(powerdata$Date)

##Filter rows to only 2007-02-01 and 2007-02-02
powerdata.f <- filter(powerdata, Date=="2007-02-01" | Date=="2007-02-02")

##set Global Active Power variable to numeric
powerdata.f$Global_active_power <- as.numeric(paste(powerdata.f$Global_active_power))

##Concatenate Date and Time variables into new variable "DateTime"
powerdata.f$DateTime <- paste(powerdata.f$Date,powerdata.f$Time)

##Convert DateTime variable into POSIXct
powerdata.f$DateTime <- as.POSIXct(powerdata.f$DateTime)

##Open png graphics device, provide name of file and dimensions
png(file="plot2.png", height=480, width=480)

##Plot DateTime against Global_active_power, make plot blank for now, with y axis title specified, x axis title blank
with(powerdata.f, plot(DateTime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

##Close graphics device
dev.off()
