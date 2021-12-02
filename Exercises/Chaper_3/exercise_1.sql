-- Chapter 3, Exercise 1
--
-- Refer to the data in Table 3.1. 
-- Write a query that returns all customer purchases of product IDs 4 and 9.

SELECT * FROM farmers_market.customer_purchases WHERE product_id IN ('4', '9');