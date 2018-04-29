plot1<- function(){
  ## This function reads data from a txt file 
  ## Makes a histogram of the column 'Global Active Power'
  
  ## Step 1: Reading txt file and get rid of '?' values as missing values; replace by NA values.
  
  pow_dat <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
  pow_dat[ pow_dat == "?" ] <- NA
  
  ## Step 2: Subset data for dates: 2007-02-01 and 2007-02-02.
  
  pow_dat$Date <- as.Date(pow_dat$Date, format="%d/%m/%Y")
  DataToPlot <- subset(pow_dat, Date == "2007-02-01" | Date =="2007-02-02")
  
  ## Step 3: Convert string values for the column: 'Global_active_power' into NUMERIC.
  
  DataToPlot$Global_active_power <- as.numeric(DataToPlot$Global_active_power)
  
  ## Step 4: Plot histogram of global active power for selected days.
  
  png("plot1.png", width=480, height=480)
  hist(DataToPlot$Global_active_power, col="red", border="black", main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
  dev.off()
}