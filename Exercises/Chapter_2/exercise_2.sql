-- Chapter 2, Exercise 2
--
-- Write a query that displays all of the columns and 10 rows from the customer table, 
-- sorted by customer_last_name, then customer_first_name.

SELECT * FROM farmers_market.customer ORDER BY customer_last_name, customer_first_name LIMIT 10;