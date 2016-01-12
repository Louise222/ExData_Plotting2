# make sure that the folder "exdata-data-NEI_data" in your current repository
# read data
setwd("exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# emissions from motor vehicle sources changed from 1999–2008 in Baltimore City
library(dplyr)
library(ggplot2)
Maryland<-filter(NEI,fips=="24510" & type=="ON-ROAD")
motor_group<-group_by(Maryland,year)
motor_year<-summarize_each(motor_group,funs(sum(Emissions,na.rm=TRUE)))
png(filename = "plot5.png", width = 480, height = 480, units = "px")
g<-ggplot(motor_year,aes(year,Emissions))
g+geom_line()+geom_point()+labs(x="Year",y="Total Emissions",
  title="Emissions From Motor Vehicle Sources in Baltimore City")
dev.off()
# emissions from motor vehicle sources in Baltimore City decreased from 1999 to 2008.