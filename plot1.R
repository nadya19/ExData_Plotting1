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

##Open png graphics device, provide name of file and dimensions
png(file="plot1.png", height=480, width=480)

##Make histogram for Global Active Power variable, with x-axis title, main title, and set color to red
hist(powerdata.f$Global_active_power,xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

##Close graphics device
dev.off()
