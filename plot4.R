## Read the data from the file
## findstr /B /R ^[1-2]/2/2007 is subsetting the dataset before importing into R
data<-read.table(pipe('findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt'),
                 header=F, sep=';',stringsAsFactors=F,na.strings='?')
## Name the data.frame's column
colnames(data) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
## Add a new column with a proper date and time format
data<-cbind(data,DateTime=strptime(paste(data[,1],data[,2]),format="%d/%m/%Y %H:%M:%S"))
## Check the dataframe's structure
str(data)

##Plot4
png(filename="plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2))
plot(data$Global_active_power~data$DateTime, type="l",ylab="Global Active Power",xlab="")
plot(data$Voltage~data$DateTime, type="l",ylab="Voltage",xlab="datetime")
plot(data$Sub_metering_1~data$DateTime, type="l",ylab="Energy sub metering",xlab="",col="black")
lines(data$Sub_metering_2~data$DateTime,col="red")
lines(data$Sub_metering_3~data$DateTime,col="blue")
legend("topright",col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,bty="n")
plot(data$Global_reactive_power~data$DateTime, type="l",ylab="Global_reactive_power",xlab="datetime")
dev.off()