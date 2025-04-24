-- ============================================
-- Project: Cleaning Dirty Cafe Sales Data
-- Author: Obasi Deborah
-- Description: This SQL script cleans, transforms, 
-- and prepares the 'dirty_cafe_sales' table for analysis.
-- ============================================

-- View all records
SELECT * FROM c_sales.dirty_cafe_sales;

-- Check data types for each column
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dirty_cafe_sales'
  AND TABLE_SCHEMA = 'c_sales';

-- Modify Transaction ID column to be VARCHAR and set as PRIMARY KEY
ALTER TABLE c_sales.dirty_cafe_sales
MODIFY transaction_id VARCHAR(255),
ADD PRIMARY KEY (transaction_id);

-- Check for duplicate rows
-- Method 1: Using GROUP BY
SELECT *, COUNT(*) AS duplicate_count
FROM c_sales.dirty_cafe_sales
GROUP BY transaction_id, item, quantity, price_per_unit, total_spent, payment_method, location, transaction_date
HAVING COUNT(*) > 1;

-- Method 2: Using DISTINCT
SELECT COUNT(*) AS unique_rows
FROM (
  SELECT DISTINCT * 
  FROM c_sales.dirty_cafe_sales
) AS temp;

-- ============================
-- Cleaning 'item' column
-- ============================

SELECT DISTINCT item FROM c_sales.dirty_cafe_sales;

-- Count 'ERROR' and 'UNKNOWN'
SELECT COUNT(*) FROM c_sales.dirty_cafe_sales WHERE item = 'ERROR';
SELECT COUNT(*) FROM c_sales.dirty_cafe_sales WHERE item = 'UNKNOWN';

-- Replace blank spaces with 'Not Available'
UPDATE c_sales.dirty_cafe_sales
SET item = 'Not Available'
WHERE TRIM(item) = '';

-- Replace 'ERROR' with 'Null'
UPDATE c_sales.dirty_cafe_sales
SET item = 'Null'
WHERE item = 'ERROR';

-- Capitalize first letter
UPDATE c_sales.dirty_cafe_sales
SET item = CONCAT(UCASE(LEFT(item, 1)), LCASE(SUBSTRING(item, 2)));

-- ============================
-- Clean 'quantity' and 'price_per_unit' columns
-- ============================

SELECT DISTINCT quantity FROM c_sales.dirty_cafe_sales;
SELECT DISTINCT price_per_unit FROM c_sales.dirty_cafe_sales;

-- ============================
-- Cleaning 'total_spent' column
-- ============================

-- Identify invalid values
SELECT total_spent
FROM c_sales.dirty_cafe_sales
WHERE total_spent NOT REGEXP '^[0-9]+(\.[0-9]+)?$';

-- Replace non-numeric values with 0
UPDATE c_sales.dirty_cafe_sales
SET total_spent = 0
WHERE total_spent NOT REGEXP '^[0-9]+(\.[0-9]+)?$';

-- Change datatype to DOUBLE
ALTER TABLE c_sales.dirty_cafe_sales
MODIFY COLUMN total_spent DOUBLE;

-- Recalculate total_spent
UPDATE c_sales.dirty_cafe_sales
SET total_spent = quantity * price_per_unit;

-- ============================
-- Cleaning 'payment_method' column
-- ============================

SELECT DISTINCT payment_method FROM c_sales.dirty_cafe_sales;
SELECT COUNT(*) FROM c_sales.dirty_cafe_sales WHERE payment_method = 'ERROR';
SELECT COUNT(*) FROM c_sales.dirty_cafe_sales WHERE payment_method = 'UNKNOWN';

UPDATE c_sales.dirty_cafe_sales
SET payment_method = 'Not Available'
WHERE TRIM(payment_method) = '';

UPDATE c_sales.dirty_cafe_sales
SET payment_method = 'Null'
WHERE payment_method = 'ERROR';

UPDATE c_sales.dirty_cafe_sales
SET payment_method = CONCAT(UCASE(LEFT(payment_method, 1)), LCASE(SUBSTRING(payment_method, 2)));

-- ============================
-- Cleaning 'location' column
-- ============================

SELECT DISTINCT location FROM c_sales.dirty_cafe_sales;
SELECT COUNT(*) FROM c_sales.dirty_cafe_sales WHERE location = 'ERROR';
SELECT COUNT(*) FROM c_sales.dirty_cafe_sales WHERE location = 'UNKNOWN';

UPDATE c_sales.dirty_cafe_sales
SET location = 'Not Available'
WHERE TRIM(location) = '';

UPDATE c_sales.dirty_cafe_sales
SET location = 'Null'
WHERE location = 'ERROR';

UPDATE c_sales.dirty_cafe_sales
SET location = CONCAT(UCASE(LEFT(location, 1)), LCASE(SUBSTRING(location, 2)));

-- ============================
-- Cleaning 'transaction_date' column
-- ============================

SELECT DISTINCT transaction_date FROM c_sales.dirty_cafe_sales;

-- Replace invalid dates with NULL
UPDATE c_sales.dirty_cafe_sales
SET transaction_date = NULL
WHERE transaction_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

-- Change data type to DATE
ALTER TABLE c_sales.dirty_cafe_sales
MODIFY transaction_date DATE;

-- Replace NULLs with today’s date
UPDATE c_sales.dirty_cafe_sales
SET transaction_date = CURDATE()
WHERE transaction_date IS NULL;
