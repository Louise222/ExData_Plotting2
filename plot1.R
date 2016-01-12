# make sure that the folder "exdata-data-NEI_data" in your current repository
# read data
setwd("exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# make a plot showing the total PM2.5 emission from all sources for each of 
# the years 1999, 2002, 2005, and 2008 using the base plot system.
library(dplyr)
NEI_group<-group_by(NEI,year)
NEI_year<-summarize_each(NEI_group,funs(sum(Emissions,na.rm=TRUE)))
png(filename = "plot1.png", width = 480, height = 480, units = "px")
plot(NEI_year$year,NEI_year$Emissions,type="l",xlab="Year",ylab="Total PM2.5 Emission",
     main="Total PM2.5 Emission in the United States From 1999 to 2008")
dev.off()
# we see that PM2.5 in the United States did decreased from 1999 to 2008