# Sub metering 1-3, overlay plot
# open connection to file and read in the lines with the specified dates

con<-file("household_power_consumption.txt","r");
dat<-read.table(text = grep("^(1|2).2.2007",readLines(con),value=TRUE), sep=";", stringsAsFactors=F)
#read names from the power text file and use them as the names for the subset dataframe
names(dat)<-names(read.table("household_power_consumption.txt", header=TRUE, nrows=1, sep=";"))
close(con)

#recode date data (i created a day of week column, but didnt end up needing it)
dat$date.time<-strptime(paste(dat$Date,dat$Time),format="%d/%m/%Y %H:%M:%S")
dat$day<-format(dat$date.time, "%a")

#overlaid time series of sub metering 1-3
png(filename="plot3.png")
  plot(dat$date.time, dat$Sub_metering_1, type="l",ylab="Energy sub metering", xlab="")
    lines(dat$date.time, dat$Sub_metering_2, col="red", xlab="")
    lines(dat$date.time, dat$Sub_metering_3, col="blue", xlab="")
    legend("topright",lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()