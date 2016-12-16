# list necessary libraries.
library(ggplot2)
library(data.table)
library(dplyr)
library(lubridate)
setwd('coursera')

# make sure the inptu files are in the working directory. 
cn<-c("Date" , "Time" , "Global_active_power","Global_reactive_power","Voltage" ,"Global_intensity" 
      ,"Sub_metering_1","Sub_metering_2" ,"Sub_metering_3"  )
## using pipeline operator, read the file and filter Feb dates.
hh.power.con<-fread("household_power_consumption.txt") %>% 
  filter(Date == '2/1/2007' | Date=='2/2/2007' ) 

# Create a new column by concatinating Date&Time columns and converting them to time.
hh.power.con$DateTime<-strptime(paste(hh.power.con$Date,hh.power.con$Time,sep = ' '),"%m/%d/%Y %H:%M:%S")
##hh.power.con$Date <- as.Date(hh.power.con$Date,"%m/%d/%Y")

plot(hh.power.con$DateTime,hh.power.con$Sub_metering_1,type="l",
     ylab='Energy Sub Metering',main='Global Active Power',xlab = '',ylim =c(0,30))
points(hh.power.con$DateTime,hh.power.con$Sub_metering_2,type="l",col='red')
points(hh.power.con$DateTime,hh.power.con$Sub_metering_3,type="l",col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'),lty=1,cex=0.5)

# write to file and close the device.
dev.copy(png,file='ExData_Plotting1/plot3.png',width = 480, height = 480, units = "px")
dev.off()