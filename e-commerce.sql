CREATE DATABASE LB_PROJECT

USE LB_PROJECT

-- CREATE A CONTAINER (SCHEMA) A TABLE FOR INSERTING THE DATA
-- KEEP ALL FEILDS AS A CONTAINER (CREATE COLUMNS WITH DATATYPE VARCHAR(MAX))




--SELLER TABLE

CREATE TABLE SELLER 
(seller_id	VARCHAR(MAX), seller_zip_code_prefix VARCHAR(MAX),seller_city VARCHAR(MAX), seller_state VARCHAR(MAX))

-- TO GET DETAILED VIEW OF ALL TABLES

SELECT * FROM INFORMATION_SCHEMA.COLUMNS

-- TO FIND OUT ABOUT PARTICULAR DETAILS 

SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS

--BULK INSERT

BULK INSERT SELLER 
FROM 'C:\Users\HP\Downloads\sellers_table.csv'
WITH (FIELDTERMINATOR= ',',
		ROWTERMINATOR='\n',
		firstrow=2)

SELECT TOP 10 * FROM SELLER;

SELECT DISTINCT SELLER_ZIP_CODE_PREFIX FROM SELLER

ALTER TABLE SELLER 
ALTER COLUMN SELLER_ZIP_CODE_PREFIX INT

SELECT DISTINCT SELLER_STATE FROM SELLER

-- THERE ARE TWO SELLER_STATE THAT IS NOT OF SAME FORMAT LIKE OTHER SELLER_STATE- HENCE WE UPDATE IT

SELECT * FROM SELLER WHERE SELLER_STATE= ' rio de janeiro, brasil",RJ'

 UPDATE SELLER SET SELLER_STATE = 'RJ' 
 WHERE SELLER_STATE= ' rio de janeiro, brasil",RJ'

 UPDATE SELLER SET SELLER_STATE = 'RS' 
 WHERE SELLER_STATE= ' rio grande do sul, brasil",RS'

 SELECT DISTINCT SELLER_STATE FROM SELLER

 -- TO FIND OUT THE DUPLICATE RECORDS/ROWS FROM OUR DATA
SELECT COUNT(*) FROM SELLER
SELECT DISTINCT COUNT(*) FROM SELLER

--ITS THE SAME AS THE TOTAL NUMBER OF ROWS IN ORIGINAL DATA, HENCE NO DUPLICATES



 --PRODUCTS_TABLE

 CREATE TABLE PRODUCT
 (product_id VARCHAR(MAX), product_category_name VARCHAR(MAX), product_name_lenght VARCHAR(MAX),
 product_description_lenght VARCHAR(MAX),	product_photos_qty VARCHAR(MAX),	product_weight_g VARCHAR(MAX),	
 product_length_cm	VARCHAR(MAX), product_height_cm VARCHAR(MAX),	product_width_cm VARCHAR(MAX))

 BULK INSERT PRODUCT 
 FROM 'C:\Users\HP\Downloads\products_table.csv'
WITH (FIELDTERMINATOR= ',',
		ROWTERMINATOR='\n',
		firstrow=2)

select top 10 * from product

SELECT DISTINCT product_category_name FROM PRODUCT


 -- TO FIND OUT THE DUPLICATE RECORDS/ROWS FROM OUR DATA
SELECT COUNT(*) FROM PRODUCT
SELECT DISTINCT COUNT(*) FROM PRODUCT

--ITS THE SAME AS THE TOTAL NUMBER OF ROWS IN ORIGINAL DATA, HENCE NO DUPLICATES

select count(*), count(product_category_name),count(product_name_lenght) ,count(product_description_lenght) , count(product_photos_qty),
count(product_weight_g), count(product_length_cm) ,count(product_height_cm) , count(product_width_cm)
from PRODUCT

select * from PRODUCT where product_width_cm is null

-- SO LAST 4 COLUMNS HAVE 2 NULL VALUES
-- AND 4 COLUMNS BEFORE THAT HAS 610 NULL VALUES 


SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS

ALTER TABLE PRODUCT 
ALTER COLUMN product_name_lenght INT

ALTER TABLE PRODUCT 
ALTER COLUMN product_description_lenght INT

ALTER TABLE PRODUCT 
ALTER COLUMN product_photos_qty INT

ALTER TABLE PRODUCT 
ALTER COLUMN product_weight_g INT

ALTER TABLE PRODUCT 
ALTER COLUMN product_length_cm INT

ALTER TABLE PRODUCT 
ALTER COLUMN product_height_cm INT

ALTER TABLE PRODUCT 
ALTER COLUMN product_width_cm INT






-- PAYMENT_TABLE

CREATE TABLE PAYMENT
(order_id VARCHAR(MAX), payment_sequential	VARCHAR(MAX), payment_type VARCHAR(MAX), payment_installments VARCHAR(MAX),	payment_value VARCHAR(MAX))

BULK INSERT PAYMENT
FROM 'C:\Users\HP\Downloads\payments_table.csv'
WITH (FIELDTERMINATOR= ',',
		ROWTERMINATOR='\n',
		firstrow=2)

select top 10 * from payment


 -- TO FIND OUT THE DUPLICATE RECORDS/ROWS FROM OUR DATA
SELECT COUNT(*) FROM PAYMENT
SELECT DISTINCT COUNT(*) FROM PAYMENT

--ITS THE SAME AS THE TOTAL NUMBER OF ROWS IN ORIGINAL DATA, HENCE NO DUPLICATES

select count(*), count(order_id),count(payment_sequential) ,count(payment_type) , count(payment_installments),
count(payment_value) from PAYMENT

-- THERE ARE NO NULL VALUES

SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS

SELECT DISTINCT payment_sequential FROM PAYMENT

ALTER TABLE PAYMENT
ALTER COLUMN PAYMENT_SEQUENTIAL INT

SELECT DISTINCT payment_type FROM PAYMENT

SELECT DISTINCT payment_installments FROM PAYMENT

SELECT DISTINCT payment_value FROM PAYMENT

ALTER TABLE PAYMENT
ALTER COLUMN PAYMENT_INSTALLMENTS INT

ALTER TABLE PAYMENT
ALTER COLUMN PAYMENT_VALUE FLOAT





--ORDERS_TABLE

CREATE TABLE ORDERS_TABLE
(order_id VARCHAR(MAX), customer_id VARCHAR(MAX),	order_status VARCHAR(MAX),	order_purchase_timestamp VARCHAR(MAX), order_approved_at VARCHAR(MAX),
order_delivered_carrier_date VARCHAR(MAX),	order_delivered_customer_date	VARCHAR(MAX), order_estimated_delivery_date VARCHAR(MAX))

BULK INSERT ORDERS_TABLE 
FROM 'C:\Users\HP\Downloads\orders_table.csv'
WITH (FIELDTERMINATOR= ',',
		ROWTERMINATOR='\n',
		firstrow=2)

SELECT top 10 * FROM ORDERS_TABLE

SELECT COUNT(*), COUNT(order_id), COUNT(customer_id),	COUNT(order_status),	COUNT(order_purchase_timestamp) , COUNT(order_approved_at),
COUNT( order_delivered_carrier_date),	COUNT(order_delivered_customer_date), COUNT(order_estimated_delivery_date) FROM ORDERS_TABLE


 -- TO FIND OUT THE DUPLICATE RECORDS/ROWS FROM OUR DATA
SELECT COUNT(*) FROM ORDERS_TABLE
SELECT DISTINCT COUNT(*) FROM ORDERS_TABLE

--ITS THE SAME AS THE TOTAL NUMBER OF ROWS IN ORIGINAL DATA, HENCE NO DUPLICATES

SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS

--Convert Empty Strings or Invalid Dates to NULL

UPDATE ORDERS_TABLE
SET order_approved_at = NULL
WHERE TRY_CAST(order_purchase_timestamp AS DATETIME) IS NULL

