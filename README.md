# Data_Cleaning

# Nashville Housing Data Cleanup

This repository contains a dataset named "Nashville Housing," which has been cleaned and preprocessed using SQL. The purpose of this analysis was to ensure data quality by populating missing address values, breaking out addresses into individual columns (Address, City, State), and removing duplicate entries.

## Analysis Steps:

### 1. Populating Addresses

Every property in the dataset should have a valid address. In this analysis, we addressed the issue of missing addresses (null values) by populating them where possible. This step is crucial for data integrity, as it ensures all properties have the necessary location information.

### 2. Breaking Out Addresses

To improve data organization and facilitate further analysis, we broke down the address information into individual columns: Address, City, and State. This process allows for better filtering, sorting, and querying based on specific address components.

### 3. Deleting Duplicates

Duplicates can distort analysis results and lead to incorrect conclusions. To clean up the dataset, we identified duplicate entries using the ROW_NUMBER function in SQL and subsequently removed them. This step helps maintain data accuracy and consistency.

