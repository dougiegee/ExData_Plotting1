# Four plot array
# open connection to file and read in the lines with the specified dates

con<-file("household_power_consumption.txt","r");
dat<-read.table(text = grep("^(1|2).2.2007",readLines(con),value=TRUE), sep=";", stringsAsFactors=F)
#read names from the power text file and use them as the names for the subset dataframe
names(dat)<-names(read.table("household_power_consumption.txt", header=TRUE, nrows=1, sep=";"))
close(con)

#recode date data (i created a day of week column, but didnt end up needing it)
dat$date.time<-strptime(paste(dat$Date,dat$Time),format="%d/%m/%Y %H:%M:%S")
dat$day<-format(dat$date.time, "%a")

# create the 4 plots in a 2 x 2 layout
png(filename="plot4.png")
par(mfrow=c(2,2))
with(dat, {
  plot(date.time, Global_active_power, type="l", ylab="Global Active Power",xlab="")
  plot(date.time, Voltage, type="l", ylab="Voltage")
  plot(date.time, Sub_metering_1, type="l",ylab="Energy sub metering", xlab="")
  lines(date.time, Sub_metering_2, col="red", xlab="")
  lines(date.time, Sub_metering_3, col="blue", xlab="")
  legend("topright",lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(date.time, Global_reactive_power, type="l")
})
dev.off()