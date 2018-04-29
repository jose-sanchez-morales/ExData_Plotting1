plot4<- function(){
  ## This function reads data from a txt file 
  ## Makes a 4-graph plot using previous plots.
  
  ## Step 1: Reading txt file and get rid of '?' values as missing values; replace by NA values.
  
  pow_dat <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
  pow_dat[ pow_dat == "?" ] <- NA
  
  ## Step 2: This is in order to sort the data by time (weekdays) in the GRAPH!!!!, so we add this column.
  
  TIME_COMBINED <- strptime(paste(pow_dat$Date, pow_dat$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
  pow_dat <- cbind(pow_dat, TIME_COMBINED)
  
  ## Step 3: Subset data for dates: 2007-02-01 and 2007-02-02.
  
  pow_dat$Date <- as.Date(pow_dat$Date, format="%d/%m/%Y")
  DataToPlot <- subset(pow_dat, Date == "2007-02-01" | Date =="2007-02-02")
  
  ## Step 4: Plot the 4 graphs
  png("plot4.png", width=480, height=480)
  # 2 rows x 2 columns grid PLOT
  par(mfrow=c(2,2))
  # 1st graph
  with(DataToPlot, plot(TIME_COMBINED, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
  # 2nd graph
  with(DataToPlot, plot(TIME_COMBINED, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
  # 3rd graph
  with(DataToPlot, plot(TIME_COMBINED, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
  lines(DataToPlot$TIME_COMBINED, DataToPlot$Sub_metering_2,type="l", col= "red")
  lines(DataToPlot$TIME_COMBINED, DataToPlot$Sub_metering_3,type="l", col= "blue")
  legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, bty = "n", col = c("black", "red", "blue"))
  # 4th graph
  with(DataToPlot, plot(TIME_COMBINED, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
  dev.off()
}