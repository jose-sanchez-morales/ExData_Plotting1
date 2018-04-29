plot3<- function(){
  ## This function reads data from a txt file 
  ## Makes a plot of the variables:
  ## Sub_metering_1
  ## Sub_metering_2
  ## Sub_metering_3
  ## vs. Date/time (weekdays)
  
  ## Step 1: Reading txt file and get rid of '?' values as missing values; replace by NA values.
  
  pow_dat <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
  pow_dat[ pow_dat == "?" ] <- NA
  
  ## Step 2: This is in order to sort the data by time (weekdays) in the GRAPH!!!!, so we add this column.
  
  TIME_COMBINED <- strptime(paste(pow_dat$Date, pow_dat$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
  pow_dat <- cbind(pow_dat, TIME_COMBINED)
  
  ## Step 3: Subset data for dates: 2007-02-01 and 2007-02-02.
  
  pow_dat$Date <- as.Date(pow_dat$Date, format="%d/%m/%Y")
  DataToPlot <- subset(pow_dat, Date == "2007-02-01" | Date =="2007-02-02")
  
  ## Step 4: Make the plot
  png("plot3.png", width=480, height=480)
  
  ## Column Sub_metering_1
  with(DataToPlot, plot(TIME_COMBINED, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
  ## Column Sub_metering_2
  lines(DataToPlot$TIME_COMBINED, DataToPlot$Sub_metering_2,type="l", col= "red")
  ## Column Sub_metering_3
  lines(DataToPlot$TIME_COMBINED, DataToPlot$Sub_metering_3,type="l", col= "blue")
  
  legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
  dev.off()
}