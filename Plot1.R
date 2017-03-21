plot1<-function()
{
  DownloadAndUnzipAssigmentFileIfNeede()
  ActivePower <- ReadTable()
  png(file = "plot1.png", width = 480, height = 480, units = "px")
  with(ActivePower, hist(Global_active_power, col = "red", 
                   xlab = "Global active power (kilowatts)", 
                   main = "Global Active Power"))
  dev.off()
}

DownloadAndUnzipAssigmentFileIfNeede<-function()
{
  fileName<- "Electric_power_consumption.zip"
  ##chack to see that we didnt allredy downlode and unzip the file 
  if(!file.exists(fileName))
  {
    fileURL<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL,fileName,mode = "wb")
  }
  unzip(fileName)
}

ReadTable<-function()
{
  suppressMessages(ValidateLubridatePackage())
  fileName <-"household_power_consumption.txt"
  table <- read.csv(fileName,sep = ";",na.strings = "?")
  table <- table[table$Date == "1/2/2007" | table$Date == "2/2/2007",]
  table$datetime <- paste(table$Date, table$Time)
  table$datetime <- dmy_hms(table$datetime)
  table[,3:9] <- sapply(table[,3:9], as.numeric)
  return(table)
}

ValidateLubridatePackage <- function(){
  list.of.packages <- c("lubridate")
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)){
    print("The lubridate packege is a requierd package for this Function to work")
    install_Package <- menu(title = 'Should I automaticly install the package now?',choices = c("Yes","No"))
    if(install_Package)
    {
      suppressMessages(install.packages(new.packages))
    }
    else
    {
      return(FALSE)
    }
  }
  suppressMessages(library(lubridate))
  return(TRUE)
} 