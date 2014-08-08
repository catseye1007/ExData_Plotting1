consumption<-read.table("household_power_consumption.txt", header = TRUE)
head(consumption)
splitNames<-strsplit(names(consumption), "\\.")
splitNames
splitNames<-unlist(splitNames)
class(splitNames)

TheDate<-c(grep("^1/2/2007", consumption[,1]), grep("^2/2/2007", consumption[,1]))
TheDate
consum<-consumption[TheDate,]
head(consum)
tail(consum)
str(consum)
consum<-as.character(consum)
consum<-strsplit(consum,";")

consum1<-data.frame(matrix(unlist(consum), ncol=9, byrow=T))  ##consum1<-do.call(rbind.data.frame, consum), data.frame(t(sapply(consum,c)))
head(consum1)
names(consum1)<-splitNames
tail(consum1)
consum1$Date<-as.Date(consum1$Date, "%d/%m/%Y")

as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}

consum1[,3:9]<-sapply(consum1[,3:9],as.numeric.factor)
xrange<-strptime(paste(consum1$Date, consum1$Time), format = "%Y-%m-%d %H:%M:%S")

par(mfrow = c(2,2))
plot2<-plot(xrange, consum1$Global_active_power, type = "l", xlab = "", ylab="Global Active Power(Kilowatts)" ) 

plot4<- plot(xrange, consum1$Voltage, type="l", xlab = "datetime", ylab="Voltage" ) 

plot3<-plot(xrange, consum1$Sub_metering_1, type="l", xlab = "", ylab="Energy Sub Metering" ) 
lines(xrange, consum1$Sub_metering_2, col = "red")
lines(xrange, consum1$Sub_metering_3, col = "blue")

legend("topright", pch = "——", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.2, yjust = 1, bty = "n")

plot5<- plot(xrange, consum1$Global_reactive_power, type="l", xlab = "datetime", ylab="Global_reactive_power" ) 
dev.copy(png, file = "plot4.png")
dev.off()



