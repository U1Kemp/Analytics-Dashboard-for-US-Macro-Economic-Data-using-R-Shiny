# Reading the data
dataset <- read.csv("~/DATA.csv")

# Renaming the columns for better readability
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
colnames(dataset)[colnames(dataset) == "DATE"] = "Date"

# Removing NA values
dataset <- na.omit(dataset)

# changing DATE from type string to type Date
dataset$DATE <- as.Date(dataset$DATE,tryFormats = c("%d-%m-%Y"))

# saving the cleaned and processed data as an RData file
save(dataset,file = "Cleaned_US_Economic_Data.RData")
## load("Cleaned_US_Economic_Data.RData")





