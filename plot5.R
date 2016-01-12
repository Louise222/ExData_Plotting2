# make sure that the folder "exdata-data-NEI_data" in your current repository
# read data
setwd("exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# emissions from motor vehicle sources changed from 1999–2008 in Baltimore City
library(dplyr)
Maryland<-filter(NEI,fips=="24510")
combined<-left_join(Maryland,SCC,by="SCC")
combined<-combined[,c(1:6,8)]
combined[,5]<-tolower(sub("-","",combined[,5]))
combined[,7]<-tolower(combined[,7])
combined_motor<-combined[grep("motor",combined[,7]),]
motor_group<-group_by(combined_motor,year)
motor_year<-summarize_each(motor_group,funs(sum(Emissions,na.rm=TRUE)))
png(filename = "plot5.png", width = 480, height = 480, units = "px")
plot(motor_year$year,motor_year$Emissions,type="l",xlab="Year",ylab="Total Emissions",
     main="Emissions From Motor Vehicle Sources in Baltimore City")
dev.off()
# emissions from motor vehicle sources in Baltimore City increased before 2002,
# and decreased after that year