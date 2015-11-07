# plot4.R
# gsgxnet 07.11.2015

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

household_power_consumption <-
  read.csv(
    pipe("egrep '^Date|^[1-2]/2/2007' household_power_consumption.txt"),
    row.names = NULL, sep = ";", stringsAsFactors = FALSE )

household_power_consumption$DateTime <-
  strptime(paste(household_power_consumption$Date, household_power_consumption$Time), "%d/%m/%Y %H:%M:%S")

par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0), cex = 0.7)
with(household_power_consumption, {
  # 
  plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  #
  plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(DateTime, Sub_metering_1, lwd = 1)
  lines(DateTime, Sub_metering_2, lwd = 1, col = "red")
  lines(DateTime, Sub_metering_3, lwd = 1, col = "blue")
  legend("topright", lty = 1, bty = "n", col = c("black", "red","blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  #
  plot(DateTime, Voltage, type = "l", xlab = "datetime") 
  #
  plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
  #mtext("Overview", outer = TRUE)
})

dev.copy(png, file = "plot4.png")
dev.off()

par(.pardefault) # reset par to defaults

