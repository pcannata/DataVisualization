setwd("~/Mine/UT/GitRepositories/DataVisualization/RWorkshop/15 Reformatting Data")
getwd()
file_path <- "Sample - Superstore - English (Extract).csv"
measures <- c("Customer_ID", "Discount", "Number_of_Records", "Order_ID", "Order_Quantity", "Product_Base_Margin", "Profit", "Sales", "Shipping_Cost", "Unit_Price" )
# file_path <- "Sample - Superstore Subset (Excel).csv"
# measures <- c()

df <- read.csv(file_path)
# Get rid of special characters.
# Google ASCII Table to understand the following:
for(n in names(df)) {
  df[n] <- data.frame(lapply(df[n], gsub, pattern="[^ -~]",replacement= ""))
}

# Replace "." (i.e., period) with "_" in the column names.
names(df) <- gsub("\\.+", "_", names(df))
dimensions <- setdiff(names(df), measures)
# names(df)
# dimensions
# measures

for(d in dimensions) {
  # Get rid of " and ' in dimensions.
  df[d] <- data.frame(lapply(df[d], gsub, pattern="[\"']",replacement= ""))
  # Change & to and in dimensions.
  df[d] <- data.frame(lapply(df[d], gsub, pattern="&",replacement= "and"))
  # Change : to ; in dimensions.
  df[d] <- data.frame(lapply(df[d], gsub, pattern=":",replacement= ";"))
}

# Get rid of all characters in measures except for numbers, the - sign, and period.
for(m in measures) {
  df[m] <- data.frame(lapply(df[m], gsub, pattern="[^--.,0-9]",replacement= ""))
}

# head(df)
write.csv(df, paste(gsub(".csv", "", file_path), ".reformatted.csv", sep=""), row.names=FALSE)