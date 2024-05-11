# Data Cleaning in SQL Analysis

### Project Overview

This data analysis project aims to clean and enhance a raw dataset to make it more user-friendly for further analysis. The objectives include breaking down columns with excessive information into understandable individual columns, addressing null values, and removing duplicate records.

### Data Sources

Nashville Housing Data: The primary dataset used for this analysis is the "Housing Data for Data Cleaning.xlsx" file, which contains information on housing data in Nashville. The Excel file is provided in the folder for the project, or can be downloaded [here](https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fraw.githubusercontent.com%2Flkolb10%2FData_Projects%2Fmain%2FData%2520Cleaning%2520in%2520SQL%2FHousing%2520Data%2520for%2520Data%2520Cleaning.xlsx&wdOrigin=BROWSELINK).

### Data Cleaning Process

For data cleaning, the following tasks were performed:
1. Fill in null values for property or owner addresses. Since the property and owner addresses were always the same, it was simply a matter of filling one in for the other that was missing.
2. Break out the owner and property addresses both into individual columns including address, city, and state for each. This makes each record cleaner, and easier to filter.
3. Remove the duplicate entries. Entries that contained the same parcel ID, property address, sale price, sale date, and legal reference were considered the same, and multiples of these entries were removed.
4. Fields that were not needed anymore were removed for clarity.

### Findings

After the breaking out the property addresses into their separate columns for address and city using the substring method, it became clear that another method was much more efficient, and garnered the same results. The following code is what was used for the substring method, and was slightly more complicated:

```sql
SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Address
FROM Project_Portfolio.dbo.Housing_Data
```
Then using the optimal method:

```sql
SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM Project_Portfolio.dbo.Housing_Data
```
Note that the substring method for the property address didn't include the state, otherwise, it would've been even more complex than it already is. The second method split the owner address into the state, city, and address respectively.



