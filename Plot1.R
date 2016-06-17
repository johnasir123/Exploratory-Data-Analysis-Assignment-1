if(!file.exists("exdata-data-household_power_consumption.zip")) {
  #create temp file
  temp <- tempfile()
  
  #download file from URL
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  
  #unzip file
  file <- unzip(temp)
  
  #dekete temp file
  unlink(temp)
}

#read text file with header and separated by ";"and store into data frame power
power <- read.table(file, header=T, sep=";")


#convert date field into date format
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

#subsetting power by date filter and store into data frame dt
df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]

#convert active_power field into numeric format
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

#convert Global_reactive_power field into numeric format
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))

#convert Voltage field into numeric format
df$Voltage <- as.numeric(as.character(df$Voltage))

#concatenate (paste) date and time as timestamp and transform into data frame dt
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

plot1 <- function() {
  hist(df$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  cat("Plot1.png has been saved in", getwd())
}
plot1()


