## Create the first plot required for the EDA course.

#Download the data from the UCI repository and unzip it:
fileUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "data.zip")
unzip("data.zip")

#Load into R:
DF=read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = c("?", ""))

#We need only:
date=as.Date(DF[["Date"]], "%d/%m/%Y")  #%y for 2-ditigs, %Y for 4 digits 
gap=DF[["Global_active_power"]]

#Select the period between 2007-02-01 and 2007-02-02
sel=(date>="2007-02-01") & (date<="2007-02-02")
gap=gap[sel]

#make the histogram and print it to plot1.png:
png(filename = "plot1.png", width = 480, height = 480)
hist(gap, main = "Global Active Power", xlab= "Global Active Power (kilowatts)", col="red")
dev.off()


# An important remark:
# We should have checked if the records were sorted by date and we actually did it:
# mean(date==sort(date))
# returns 1. So to simplify the code we don't bother about it anymore (in all tasks).

# Another shortcut:
# Actually, We should have also checked if the second variable, "Time", is also sorted (per day)
# We could have done it with:
#
# > dates=DF[["Date"]]
# > times=DF[["Time"]]
# > dt=paste(dates, times)
# > ndt=strptime(dt,  "%d/%m/%Y %H:%M:%S")
#
# etc., but that would be an overkill: a quick look at the data shows, that the data is actually sorted by datetime
# and the time intervals are exactly 1 minute, so when making plots (especially in plot4.R), we can just ignore time stamps
# and work with record indices only...
#
