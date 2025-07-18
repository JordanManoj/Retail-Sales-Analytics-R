# Retail Sales Analytics with R

This project performs exploratory data analysis and visualization on a Superstore retail dataset using R. It was built as part of a Week 2 Data Analytics Internship Assignment.

## Objective

- Clean and prepare sales data
- Extract date-based insights (month, weekday, year)
- Analyze performance by region and category
- Create a `Performance` classification using conditional logic
- Build a custom `region_report()` function
- Visualize insights using `ggplot2`

## Dataset Columns

The dataset includes the following fields:
- Order ID, Order Date, Ship Date
- Customer Name, Segment, Region
- Product Name, Category, Sub-Category
- Sales Amount

## Tools Used

- **R**
- **dplyr** — for data wrangling
- **lubridate** — for working with dates
- **ggplot2** — for visualizations

## Key Outputs

- Bar chart of sales by region
- Line chart of sales trends over time
- Stacked bar chart of product category vs performance

## Functionality Implemented

- Loop to calculate monthly sales
- Conditional logic to classify high/low sales
- Aggregated summaries for region/category
- Custom function: `region_report(region_name)` that shows:
  - Total revenue
  - Top-selling product
  - Dates with above-average sales






