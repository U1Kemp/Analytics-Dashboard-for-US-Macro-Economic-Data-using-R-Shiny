# df = read.csv('~/Visualisation/FirstApp/Bengaluru_House_Data.csv',header = T)
# 
# str(df)
# table(df$total_sqft)
# 
# n = nrow(df)
# 
# for(i in 1:n){
#   dum = df$total_sqft[i]
#   dum = unlist(strsplit(dum,'-'))
#   dum = trimws(dum)
#   dum = as.numeric(dum)
#   dum = mean(dum)
#   df$total_sqft[i] = dum
#   if(i%%100 == 0){
#     #cat("i = ",i,'\n')
#   }
# }
# 
# str(df)
# df$total_sqft[df$total_sqft <100] <- NA
# table(df$total_sqft)
# 
# df$total_sqft = as.numeric(df$total_sqft)
# 
# summary(df$total_sqft)
# save(df,file = "Bengaluru_House_Data_Clean.RData")

# library(ggplot2)
# 
# fit = lm(log10(price)~log10(total_sqft),data = df)
# a = coef(fit)[1]
# b = coef(fit)[2]
# 
# ggplot(data=df,aes(x=total_sqft,y=price)) + geom_point()+
#   scale_x_log10() + scale_y_log10() + xlab("Total SqFt") +
#   ylab("Price") + geom_abline(intercept = a,slope = b,color = "red",lwd = 1.5)
# 
# 
# ggplot(data=df,aes(x=total_sqft,y=price)) + geom_point()+
#   scale_x_log10() + scale_y_log10() + xlab("Total SqFt") +
#   ylab("Price") + geom_smooth(method = "glm")



dataset <- read.csv("~/Visualisation/DB/DATA.csv")
colnames(dataset)[colnames(dataset) == "X..SHARE.OF.WORKING.POPULATION"] = "Working Population Share"
colnames(dataset)[colnames(dataset) == "MORTGAGE.INT..MONTHLY.AVG..."] = "Avg. Mortgage Monthly Increase"
colnames(dataset)[colnames(dataset) == "QUARTERLY.GDP.GROWTH.RATE...."] = "Quarterly GDP growth"
colnames(dataset)[colnames(dataset) == "UNRATE..."] = "Unemployment Rate"
colnames(dataset)[colnames(dataset) == "CONSUMER.CONF.INDEX"] = "Consumer Confidence Index"
colnames(dataset)[colnames(dataset) == "PPI.CONST.MAT."] = "PPI for construction materials"
colnames(dataset)[colnames(dataset) == "CPIALLITEMS"] = "Consumer Price Index"
colnames(dataset)[colnames(dataset) == "INFLATION..."] = "Inflation Rate"
colnames(dataset)[colnames(dataset) == "MED.HOUSEHOLD.INCOME"] = "Median Household Income"
colnames(dataset)[colnames(dataset) == "CORP..BOND.YIELD..."] = "Corporate Bond Yield"
colnames(dataset)[colnames(dataset) == "MONTHLY.HOME.SUPPLY"] = "Monthly Home Supply"
colnames(dataset)[colnames(dataset) == "GDP.PER.CAPITA"] = "GDP per capita"
colnames(dataset)[colnames(dataset) == "QUARTERLY.REAL.GDP"] = "Quarterly Real GDP"
colnames(dataset)[colnames(dataset) == "CSUSHPISA"] = "Case and Shiller Index"


# dataset <- na.omit(dataset)
# dataset$DATE <- as.Date(dataset$DATE,tryFormats = c("%d-%m-%Y"))
# colnames(dataset)[colnames(dataset) == "DATE"] = "Date"
save(dataset,file = "Cleaned_US_Economic_Data.RData")
load("Cleaned_US_Economic_Data.RData")





