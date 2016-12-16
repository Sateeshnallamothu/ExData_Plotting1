# list necessary libraries.
library(ggplot2)
library(data.table)
library(dplyr)
library(lubridate)
setwd('coursera')

# make sure the inptu files are in the working directory. 
cn<-c("Date" , "Time" , "Global_active_power","Global_reactive_power","Voltage" ,"Global_intensity" 
      ,"Sub_metering_1","Sub_metering_2" ,"Sub_metering_3"  )
## using pipeline operator, read the file and filter Feb dates. (dd/mm/yyyy format)
hh.power.con<-fread("household_power_consumption.txt") %>% 
  filter(Date == '1/2/2007' | Date=='2/2/2007' ) 

# Create a new column by concatinating Date&Time columns and converting them to time.
hh.power.con$DateTime<-strptime(paste(hh.power.con$Date,hh.power.con$Time,sep = ' '),"%d/%m/%Y %H:%M:%S")
##hh.power.con$Date <- as.Date(hh.power.con$Date,"%d/%m/%Y")

plot(hh.power.con$DateTime,hh.power.con$Global_active_power,type="l",
    ylab='Global Active Power (kilowatts)',main='Global Active Power',xlab = '')

# write to file and close the device.
dev.copy(png,file='ExData_Plotting1/plot2.png',width = 480, height = 480, units = "px")
dev.off()
