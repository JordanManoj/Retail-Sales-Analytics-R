
# WEEK 2 : SALES ANALYTICS ASSIGNMENT
# Dataset : Superstore structure


# Load necessary libraries
library(dplyr)
library(lubridate)
library(ggplot2)

# Load the dataset
sales <- read.csv("C:/Users/jorda/Downloads/train.csv", stringsAsFactors = FALSE)

# 1: Data cleaning

# 1.1 Show missing values in each column
print(colSums(is.na(sales)))

# 1.2 Drop rows where Sales is NA
rows_before <- nrow(sales)
sales <- sales[!is.na(sales$Sales), ]
rows_after <- nrow(sales)

print(paste("Rows before cleaning:", rows_before))
print(paste("Rows after cleaning :", rows_after))

# 2: Date features

# 2.1 Convert Order.Date to Date format
sales$Order.Date <- as.Date(sales$Order.Date, format = "%m/%d/%Y")

# 2.2 Extract Year, Month, Weekday
sales$Year <- year(sales$Order.Date)
sales$Month <- month(sales$Order.Date, label = TRUE)
sales$Weekday <- weekdays(sales$Order.Date)

# 2.3 Find month with highest total Sales
monthly_sales <- aggregate(Sales ~ Month, data = sales, sum)
print("Month with highest total sales:")
print(monthly_sales[which.max(monthly_sales$Sales), ])

# 2.4 Find weekday with lowest average Sales
weekday_avg_sales <- aggregate(Sales ~ Weekday, data = sales, mean)
print("Weekday with lowest average sales:")
print(weekday_avg_sales[which.min(weekday_avg_sales$Sales), ])

# 3: Loop and condtional logic

# 3.1 Use for loop to print monthly sales totals
months <- unique(sales$Month)
for (m in months) {
  total <- sum(sales$Sales[sales$Month == m])
  print(paste("Sales for", m, ":", total))
}

# 3.2 Create Performance column: "High" if Sales > average, else "Low"
average_sales <- mean(sales$Sales)
sales$Performance <- ifelse(sales$Sales > average_sales, "High", "Low")


# 4: Grouping, Aggregating and custom function

# 4.1 Total Sales by Region
region_sales <- aggregate(Sales ~ Region, data = sales, sum)
print(region_sales)

# 4.2 Average Sales by Category
category_avg_sales <- aggregate(Sales ~ Category, data = sales, mean)
print(category_avg_sales)

# 4.3 Region with highest average sales
region_avg_sales <- aggregate(Sales ~ Region, data = sales, mean)
print("Region with highest average sales:")
print(region_avg_sales[which.max(region_avg_sales$Sales), ])

# 4.4 Custom function: region_report(region_name)
region_report <- function(region_name) {
  region_data <- sales[sales$Region == region_name, ]
  total_sales <- sum(region_data$Sales)
  
  product_sales <- aggregate(Sales ~ Product.Name, data = region_data, sum)
  top_product <- product_sales[which.max(product_sales$Sales), ]
  
  high_days <- region_data$Order.Date[region_data$Sales > average_sales]
  
  print(paste("Report for region:", region_name))
  print(paste("Total Sales:", total_sales))
  print("Top selling product:")
  print(top_product)
  print("Dates with above-average sales:")
  print(high_days)
}

# Example usage:
region_report("South")

# 5: Visualizing

# 5.1 Bar Chart: Region vs Sales
ggplot(sales, aes(x = Region, y = Sales)) +
  geom_bar(stat = "summary", fun = sum, fill = "skyblue") +
  ggtitle("Total Sales by Region")

# 5.2 Line Chart: Date vs Sales
ggplot(sales, aes(x = Order.Date, y = Sales)) +
  geom_line(color = "darkgreen") +
  ggtitle("Sales Trend Over Time")

# 5.3 Stacked Bar: Category vs Sales (fill = Performance)
ggplot(sales, aes(x = Category, y = Sales, fill = Performance)) +
  geom_bar(stat = "identity") +
  ggtitle("Sales by Category and Performance")
