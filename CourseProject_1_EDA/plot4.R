## Create the fourth plot required for the EDA course.

#Download the data from the UCI repository and unzip it:
#fileUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(fileUrl, destfile = "data.zip")
#unzip("data.zip")

#Load into R:
DF=read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = c("?", ""))
date=as.Date(DF[["Date"]], "%d/%m/%Y")  #%y for 2-ditigs, %Y for 4 digits 
voltage=DF[["Voltage"]]
grp=DF[["Global_reactive_power"]]

#Select the period between 2007-02-01 and 2007-02-02
sel=(date>="2007-02-01") & (date<="2007-02-02")
SDF=subset(DF, sel, select=Sub_metering_1:Sub_metering_3)
voltage=voltage[sel]
date=date[sel]
grp=grp[sel]

#find the position of the first record from 2007-02-02 (Friday):
fri=sum(date=="2007-02-01")+1

#Make plots
png(filename = "plot4.png", width = 480, height = 480)

#Create a matrix of plots:
par(mfrow=c(2,2))

#Make the first plot (copy from plot2.R):

plot(gap, type="l", xlab="", ylab= "Global Active Power (kilowatts)", xaxt="n") #xaxt="n" -> no x ticks!
tic_positions=c(1, fri, length(gap))
axis(1, at=tic_positions, labels=c("Thu", "Fri", "Sat"))

#Make the second plot:
plot(voltage, type="l", xlab="datetime", ylab= "Voltage", xaxt="n") #xaxt="n" -> no x ticks!
tic_positions=c(1, fri, length(gap))
axis(1, at=tic_positions, labels=c("Thu", "Fri", "Sat"))

#Make the third plot (copy from plot3.R):
    
#plot the first line :
plot(SDF[[1]], type="l",  col="black", xlab="", ylab= "Energy sub metering", xaxt="n") #xaxt="n" -> no x ticks!
tic_positions=c(1, fri, length(gap))
axis(1, at=tic_positions, labels=c("Thu", "Fri", "Sat"))

#add the remaining lines:
lines(SDF[[2]], type="l", col="red")
lines(SDF[[3]], type="l", col="blue")
legend("topright", lty=1, lwd=1, col = c("black", "blue", "red"), legend = names(SDF))

#Make the fourth one:
plot(grp, type="l", xlab="datetime", ylab= "Global_reactive_power", xaxt="n") #xaxt="n" -> no x ticks!
tic_positions=c(1, fri, length(gap))
axis(1, at=tic_positions, labels=c("Thu", "Fri", "Sat"))

dev.off()

