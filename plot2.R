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

##Plot 2
png(filename="plot2.png",width=480,height=480,units="px")
plot(data$Global_active_power~data$DateTime, type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()