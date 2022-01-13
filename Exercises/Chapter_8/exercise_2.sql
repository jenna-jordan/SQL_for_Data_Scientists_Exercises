-- Chapter 8, Exercise 2
--
-- Write the query that filters to purchases made in the past 2 weeks,
-- returns the earliest market_date in that range as a field called sales_since_date,
-- and a sum of the sales (quantity * cost_to_customer_per_qty)
-- during that date range
-- Your final answer should use the CURDATE() function, but if you want to test
-- it out on the farmer's market database, you can replace your CURDATE() with the
-- value '2020-03-31'* to get the report for the two weeks prior to March 31, 2019
-- (otherwise your query will not return any data, because none of the dates in the
-- database will have occurred within two weeks of you writing the query)
-- * Textbook specified '2019-03-31', but there are no entries prior to that date,
-- so I'm changing it to 2020.

-- Version with '2020-03-31'

SELECT MIN(market_date) AS sales_since_date, 
	SUM(quantity * cost_to_customer_per_qty) AS total_sales_amount
FROM farmers_market.customer_purchases
WHERE market_date <= '2020-03-31' 
	AND market_date >= DATE_SUB('2020-03-31', INTERVAL 2 WEEK)
ORDER BY market_date desc;

-- Version with CURDATE()

SELECT MIN(market_date) AS sales_since_date, 
	SUM(quantity * cost_to_customer_per_qty) AS total_sales_amount
FROM farmers_market.customer_purchases
WHERE market_date >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK)
ORDER BY market_date desc;