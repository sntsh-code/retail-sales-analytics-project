========================================= TABLES RAW DATA, CLEAN SCRIPTS =============================================

----------------------------------------- TABLE customers ---------------------------------------------

SELECT 
		customer_id,
		CONCAT(
        UPPER(LEFT(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(name, '  ', ' '), '  ', ' ')), ' ', 1), 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(name, '  ', ' '), '  ', ' ')), ' ', 1), 2)),
		CASE 
			WHEN name LIKE '% %' THEN CONCAT(' ',
                UPPER(LEFT(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(name, '  ', ' '), '  ', ' ')), ' ', -1), 1)),
                LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(name, '  ', ' '), '  ', ' ')), ' ', -1), 2)))
                ELSE ''
      END) AS proper_name, 
          		email,
          		phone,
          		region_id
              FROM customers
              ;

------------------------ TABLES region ----------------------------------
  
UPDATE region
	SET region_name = CASE
    				WHEN TRIM(region_name) = '' OR region_name IS NULL THEN 'N/A'
    				ELSE UPPER(TRIM(region_name))
				END;
SELECT * FROM region;

---------------------- TABLE orders ------------------------------------
UPDATE orders
	SET satuts = CASE
    				WHEN TRIM(satuts) = '' OR satuts IS NULL THEN 'N/A'
    				ELSE UPPER(TRIM(satuts))
				END;
        SELECT 
              	order_id, 
              	customer_id, 
              	order_date, 
              	ship_date, 
              	satuts AS status 
        FROM orders 
        ORDER BY order_id;

-------------------- TABLE products ---------------------------------------
UPDATE products
	SET product_name = CASE
    				WHEN TRIM(product_name) = '' OR product_name IS NULL THEN 'N/A'
    				ELSE UPPER(TRIM(product_name))
				END;
UPDATE products
	SET category = CASE
    				WHEN TRIM(category) = '' OR category IS NULL THEN 'N/A'
    				ELSE UPPER(TRIM(category))
				END;
SELECT 
	ROW_NUMBER() OVER (ORDER BY product_id ) AS product_id,
    CONCAT(
        UPPER(LEFT(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(product_name, '  ', ' '), '  ', ' ')), ' ', 1), 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(product_name, '  ', ' '), '  ', ' ')), ' ', 1), 2)),
        CASE 
            WHEN product_name LIKE '% %' THEN CONCAT(
                ' ',
                UPPER(LEFT(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(product_name, '  ', ' '), '  ', ' ')), ' ', -1), 1)),
                LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(product_name, '  ', ' '), '  ', ' ')), ' ', -1), 2))
            )
            ELSE ''
        END  ) AS product_name,
            CONCAT(
        UPPER(LEFT(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(category, '  ', ' '), '  ', ' ')), ' ', 1), 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(category, '  ', ' '), '  ', ' ')), ' ', 1), 2)),
        CASE 
            WHEN category LIKE '% %' THEN CONCAT(
                ' ',
                UPPER(LEFT(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(category, '  ', ' '), '  ', ' ')), ' ', -1), 1)),
                LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(REPLACE(REPLACE(category, '  ', ' '), '  ', ' ')), ' ', -1), 2))
            )
            ELSE ''
        END  ) AS category,
    price
FROM products;
