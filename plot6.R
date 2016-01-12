# make sure that the folder "exdata-data-NEI_data" in your current repository
# read data
setwd("exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California.
library(dplyr)
library(ggplot2)
Two_city<-filter(NEI,fips=="06037"|fips=="24510")
combined<-left_join(Two_city,SCC,by="SCC")
combined<-combined[,c(1:6,8)]
combined[,5]<-tolower(sub("-","",combined[,5]))
combined[,7]<-tolower(combined[,7])
combined_motor<-combined[grep("motor",combined[,7]),]
motor_group<-group_by(combined_motor,fips,year)
motor_year<-summarize_each(motor_group,funs(sum(Emissions,na.rm=TRUE)))
png(filename = "plot6.png", width = 480, height = 480, units = "px")
g<-ggplot(motor_year,aes(year,Emissions,color=fips))
g+geom_line()+geom_point()+labs(x="Year",y="Total Emissions",
  title="Emissions From Motor Vehicle Sources in Mayland & California")
dev.off()
# the red line represents for California(flips="06037"), the blue line represents
# for Maryland(flips="24510"). Emissions from motor vehicle sources in California
# is much higher than which in Baltimore City, Maryland.