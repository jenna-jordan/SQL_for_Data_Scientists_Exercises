-- Chapter 11, Exercise 1
--
-- Starting with the query associated with Figure 11.5, 
-- put the larger SELECT statement in a second CTE,
-- and write a query that queries from its results to 
-- display the current record sales and associated market date.
-- Can you think of another way to generate the same results? 

-- Original Query

WITH sales_per_market_date AS 
(
SELECT market_date, ROUND(SUM(quantity * cost_to_customer_per_qty), 2) AS sales 
FROM farmers_market.customer_purchases
GROUP BY market_date 
ORDER BY market_date 
)

SELECT
	cm.market_date,
	cm.sales,
	MAX(pm.sales) AS previous_max_sales,
	CASE
		WHEN cm.sales > MAX(pm.sales)
		THEN "YES"
		ELSE "NO"
	END sales_record_set
FROM
	sales_per_market_date as cm
LEFT JOIN sales_per_market_date as pm 
		ON
	pm.market_date < cm.market_date
GROUP BY
	cm.market_date,
	cm.sales;

-- Modified Query

WITH sales_per_market_date AS 
(
SELECT market_date, ROUND(SUM(quantity * cost_to_customer_per_qty), 2) AS sales 
FROM farmers_market.customer_purchases
GROUP BY market_date 
ORDER BY market_date 
),

record_sales_per_market_date AS
(
SELECT
	cm.market_date,
	cm.sales,
	MAX(pm.sales) AS previous_max_sales,
	CASE
		WHEN cm.sales > MAX(pm.sales)
		THEN "YES"
		ELSE "NO"
	END sales_record_set
FROM
	sales_per_market_date as cm
LEFT JOIN sales_per_market_date as pm 
		ON
	pm.market_date < cm.market_date
GROUP BY
	cm.market_date,
	cm.sales
)

-- first option
SELECT *
FROM record_sales_per_market_date
WHERE sales_record_set = "YES"
ORDER BY market_date DESC 
LIMIT 1;

-- second option 



