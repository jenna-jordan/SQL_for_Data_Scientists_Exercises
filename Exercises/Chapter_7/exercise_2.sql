-- Chapter 7, Exercise 2
--
-- Using a COUNT() window function, include a value along with each row of the
-- customer_purchases table that indicates how many different times that customer
-- has purchase that product_id

SELECT *,
	COUNT(cp.product_id) OVER (PARTITION BY cp.customer_id, cp.product_id) as purchase_count
FROM farmers_market.customer_purchases as cp;
