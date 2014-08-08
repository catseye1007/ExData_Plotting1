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
plot2<-plot(xrange, consum1$Global_active_power, type = "l", xlab = "", ylab="Global Active Power(Kilowatts)" ) 
dev.copy(png, file = "plot2.png")
dev.off()
