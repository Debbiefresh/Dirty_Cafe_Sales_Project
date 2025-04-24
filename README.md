# Cleaning A Dirty Sales Cafe Data
## Project Overview

This project aims to clean and prepare the dirty cafe sales dataset for analysis. By changing the data type of one of the columns, fixing errors, removing blank spaces, and replacing unknown values in each field, I was able to clean the data and prepare it for analysis.

## Data Source

Dirty_Cafe_Sales: The [dirty_cafe_sales](https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training) is obtained from Kaggle. It consists of eight columns and 10,000 rows.

### Tools

MySQL Workbench - [Download here](https://dev.mysql.com/downloads/workbench/)

### Data Cleaning Process Implemented
The following steps are what I did to clean the data:
- Checked for duplicates and found none.
- Checked the data type for each column and observed transaction date column was in text data type, so I changed it to date data type.
- Set blank spaces in the transaction date column to null and updated the nulls to today's date.
- Changed the data type of the total spent column to double.
- Used regular expressions to find errors, unknowns, and blank spaces in item, total spent, and location columns.
- Replaced blank spaces with not available in each of the item, total spent, and location columns.
- Replaced error with null in each of the item, total spent, and location columns.

#### NB
Thank you so much for going through the project, I am open to corrections and feedback on how I would have done it better.




