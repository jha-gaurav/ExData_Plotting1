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

png(file = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
hist(as.numeric(use.df$Global_active_power), main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
			ylab = "Frequency", col = "red")

dev.off()


