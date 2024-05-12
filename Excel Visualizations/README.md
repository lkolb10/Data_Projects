# Excel Visualizations Analysis

### Project Overview

This data analysis project focuses on cleaning a sample dataset on bike sales and using the cleaned data to create an interactive dashboard. The dashboard addresses questions such as the age bracket of the most frequent bike purchasers, the average income per purchase by gender, customer commuting patterns, and more.

### Data Sources

Bike Sales Data: The primary dataset used for this analysis is the "Bike Sales.xlsx" file, which contains demographic data for customers and whether or not they purchased a bike. The Excel file is provided in the folder for the project, or can be viewed [here](https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fraw.githubusercontent.com%2Flkolb10%2FData_Projects%2Fmain%2FExcel%2520Visualizations%2FBike%2520Sales.xlsx&wdOrigin=BROWSELINK).

### Data Cleaning Process

For data cleaning, the following tasks were performed:

1. Check for duplicate values using conditional formatting, and then remove them in the data tab.
2. Use find and replace for marital status and gender, to spell out the whole words rather than a single letter abbreviation.
3. Create a new age bracket column that uses a nested if-statement to separate the ages into three groups: adolescent, middle age, and old. This becomes useful for visualization purposes.

Age Bracket column:

```excel
=IF(L2>54,"Old",IF(L2>30,"Middle Age","Adolescent"))
```