UPDATE ORDERS_TABLE
SET order_approved_at = NULL
WHERE TRY_CAST(order_approved_at AS DATETIME) IS NULL

UPDATE ORDERS_TABLE
SET order_delivered_carrier_date = NULL
WHERE TRY_CAST(order_delivered_carrier_date AS DATETIME) IS NULL

UPDATE ORDERS_TABLE
SET order_delivered_customer_date = NULL
WHERE TRY_CAST(order_delivered_customer_date AS DATETIME) IS NULL

UPDATE ORDERS_TABLE
SET order_delivered_customer_date = NULL
WHERE TRY_CAST(order_estimated_delivery_date AS DATETIME) IS NULL

--Cast All Dates to DATE Format

ALTER TABLE ORDERS_TABLE
ALTER COLUMN order_purchase_timestamp DATE

ALTER TABLE ORDERS_TABLE
ALTER COLUMN order_approved_at DATE

ALTER TABLE ORDERS_TABLE
ALTER COLUMN order_delivered_carrier_date DATE

ALTER TABLE ORDERS_TABLE
ALTER COLUMN order_delivered_customer_date DATE

ALTER TABLE ORDERS_TABLE
ALTER COLUMN order_estimated_delivery_date DATE

SELECT top 10 * FROM ORDERS_TABLE

SELECT DISTINCT ORDER_STATUS FROM ORDERS_TABLE

SELECT * FROM orders_TABLE WHERE order_purchase_timestamp IS NULL -- NO NULL VALUES

SELECT * FROM orders_TABLE WHERE order_approved_at IS NULL --160 NULL VALUES

SELECT * FROM orders_TABLE WHERE order_delivered_carrier_date IS NULL --1783 NULL VALUES

SELECT * FROM orders_TABLE WHERE order_delivered_customer_date IS NULL --2965 NULL VALUES

SELECT * FROM orders_TABLE WHERE order_estimated_delivery_date IS NULL --NO NULL VALUE





--TABLE ORDER_ITEMS

CREATE TABLE ORDER_ITEMS
(order_id  VARCHAR(MAX),	order_item_id VARCHAR(MAX),	product_id	VARCHAR(MAX), seller_id VARCHAR(MAX),	shipping_limit_date VARCHAR(MAX),	price	VARCHAR(MAX),freight_value VARCHAR(MAX))

BULK INSERT ORDER_ITEMS
FROM 'C:\Users\HP\Downloads\order_items_table.csv'
 WITH (FIELDTERMINATOR= ',',
		ROWTERMINATOR='\n',
		firstrow=2)

select top 10 * from ORDER_ITEMS

 -- TO FIND OUT THE DUPLICATE RECORDS/ROWS FROM OUR DATA
SELECT COUNT(*) FROM ORDER_ITEMS
SELECT DISTINCT COUNT(*) FROM ORDER_ITEMS

--ITS THE SAME AS THE TOTAL NUMBER OF ROWS IN ORIGINAL DATA, HENCE NO DUPLICATES

SELECT COUNT(*), COUNT(order_id), COUNT(order_item_id),	COUNT(product_id),	COUNT(seller_id) , COUNT(shipping_limit_date),
COUNT( price),	COUNT(freight_value) FROM ORDER_ITEMS

--THERE ARE NO NULL VALUES

SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS

SELECT DISTINCT order_item_id FROM ORDER_ITEMS

ALTER TABLE ORDER_ITEMS
ALTER COLUMN order_item_id INT

UPDATE ORDER_ITEMS
SET shipping_limit_date = NULL
WHERE TRY_CAST(shipping_limit_date AS DATETIME) IS NULL

ALTER TABLE ORDER_ITEMS
ALTER COLUMN shipping_limit_date DATE

ALTER TABLE ORDER_ITEMS
ALTER COLUMN PRICE MONEY

ALTER TABLE ORDER_ITEMS
ALTER COLUMN freight_value MONEY






