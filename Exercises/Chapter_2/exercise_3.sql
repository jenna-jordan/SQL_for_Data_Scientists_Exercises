-- Chapter 2, Exercise 3
--
-- Write a query that lists all customer IDs and first names in the customer table, sorted by first_name

SELECT customer_id, customer_first_name FROM farmers_market.customer ORDER BY customer_first_name;