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
hh.power.con$Date <- as.Date(hh.power.con$Date,"%m/%d/%Y")

##hh.power.con$Time <- strptime(hh.power.con$Time,"%H:%M:%S")
hist(table(hh.power.con$Global_active_power),col='red',xlim=c(1,10),ylim=c(0,600),
     breaks=c(0,seq(2,50,2)),xlab='Global Active Power (kilowatts)',main='Global Active Power')

# write to file and close the device.
dev.copy(png,file='ExData_plotting1/plot1.png',width = 480, height = 480, units = "px")
dev.off()
