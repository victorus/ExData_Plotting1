## Create the second plot required for the EDA course.

#Download the data from the UCI repository and unzip it:
#fileUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(fileUrl, destfile = "data.zip")
#unzip("data.zip")

#Load into R:
DF=read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = c("?", ""))
#We need only:
date=as.Date(DF[["Date"]], "%d/%m/%Y")  #%y for 2-ditigs, %Y for 4 digits 
gap=DF[["Global_active_power"]]

#Select the period between 2007-02-01 and 2007-02-02
sel=(date>="2007-02-01") & (date<="2007-02-02")
date=date[sel]
#find the position of the first record from 2007-02-02 (Friday):
fri=sum(date=="2007-02-01")+1
gap=gap[sel]

#make the histogram and print it to plot2.png:
png(filename = "plot2.png", width = 480, height = 480)

plot(gap, type="l", xlab="", ylab= "Global Active Power (kilowatts)", xaxt="n") #xaxt="n" -> no x ticks!
tic_positions=c(1, fri, length(gap))
axis(1, at=tic_positions, labels=c("Thu", "Fri", "Sat"))

dev.off()

