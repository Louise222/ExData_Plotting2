# make sure that the folder "exdata-data-NEI_data" in your current repository
# read data
setwd("exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# emissions from coal combustion-related sources changed from 1999–2008
library(dplyr)
combined<-left_join(NEI,SCC,by="SCC")
combined<-combined[,c(1:6,9)]
combined[,5]<-tolower(sub("-","",combined[,5]))
combined[,7]<-tolower(combined[,7])
combined_coal<-combined[grep("coal",combined[,7]),]
coal_group<-group_by(combined_coal,year)
coal_year<-summarize_each(coal_group,funs(sum(Emissions,na.rm=TRUE)))
png(filename = "plot4.png", width = 480, height = 480, units = "px")
plot(coal_year$year,coal_year$Emissions,type="l",xlab="Year",ylab="Total Emissions",
     main="Emissions From Coal Combustion-related Sources(1999 to 2008)")
dev.off()
# coal combustion-related sources decreased slightly before 2005, and droped 
# rapidly between 2005 and 2008.