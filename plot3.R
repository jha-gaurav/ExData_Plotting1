#Step1: Read the complete dataset into a dataframe

data1 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
				stringsAsFactor = FALSE)

#Step 2: Select data from dates "2007-02-01" and "2007-02-02".

data1$Date <- as.Date(data1$Date, format = "%d/%m/%Y")

use.dt1 <- as.Date("2007-02-01", format = "%Y-%m-%d")
use.dt2 <- as.Date("2007-02-02", format = "%Y-%m-%d")

use.df <- data1[(data1$Date == use.dt1 | data1$Date == use.dt2), ]

#Now the dataframe to be used is use.df. Remove the original dataframe to release memory
rm(data1)

#Step 3: Remove the non-numeric values in the dataframe

use.df <- use.df[use.df$Global_active_power != '?', ]

#Step 4: Create plot1

use.df$dt <- strptime(paste(use.df$Date, use.df$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")
use.df$dt <- (as.numeric(use.df$dt) - as.numeric(use.df$dt[1]))/60

#Create ticks for x-axis

x.at <- c(min(use.df$dt), median(use.df$dt), max(use.df$dt))

#Create Labels for x-axis

day.name <- sapply(c(use.dt1, use.dt1 + 1, use.dt1 + 2), weekdays)
day.name <- substr(day.name, 1, 3)

#Create the plot now

png(file = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
with(use.df, plot(dt, Sub_metering_1, type = 'l', col = "black", 
		xlab = "", ylab = "Energy Sub Metering", xaxt = "n"))
with(use.df, lines(dt, Sub_metering_2, col = "red"))
with(use.df, lines(dt, Sub_metering_3, col = "blue"))
legend("topright", legend = colnames(use.df)[7:9], 
	col = c("black", "red", "blue"), lty = 1)

axis(side = 1, at = x.at, labels = day.name)

dev.off()

