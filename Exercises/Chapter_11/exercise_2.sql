/*
Chapter 11, Exercise 2

Modify the "New vs Returning Customers Per Week" report
(associated with Figure 11.8) to summarize the
counts by vendor by week
*/

-- Original Query 

WITH customer_markets_attended AS 
(
SELECT DISTINCT customer_id, market_date, 
	MIN(market_date) OVER (PARTITION BY cp.customer_id) AS first_purchase_date
FROM farmers_market.customer_purchases cp 
)

SELECT 
	md.market_year,
	md.market_week,
	COUNT(customer_id) AS customer_visit_count,
	COUNT(DISTINCT customer_id) AS distinct_customer_count,
	COUNT(DISTINCT 
		CASE WHEN cma.market_date = cma.first_purchase_date 
		THEN customer_id 
		ELSE NULL
	END) as new_customer_count,
	COUNT(DISTINCT 
		CASE WHEN cma.market_date = cma.first_purchase_date 
		THEN customer_id 
		ELSE NULL
	END) / COUNT(DISTINCT customer_id) as new_customer_percent
FROM customer_markets_attended as cma 
	LEFT JOIN farmers_market.market_date_info as md 
		ON cma.market_date = md.market_date 
GROUP BY md.market_year, md.market_week 
ORDER BY md.market_year, md.market_week;

-- Modified Query

WITH customer_vendors_attended AS 
(
SELECT DISTINCT customer_id, market_date, vendor_id,
	MIN(market_date) OVER (PARTITION BY cp.customer_id, cp.vendor_id) AS first_purchase_date
FROM farmers_market.customer_purchases cp 
)

SELECT 
	md.market_year,
	md.market_week,
	vendor_id,
	COUNT(customer_id) AS customer_visit_count,
	COUNT(DISTINCT customer_id) AS distinct_customer_count,
	COUNT(DISTINCT 
		CASE WHEN cva.market_date = cva.first_purchase_date 
		THEN customer_id 
		ELSE NULL
	END) as new_customer_count,
	COUNT(DISTINCT 
		CASE WHEN cva.market_date = cva.first_purchase_date 
		THEN customer_id 
		ELSE NULL
	END) / COUNT(DISTINCT customer_id) as new_customer_percent
FROM customer_vendors_attended as cva 
	LEFT JOIN farmers_market.market_date_info as md 
		ON cva.market_date = md.market_date 
GROUP BY md.market_year, md.market_week, vendor_id
ORDER BY md.market_year, md.market_week, vendor_id;
