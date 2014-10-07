# Plot 1 - Red Histogram 
# open connection to file and read in the lines with the specified dates

con<-file("household_power_consumption.txt","r");
dat<-read.table(text = grep("^(1|2).2.2007",readLines(con),value=TRUE), sep=";", stringsAsFactors=F)
#read names from the power text file and use them as the names for the subset dataframe
names(dat)<-names(read.table("household_power_consumption.txt", header=TRUE, nrows=1, sep=";"))
close(con)

# recode date data (i created a day of week column, but didnt end up needing it)
dat$date.time<-strptime(paste(dat$Date,dat$Time),format="%d/%m/%Y %H:%M:%S")
dat$day<-format(dat$date.time, "%a")

#red histogram code
png(filename="plot1.png")
hist(dat$Global_active_power,col="red", xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()