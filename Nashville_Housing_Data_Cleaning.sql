/*
Cleaning data in MySQL
*/

SELECT * FROM portfolio_project.nashville_housing_data;

-- Converting Date Format
SELECT SaleDateConverted, CONVERT(SaleDate, Date)
FROM portfolio_project.nashville_housing_data;

UPDATE portfolio_project.nashville_housing_data
SET SaleDate = CONVERT(SaleDate, Date);

ALTER TABLE portfolio_project.nashville_housing_data
ADD SaleDateConverted Date;

UPDATE portfolio_project.nashville_housing_data
SET SaleDateConverted = CONVERT(SaleDate, Date);
--------------------------------------------------------------------------------------------

-- Populate property address data
UPDATE portfolio_project.nashville_housing_data 
SET PropertyAddress = NULL WHERE PropertyAddress='';

SELECT *
FROM portfolio_project.nashville_housing_data 
WHERE PropertyAddress IS NULL;

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, IFNULL(a.PropertyAddress,b.PropertyAddress)
FROM portfolio_project.nashville_housing_data AS a
JOIN portfolio_project.nashville_housing_data AS b
	ON a.ParcelID = b.ParcelID
    AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL;

UPDATE a
SET PropertyAddress = IFNULL(a.PropertyAddress,b.PropertyAddress)
FROM portfolio_project.nashville_housing_data AS a
JOIN portfolio_project.nashville_housing_data AS b
	ON a.ParcelID = b.ParcelID
    AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL;
---------------------------------------------------------------------------------------------

-- Breaking out PropertyAddress into individual columns (Address, City, State) 
-- Using SUBSTRING
SELECT PropertyAddress
FROM portfolio_project.nashville_housing_data;

SELECT
SUBSTRING_INDEX(PropertyAddress, ',', 1) AS Address,
SUBSTRING_INDEX(PropertyAddress, ',', -1) AS Address
FROM portfolio_project.nashville_housing_data;

ALTER TABLE portfolio_project.nashville_housing_data
ADD PropertySplitAddress NVARCHAR(255);

UPDATE portfolio_project.nashville_housing_data
SET PropertySplitAddress = SUBSTRING_INDEX(PropertyAddress, ',', 1);

ALTER TABLE portfolio_project.nashville_housing_data
ADD PropertySplitCity NVARCHAR(255);

UPDATE portfolio_project.nashville_housing_data
SET PropertySplitCity = SUBSTRING_INDEX(PropertyAddress, ',', -1);

SELECT *
FROM portfolio_project.nashville_housing_data;

-- Breaking out OwnerAddress into individual columns (Address, City, State) 
-- Using SUBSTRING
SELECT OwnerAddress
FROM portfolio_project.nashville_housing_data;
	-- PARCENAME only works with commas, so we will replace periods with commas
SELECT
SUBSTRING_INDEX(OwnerAddress, ',', 1) AS OwnerAddress,
SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress,', ', 2), ',',-1) AS OwnerAddressCity,
SUBSTRING_INDEX(OwnerAddress, ',', -1) AS OwnerAddressState
FROM portfolio_project.nashville_housing_data;

ALTER TABLE portfolio_project.nashville_housing_data
ADD OwnerSplitAddress NVARCHAR(255);

UPDATE portfolio_project.nashville_housing_data
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1);

ALTER TABLE portfolio_project.nashville_housing_data
ADD OwnerSplitCity NVARCHAR(255);

UPDATE portfolio_project.nashville_housing_data
SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress,', ', 2), ',',-1);

ALTER TABLE portfolio_project.nashville_housing_data
ADD OwnerSplitState NVARCHAR(255);

UPDATE portfolio_project.nashville_housing_data
SET OwnerSplitState = SUBSTRING_INDEX(OwnerAddress, ',', -1);
----------------------------------------------------------------------------------------------------

-- Changing Y and N to Yes and No in "Sold as Vacant" field 
-- Using CASE statement
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM portfolio_project.nashville_housing_data
GROUP BY SoldAsVacant
ORDER BY 2;

SELECT SoldAsVacant,
CASE 
	WHEN SoldAsVacant = 'Y' THEN "Yes"
	WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
END
FROM portfolio_project.nashville_housing_data;

UPDATE portfolio_project.nashville_housing_data
SET SoldAsVacant = CASE 
	WHEN SoldAsVacant = 'Y' THEN "Yes"
	WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
END;
--------------------------------------------------------------------------------------------------------

-- Deleting unused columns
SELECT *
FROM portfolio_project.nashville_housing_data;

ALTER TABLE portfolio_project.nashville_housing_data
DROP COLUMN OwnerAddress;

ALTER TABLE portfolio_project.nashville_housing_data
DROP COLUMN TaxDistrict;

ALTER TABLE portfolio_project.nashville_housing_data
DROP COLUMN PropertyAddress;

ALTER TABLE portfolio_project.nashville_housing_data
DROP COLUMN SaleDate;