--CUSTOMER

CREATE TABLE CUSTOMER
(customer_id VARCHAR(MAX),	customer_unique_id VARCHAR(MAX), customer_zip_code_prefix VARCHAR(MAX),	
customer_city VARCHAR(MAX),	customer_state VARCHAR(MAX))

BULK INSERT CUSTOMER
FROM 'C:\Users\HP\Downloads\Customers_table.csv'
 WITH (FIELDTERMINATOR= ',',
		ROWTERMINATOR='\n',
		firstrow=2)

select top 10 * from CUSTOMER

 -- TO FIND OUT THE DUPLICATE RECORDS/ROWS FROM OUR DATA
SELECT COUNT(*) FROM CUSTOMER
SELECT DISTINCT COUNT(*) FROM CUSTOMER

--ITS THE SAME AS THE TOTAL NUMBER OF ROWS IN ORIGINAL DATA, HENCE NO DUPLICATES

SELECT COUNT(*), COUNT(customer_id), COUNT(customer_unique_id),	COUNT(customer_zip_code_prefix), COUNT(customer_city), 
COUNT(customer_state)  FROM CUSTOMER

--THERE ARE NO NULL VALUES

SELECT DISTINCT customer_city FROM CUSTOMER

SELECT DISTINCT customer_zip_code_prefix FROM CUSTOMER

ALTER TABLE CUSTOMER
ALTER COLUMN customer_zip_code_prefix INT

SELECT DISTINCT customer_state FROM CUSTOMER







-- CUSTOMER_REVIEW

CREATE TABLE CUSTOMER_REVIEW
(review_id VARCHAR(MAX), order_id VARCHAR(MAX),	review_score VARCHAR(MAX),
review_creation_date VARCHAR(MAX),	review_answer_timestamp VARCHAR(MAX))

BULK INSERT CUSTOMER_REVIEW
FROM 'C:\Users\HP\Downloads\Customers_review_table.csv'
 WITH (FIELDTERMINATOR= ',',
		ROWTERMINATOR='\n',
		firstrow=2)

SELECT TOP 10 * FROM CUSTOMER_REVIEW

-- TO FIND OUT THE DUPLICATE RECORDS/ROWS FROM OUR DATA
SELECT COUNT(*) FROM CUSTOMER_REVIEW
SELECT DISTINCT COUNT(*) FROM CUSTOMER_REVIEW

--ITS THE SAME AS THE TOTAL NUMBER OF ROWS IN ORIGINAL DATA, HENCE NO DUPLICATES

SELECT COUNT(*), COUNT(review_id), COUNT(order_id),	COUNT(review_score), COUNT(review_creation_date), 
COUNT(review_answer_timestamp)  FROM CUSTOMER_REVIEW

--THERE ARE NO NULL VALUES

SELECT DISTINCT REVIEW_SCORE FROM CUSTOMER_REVIEW

ALTER TABLE CUSTOMER_REVIEW
ALTER COLUMN REVIEW_SCORE INT

UPDATE CUSTOMER_REVIEW
SET REVIEW_CREATION_DATE = NULL
WHERE TRY_CAST(REVIEW_CREATION_DATE AS DATETIME) IS NULL

ALTER TABLE CUSTOMER_REVIEW
ALTER COLUMN REVIEW_CREATION_DATE DATE 

UPDATE CUSTOMER_REVIEW
SET REVIEW_ANSWER_TIMESTAMP = NULL
WHERE TRY_CAST(REVIEW_ANSWER_TIMESTAMP AS DATETIME) IS NULL

ALTER TABLE CUSTOMER_REVIEW
ALTER COLUMN REVIEW_ANSWER_TIMESTAMP DATE 

SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS

-- NOW ALL THE COLUMNS HAVE BEEN CAST TO APROPRTIATE DATATYPE




