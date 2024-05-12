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

### Pivot Tables

Prior to creating the dashboard, it was essential to generate pivot tables to visualize the data. Three pivot tables were created, all utilizing column values indicating whether a bike was purchased (yes or no). The main distinction among the pivot tables lay in their row values. The first pivot table included gender as row values, along with a column displaying the average income by gender. The second pivot table featured row values representing the distance traveled per commute, while the third table's rows represented customer age brackets derived from a previously created column. All three of these pivot tables were vital for the creation of the dashboard.

### Dashboard

The process of creating the Excel dashboard involved taking the previously generated pivot tables, incorporating slicers, and performing extensive formatting and alignment. Initially, it was necessary to remove grid lines to achieve a clean background and merge headers to create uniform titles. From there, the pivot tables were copied and pasted onto a new worksheet and aligned under the header using the alignment feature. Finally, slicers were added from the pivot tables for marital status, region, and education. These slicers enable users to filter the data by clicking on one or multiple buttons, applying the specified parameter to all pivot tables within the dashboard.

![Screenshot (2)](https://github.com/lkolb10/Data_Projects/assets/136652895/60084322-a237-46fa-a136-40d36bd28579)

### Findings

Upon reviewing the dashboard, even without applying any slicers, several insights emerge. Firstly, across both genders, individuals who purchased a bike tended to have higher incomes compared to their counterparts who did not. Additionally, a notable spike was observed in bike purchases among individuals within the middle age group bracket, whereas younger and older individuals were less inclined to make a purchase. Furthermore, the line graph illustrates a clear trend: individuals with shorter commutes were more likely to have purchased a bike, whereas those with longer commutes were less likely to have done so.



