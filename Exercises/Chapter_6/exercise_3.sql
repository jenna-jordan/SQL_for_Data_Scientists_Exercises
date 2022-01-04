-- Chapter 6, Exercise 3
--
-- The Farmer's Market Customer Appreciation Committee wants to give a bumper sticker to
-- everyone who has ever spent more than $50 at the market.
-- Write a query that generates a list of customers for them to give stickers to,
-- sorted by last name, then first name.
-- HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword.

SELECT c.customer_first_name, c.customer_last_name, cp.customer_id, sum(cp.quantity * cp.cost_to_customer_per_qty) as total_spend
FROM farmers_market.customer_purchases cp
	LEFT JOIN farmers_market.customer c on cp.customer_id = c.customer_id
GROUP BY cp.customer_id
HAVING total_spend > 50
ORDER BY c.customer_last_name, c.customer_first_name;