SELECT COUNT(*) AS SELLER FROM SELLER
SELECT COUNT(*) AS PRODUCT FROM PRODUCT
SELECT COUNT(*) AS PAYMENT FROM PAYMENT
SELECT COUNT(*) AS ORDERS FROM ORDERS_TABLE
SELECT COUNT(*) AS OR_ITEMS FROM ORDER_ITEMS
SELECT COUNT(*) AS CUST FROM CUSTOMER
SELECT COUNT(*) AS CUST_REV FROM CUSTOMER_REVIEW


SELECT TOP 1 * FROM SELLER
SELECT TOP 1 * FROM PRODUCT
SELECT TOP 1 * FROM PAYMENT
SELECT TOP 1 * FROM ORDERS_TABLE
SELECT TOP 1 * FROM ORDER_ITEMS
SELECT TOP 1 * FROM CUSTOMER
SELECT TOP 1 * FROM CUSTOMER_REVIEW


select distinct payment_type from payment 


-- Q1-- How much total money has the platform made so far, and how has it changed over time?


-- the money comes to company's account if its having status as following-- approved, delivered , invoiced,  shipped
-- and not if its -- created, processing, unavailable, canceled

select distinct order_status from Orders_table 

select distinct order_item_id from Order_items

-- How much total money has the platform made so far -- we use ORDER_ITEMS table 

-- Tying to understand the difference between payment_value of PAYMENT table and price of ORDER_ITEMS table
SELECT * FROM ORDER_ITEMS WHERE order_id= 'b81ef226f3fe1789b1e8b2acac839d17'
-- b81ef226f3fe1789b1e8b2acac839d17	1	af74cc53dcffc8384b29e7abfa41902b	213b25e6f54661939f11710a6fddb871	2018-05-02	79.80	19.53
-- So payment_value means is price + freight_value

select sum(price) as Total_revenue from ORDER_ITEMS

-- How has it changed over time?

-- Year-on-Year formula = ((This year - previous year)/ previous year)*100

select distinct year(shipping_limit_date) as Year, 
sum(price) as Earning_Yearwise,
LAG(SUM(price)) OVER (ORDER BY YEAR(shipping_limit_date)) AS PreviousYearRevenue,
concat( round(100*(sum(price) - LAG(SUM(price)) OVER (ORDER BY YEAR(shipping_limit_date)))/ LAG(SUM(price)) OVER (ORDER BY YEAR(shipping_limit_date)),2), ' %') as YoY
from ORDER_ITEMS
group by year(shipping_limit_date)
order by year(shipping_limit_date) desc



-- Q2 -- Which product categories are the most popular?

select top 5 product_category_name, count(order_item_id) as count_of_products
from PRODUCT P join Order_items O
on P.product_id=O.product_id
group by product_category_name
order by count(order_item_id) desc




-- Q3-- What is the average amount spent per order, and how does it change depending on the product category or payment method?

-- Avg amount spent per order
SELECT ORDER_ID, AVG(PRICE) AS AVG_PRICE
FROM ORDER_ITEMS
GROUP BY ORDER_ID
ORDER BY AVG(PRICE) DESC

-- AVG AMOUNT PER PRODUCT CATEGORY
SELECT PRODUCT_CATEGORY_NAME, AVG(PRICE) AS AVG_AMT
FROM PRODUCT PD
JOIN ORDER_ITEMS O
ON PD.product_id=O.product_id
GROUP BY PRODUCT_CATEGORY_NAME
ORDER BY AVG(PRICE) DESC

-- AVG AMOUNT PER PAYMENT METHOD
SELECT payment_type, AVG(PRICE) AS AVG_AMT
FROM PAYMENT P
JOIN ORDER_ITEMS O
ON P.order_id=O.order_id
GROUP BY payment_type
ORDER BY AVG(PRICE) DESC

-- BASED ON PER PAYMENT METHOD PER ORDER
SELECT O.order_id ,payment_type, AVG(PRICE) AS AVG_AMT
FROM PAYMENT P
JOIN ORDER_ITEMS O
ON P.order_id=O.order_id
GROUP BY payment_type, O.order_id




