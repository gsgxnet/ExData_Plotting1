# plot3.R
# gsgxnet 06.11.2015

# assumption is the data file household_power_consumption.txt is put into the same directory where the
# plot scripts are
# the data file is not part of the repository because it should be already on every reviewers computer
# and should be copied by the reviewer into the R scripts directory

# this script follows the suggestion of the instructor to read only those rows into memory
# which are needed for the plots.
# I have choosen (e)grep to filter for only those rows which are needed.
# So these scripts can only be reviewed by running them on systems where egrep is available.
# It is part of OSX and LINUX and available for Windows as well.

# store the grahics system parametes so we can reset them to defaults before we exit
.pardefault <- par(no.readonly = T)

household_power_consumption <- read.csv(pipe("egrep '^Date|^[1-2]/2/2007' household_power_consumption.txt"), 
                                        row.names=NULL, sep=";", stringsAsFactors=FALSE)
# convert Date and Time Columns into a new datetime column 
household_power_consumption$DateTime <- strptime(paste(household_power_consumption$Date, 
                                                       household_power_consumption$Time), "%d/%m/%Y %H:%M:%S")
plot(household_power_consumption$DateTime, household_power_consumption$Sub_metering_1, type="n", 
     xlab="", ylab="Energy sub metering", cex=0.8)
lines(household_power_consumption$DateTime, household_power_consumption$Sub_metering_1, lwd=1)
lines(household_power_consumption$DateTime, household_power_consumption$Sub_metering_2, lwd=1, col="red")
lines(household_power_consumption$DateTime, household_power_consumption$Sub_metering_3, lwd=1, col="blue")

legend("topright", lty = 1, col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png")
dev.off()

par(.pardefault) # reset par to defaults