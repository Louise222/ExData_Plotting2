# make sure that the folder "exdata-data-NEI_data" in your current repository
# read data
setwd("exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Use the base plotting system to make a plot of total emissions from PM2.5 in
# the Baltimore City, Maryland (fips=="24510") from 1999 to 2008
library(dplyr)
Maryland<-filter(NEI,fips=="24510")
Maryland_group<-group_by(Maryland,year)
Maryland_year<-summarize_each(Maryland_group,funs(sum(Emissions,na.rm=TRUE)))
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(Maryland_year$year,Maryland_year$Emissions,type="l",xlab="Year",
     ylab="Total PM2.5 Emission",
     main="Total PM2.5 Emission in Maryland From 1999 to 2008")
dev.off()
# we see that PM2.5 in Maryland varied during 1999 to 2008, not always decrease