--Q4 -- How many active sellers are there on the platform, and does this number go up or down over time?


SELECT TOP 1 * FROM SELLER
SELECT TOP 1 * FROM PRODUCT
SELECT TOP 1 * FROM PAYMENT
SELECT TOP 1 * FROM ORDERS_TABLE
SELECT TOP 1 * FROM ORDER_ITEMS
SELECT TOP 1 * FROM CUSTOMER
SELECT TOP 1 * FROM CUSTOMER_REVIEW

SELECT * FROM SELLER

-- The active sellers since 2018
select seller_id, max(shipping_limit_date) from ORDER_ITEMS
group by seller_id
having year(max(shipping_limit_date))>=2018


-- The active sellers in 2019 -- Its 0 -- Maybe the platform had a complete downfall as there was no activity
select seller_id, max(shipping_limit_date) from ORDER_ITEMS
group by seller_id
having year(max(shipping_limit_date))=2019

-- The active sellers since 2020 -- Its just 1 -- Platform might be trying to revive
select seller_id, max(shipping_limit_date) from ORDER_ITEMS
group by seller_id
having year(max(shipping_limit_date))>=2020



-- Does this number go up or down over time?


--tracking number of seller each year
select year(shipping_limit_date) as Year, count(seller_id) as No_of_seller from ORDER_ITEMS
group by year(shipping_limit_date)
order by year(shipping_limit_date)

--tracking the sales of distinct seller
select year(shipping_limit_date) as Year, count(distinct seller_id) as Distinct_No_of_seller from ORDER_ITEMS
group by year(shipping_limit_date)
order by year(shipping_limit_date)

-- we had seen an upward trend in overall seller activity and distinct seller activity on the platform, untill 2018
-- there was no activity in 2019 at all
-- there was one activity in  2020, maybe the platorm is trying to revive its business and shows positive sign 




-- Q5 -- Which products sell the most, and how have their sales changed over time?

SELECT TOP 1 * FROM SELLER
SELECT TOP 1 * FROM PRODUCT
SELECT TOP 1 * FROM PAYMENT
SELECT TOP 1 * FROM ORDERS_TABLE
SELECT TOP 1 * FROM ORDER_ITEMS
SELECT TOP 1 * FROM CUSTOMER
SELECT TOP 1 * FROM CUSTOMER_REVIEW

-- We do not have the product name, we have categories (whose analysis is already done in Q2)
-- We can do the analysis using the product_id

-- The following are the top 10 selling product
SELECT TOP 10 PRODUCT_ID, COUNT(product_id) AS Number_of_Orders
FROM ORDER_ITEMS
GROUP BY product_id
ORDER BY COUNT(product_id) DESC

-- the money comes to company's account if its having status as following-- approved, delivered , invoiced,  shipped
-- and not if its -- created, processing, unavailable, canceled


SELECT YEAR(order_purchase_timestamp) as YEAR, COUNT(PRODUCT_ID) as COUNT_OF_PRODUCT
FROM Orders_table T
LEFT JOIN 
ORDER_ITEMS I
ON T.order_id=I.order_id
WHERE order_status NOT IN ('created','processing','unavailable','canceled')
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY YEAR(order_purchase_timestamp) DESC
-- We see the number of orders have been increasing over each year





-- Q6 -- Do customer reviews and ratings help products sell more or perform better on the platform? 
-- (Check sales with higher or lower ratings and identify if any correlation is there)

SELECT TOP 1 * FROM SELLER
SELECT TOP 1 * FROM PRODUCT
SELECT TOP 1 * FROM PAYMENT
SELECT TOP 1 * FROM ORDERS_TABLE
SELECT TOP 1 * FROM ORDER_ITEMS
SELECT TOP 1 * FROM CUSTOMER
SELECT TOP 1 * FROM CUSTOMER_REVIEW


SELECT distinct review_score FROM CUSTOMER_REVIEW

