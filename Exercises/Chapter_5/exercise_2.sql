-- Chapter 5, Exercise 2
--
-- Is it possible to write query that produces an output identical to the output of the following query,
-- but using a LEFFT JOIN instead of a RIGHT JOIN?

-- Original query:

SELECT *
FROM farmers_market.customer AS c
	RIGHT JOIN farmers_market.customer_purchases AS cp ON c.customer_id = cp.customer_id;
    
-- Revised query:

SELECT *
FROM farmers_market.customer_purchases AS cp
	LEFT JOIN farmers_market.customer AS c ON c.customer_id = cp.customer_id;