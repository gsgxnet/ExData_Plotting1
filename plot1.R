# plot1.R
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

# read the data file. The egrep pattern is used to filter header and all rows from the requested dates
household_power_consumption <- read.csv(pipe("egrep '^Date|^[1-2]/2/2007' ./household_power_consumption.txt"), 
                                        row.names=NULL, sep=";", stringsAsFactors=FALSE)

# plot histogram
hist(household_power_consumption$Global_active_power,col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()

par(.pardefault) # reset par to defaults