-- Volume of Sales changing based on ratings 

SELECT review_score, CAST(SUM(PRICE) AS INT) as Total_Revenue
FROM CUSTOMER_REVIEW C
JOIN ORDER_ITEMS O
ON C.order_id=O.order_id
GROUP BY review_score
ORDER BY review_score DESC

select review_score, count(product_id) as Number_of_products
from CUSTOMER_REVIEW C
left join ORDER_ITEMS O
on C.order_id=O.order_id
group by review_score
order by review_score desc

-- We see an upward trend in number of products ordered as the ratings go high, except for when the rating is 1. 




-- Q7 --Understand the contribution of loyal (repeat) customers vs. one-time buyers to sales

SELECT SUM(PRICE) FROM ORDER_ITEMS

--LOYAL CUSTOMER CONTRIBUTION
WITH LOYAL AS (SELECT T.CUSTOMER_ID, COUNT(T.CUSTOMER_ID) AS RATE, SUM(PRICE) AS TOTAL_PRICE
FROM Orders_table T
JOIN ORDER_ITEMS I
ON T.order_id = I.order_id
GROUP BY T.customer_id)
SELECT SUM(TOTAL_PRICE) AS LOYAL_CUSTOMER FROM LOYAL WHERE RATE>1 
-- 2005862.42

--ONE_TIME CUSTOMER CONTRIBUTION
WITH ONE_TIME AS (SELECT T.CUSTOMER_ID, COUNT(T.CUSTOMER_ID) AS RATE, SUM(PRICE) AS TOTAL_PRICE
FROM Orders_table T
JOIN ORDER_ITEMS I
ON T.order_id = I.order_id
GROUP BY T.customer_id)
SELECT SUM(TOTAL_PRICE) AS SINGLE_USER FROM ONE_TIME WHERE RATE=1
-- 11585781.28


-- Q8 --Top Seller State and Top Customer State in terms of Volume of Sales and Count of Order

select distinct seller_state from SELLER

SELECT TOP 1 * FROM SELLER
SELECT TOP 1 * FROM PRODUCT
SELECT TOP 1 * FROM PAYMENT
SELECT TOP 1 * FROM ORDERS_TABLE
SELECT TOP 1 * FROM ORDER_ITEMS
SELECT TOP 1 * FROM CUSTOMER
SELECT TOP 1 * FROM CUSTOMER_REVIEW

--Top Seller State in terms of Volume of Sales 
SELECT TOP 5 SELLER_STATE, SUM(PRICE) AS SUM_SALES
FROM SELLER S
LEFT JOIN ORDER_ITEMS O
ON S.seller_id=O.seller_id
GROUP BY SELLER_STATE
ORDER BY SUM(PRICE) DESC


--Top Seller State in terms of Count of Order
SELECT TOP 5 SELLER_STATE, COUNT(ORDER_ID) AS COUNT_ORDER
FROM SELLER S
LEFT JOIN ORDER_ITEMS O
ON S.seller_id=O.seller_id
GROUP BY SELLER_STATE
ORDER BY COUNT(ORDER_ID) DESC



select distinct customer_state from CUSTOMER

--Top Customer State in terms of Volume of Sales
SELECT TOP 5 CUSTOMER_STATE, SUM(PRICE) AS SUM_SALES
FROM CUSTOMER C
LEFT JOIN ORDERS_TABLE O
ON C.customer_id=O.customer_id
JOIN ORDER_ITEMS OT
ON O.order_id=OT.order_id
GROUP BY CUSTOMER_STATE
ORDER BY SUM(PRICE) DESC

--Top Customer State in terms of Count of Order
SELECT TOP 5 CUSTOMER_STATE, COUNT(ORDER_ID) AS COUNT_ORDER
FROM CUSTOMER C
LEFT JOIN ORDERS_TABLE O
ON C.customer_id=O.customer_id
GROUP BY CUSTOMER_STATE
ORDER BY COUNT(ORDER_ID) DESC