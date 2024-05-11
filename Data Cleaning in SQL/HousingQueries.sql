/*

Cleaning Data in SQL Queries.

*/

-- Populating the Property Address Null Values

/*
Joins the table with itself based on the ParcelID column. If the ParcelIDs are the same and the UniqueIDs are different,
and a.PropertyAddress is null, then use the value of b.PropertyAddress for the null value of a.
*/

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Project_Portfolio.dbo.Housing_Data AS a
JOIN Project_Portfolio.dbo.Housing_Data AS b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

/*
Update the PropertyAddress column so that every instance of a.PropertyAddress that is null is replaced by the value
for b.PropertyAddress, since they are known to be the same.
*/

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Project_Portfolio.dbo.Housing_Data AS a
JOIN Project_Portfolio.dbo.Housing_Data AS b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

-- Separating Property Address into Individual Columns for Address and City

/*
To separate the columns, we can use the delimeter ',' since each address and city are split by
a comma. Taking the substring of the PropertyAddress column starting from the first character and
going until the comma minus 1 to exclude the comma from the actual address, we get the address.
Then the second substring starts one character after the comma and goes the full length of the
PropertyAddress column to get the city name.
*/

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Address
FROM Project_Portfolio.dbo.Housing_Data

/*
Add new columns for the finalized property and city addresses, now that they're split.
Update these columns to have the values from our original column using the substring methods
from before.
*/

ALTER TABLE Project_Portfolio.dbo.Housing_Data
ADD ActualPropertyAddress NVARCHAR(255)

UPDATE Project_Portfolio.dbo.Housing_Data
SET ActualPropertyAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE Project_Portfolio.dbo.Housing_Data
ADD ActualCityAddress NVARCHAR(255)

UPDATE Project_Portfolio.dbo.Housing_Data
SET ActualCityAddress = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

-- Separating Owner Address into State, City, Address

/*
The substring method is one way of doing this, but PARSENAME is much more efficient. With PARSENAME, it is
necessary to use the REPLACE function since PARSENAME searches for periods rather than commas. Then choose
the third item for address, second for city, and first for state.
*/

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM Project_Portfolio.dbo.Housing_Data

ALTER TABLE Project_Portfolio.dbo.Housing_Data
ADD ActualOwnerAddress NVARCHAR(255)

ALTER TABLE Project_Portfolio.dbo.Housing_Data
ADD ActualOwnerCity NVARCHAR(255)

ALTER TABLE Project_Portfolio.dbo.Housing_Data
ADD ActualOwnerState NVARCHAR(255)

UPDATE Project_Portfolio.dbo.Housing_Data
SET ActualOwnerAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

UPDATE Project_Portfolio.dbo.Housing_Data
SET ActualOwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

UPDATE Project_Portfolio.dbo.Housing_Data
SET ActualOwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

-- Removing duplicate row entries

/*
To remove duplicate entries, use a CTE called RowNum that partitions the row entries by ParcelID,
PropertyAddress, etc. Essentially, rows with the same values for these columns will recieve consecutive
row numbers, and if the row_num is greater than 1, meaning there is a duplicate row, that row will then
be deleted.
*/

WITH RowNumCTE AS (
	SELECT *,
		ROW_NUMBER() OVER (
		PARTITION BY ParcelID,
					 PropertyAddress,
					 SalePrice,
					 SaleDate,
					 LegalReference
					 ORDER BY
						UniqueID ) row_num
FROM Project_Portfolio.dbo.Housing_Data
)
DELETE FROM RowNumCTE
WHERE row_num > 1

-- Lastly, to get rid of unneccessary columns

ALTER TABLE Project_Portfolio.dbo.Housing_Data
DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict

