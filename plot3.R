# make sure that the folder "exdata-data-NEI_data" in your current repository
# read data
setwd("exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Use the ggplot plotting system to make a plot of the four types of sources 
# indicated by the type (point, nonpoint, onroad, nonroad) variable in emissions 
# from 1999–2008 for Baltimore City, Maryland (fips=="24510") 
library(dplyr)
library(ggplot2)
Maryland<-filter(NEI,fips=="24510")
Maryland[,5]<-tolower(sub("-","",Maryland[,5])) # for descriptive purposes
Maryland_group<-group_by(Maryland,type,year)
Maryland_type_year<-summarize_each(Maryland_group,funs(sum(Emissions,na.rm=TRUE)))
png(filename = "plot3.png", width = 480, height = 480, units = "px")
g <- ggplot(Maryland_type_year,aes(year,Emissions,color=type))
g + geom_line()+geom_point() + labs(x = "Year",y = "Total Emissions",
    title = "Total Emissions by Type in Maryland from 1999 to 2008")
dev.off()
# besides the type of point, others types in emissions all decreased