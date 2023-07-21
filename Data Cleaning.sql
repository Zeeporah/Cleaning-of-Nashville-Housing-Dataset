--DATA CLEANING PROJECT


-- WHAT THE DATA LOOKS LIKE
SELECT TOP 1000 *
FROM dbo.Nashville_Housing

-- POPULATE PROPERTY ADDRESS DATA
--every property has to have an address so having an address with a null value is wrong so that is why we are populating the address
SELECT propertyaddress
FROM dbo.Nashville_Housing
where propertyaddress is null

--looking through the parcel id, you will find out that the same parcel ids has the same property address so we can populate the property address with null values with the property address having the same parcel ids 
SELECT *
FROM dbo.Nashville_Housing
--where propertyaddress is null
order by parcelid

--to do this, we have to do a self join
SELECT a.ParcelID, a.propertyaddress, b.ParcelId, b.propertyaddress, ISNULL(a.propertyaddress, b.propertyaddress)
FROM dbo.Nashville_Housing a
JOIN dbo.Nashville_Housing b
ON a.ParcelID = b.ParcelId
AND a.uniqueID <> b.uniqueID
where a.propertyAddress is null

UPDATE a
SET propertyaddress = ISNULL(a.propertyaddress, b.propertyaddress)
FROM dbo.Nashville_Housing a
JOIN dbo.Nashville_Housing b
ON a.ParcelID = b.ParcelId
AND a.uniqueID <> b.uniqueID

--BREAKING OUT ADDRESSES INTO INDIVIDUAL COLUMNS (Address, City, State)

--- first property address
SELECT 
PARSENAME(REPLACE(propertyaddress, ',', '.' ),2) AS address,
PARSENAME(REPLACE(propertyaddress, ',', '.' ),1) AS address
FROM dbo.Nashville_Housing

ALTER TABLE Nashville_Housing
ADD new_propertyaddress nvarchar(255)

UPDATE Nashville_Housing
SET new_propertyaddress = PARSENAME(REPLACE(propertyaddress, ',', '.' ),2)

ALTER TABLE Nashville_Housing
ADD new_propertycity nvarchar(255)

UPDATE Nashville_Housing
SET new_propertycity = PARSENAME(REPLACE(propertyaddress, ',', '.' ),1)



---next owner address

SELECT 
PARSENAME(REPLACE(owneraddress, ',', '.' ),3),
PARSENAME(REPLACE(owneraddress, ',', '.' ),2),
PARSENAME(REPLACE(owneraddress, ',', '.' ),1)
FROM dbo.Nashville_Housing


ALTER TABLE Nashville_Housing
ADD new_owneraddress nvarchar(255)

UPDATE Nashville_Housing
SET new_owneraddress = PARSENAME(REPLACE(owneraddress, ',', '.' ),3)

ALTER TABLE Nashville_Housing
ADD new_ownercity nvarchar(255)

UPDATE Nashville_Housing
SET new_ownercity = PARSENAME(REPLACE(owneraddress, ',', '.' ),2)

ALTER TABLE Nashville_Housing
ADD new_ownerState nvarchar(255)

UPDATE Nashville_Housing
SET new_ownerState = PARSENAME(REPLACE(owneraddress, ',', '.' ),1)



---DELETE DUPLICATES
-- to identify duplicates, you can use a number of things. let's go with rownumber

WITH ROW_NUMCTE as (
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 LegalReference, 
				 SaleDate
	ORDER BY UniqueID
	)Row_Num
FROM dbo.Nashville_Housing)

---DELETE DUPLICATES
DELETE
FROM ROW_NUMCTE
where row_num >1
--ORDER BY ParcelID

-- DELETE UNUSED COLUMNS
ALTER TABLE dbo.Nashville_Housing
DROP COLUMN PropertyAddress, OwnerADDRESS, TaxDistrict

SELECT *
FROM dbo.Nashville_Housing




