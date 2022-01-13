-- Chapter 8, Exercise 1
--
-- Get the customer_id, month, and year (in seperate columns) of
-- every purchase in the farmers_market.customer_purchases table

SELECT customer_id,
	EXTRACT(MONTH FROM market_date) as market_month,
    EXTRACT(YEAR FROM market_date) as market_year
FROM farmers_market.customer_purchases;