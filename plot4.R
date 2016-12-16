# list necessary libraries.
library(ggplot2)
library(data.table)
library(dplyr)
library(lubridate)
setwd('coursera')

# make sure the inptu files are in the working directory. 
cn<-c("Date" , "Time" , "Global_active_power","Global_reactive_power","Voltage" ,"Global_intensity" 
      ,"Sub_metering_1","Sub_metering_2" ,"Sub_metering_3"  )
## using pipeline operator, read the file and filter Feb dates.  dd/mm/yyyy format
hh.power.con<-fread("household_power_consumption.txt") %>% 
  filter(Date == '1/2/2007' | Date=='2/2/2007' ) 

# Create a new column by concatinating Date&Time columns and converting them to time.
hh.power.con$DateTime<-strptime(paste(hh.power.con$Date,hh.power.con$Time,sep = ' '),"%d/%m/%Y %H:%M:%S")

# prepare plot
par(mfrow=c(2,2),mar=c(4,4,1,1),oma=c(0,0,2,0))

#first plot
plot(hh.power.con$DateTime,hh.power.con$Global_active_power,type="l",
     ylab='Global Active Power',xlab = '',ylim=c(0,8),cex.lab=0.75,cex.axis=0.75)
#2nd
plot(hh.power.con$DateTime,hh.power.con$Voltage,type="l",ylab='Voltage',xlab = 'DateTime',
     ylim=c(234,247),cex.lab=0.75,cex.axis=0.75)

#3rd
plot(hh.power.con$DateTime,hh.power.con$Sub_metering_1,type="l",
     ylab='Energy Sub Metering',xlab = '',ylim =c(0,40),cex.lab=0.75,cex.axis=0.75)
points(hh.power.con$DateTime,hh.power.con$Sub_metering_2,type="l",col='red')
points(hh.power.con$DateTime,hh.power.con$Sub_metering_3,type="l",col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'),lty=1,cex=0.5)

#4th plot
plot(hh.power.con$DateTime,hh.power.con$Global_reactive_power,type="l",
       ylab='Global Reactive Power',xlab = 'DateTime',ylim=c(0.0,0.5),cex.lab=0.75,cex.axis=0.75)

mtext('Household Electric Power Consumption',outer=TRUE,pch=2)
# write to file and close the device.
dev.copy(png,file='ExData_Plotting1/plot4.png',width = 480, height = 480, units = "px")
dev.off()