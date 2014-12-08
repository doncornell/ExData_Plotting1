# plot2.R: Project 1, part 3 of Exploratory Data Analysis (Johns Hopkins / Coursera)
# 
# Reads electrical power consumption data and creates a png file of submetering over time
# 

if(!file.exists(".\\data")){dir.create(".\\data")}
hpcfile <- ".\\data\\household_power_consumption.txt"
if(file.exists(hpcfile))
  {
  print ("reading from existing text file . . . .")
  alldata <- read.table(hpcfile, sep=";", header = TRUE, stringsAsFactors = FALSE)
  } else
  {
  print ("downloading and reading from temporary zipped file")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"  
  download.file(fileUrl,temp)
  alldata <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header = TRUE, stringsAsFactors = FALSE)
  unlink(temp)
  }

# extract data from the dates 2007-02-01 and 2007-02-02
data <- alldata[(alldata$Date=="1/2/2007") | (alldata$Date=="2/2/2007"),]
#
data$datetime <- strptime(paste(data$Date, data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

png(filename=".\\data\\plot3.png", width=480, height=480)
plot(data$datetime, as.numeric(data$Sub_metering_1), type="l",
     xlab="",
     ylab='Energy sub metering')
lines(data$datetime, as.numeric(data$Sub_metering_2), type="l", col="red")
lines(data$datetime, as.numeric(data$Sub_metering_3), type="l", col="blue")
legend('topright', c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lty=1, col=c('black','red','blue'))

dev.off()
