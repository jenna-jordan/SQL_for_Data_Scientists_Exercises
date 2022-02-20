/*
Chapter 12, Exercise 2

Add a column to the final query in the chapter that 
contains a 1 if the customer purchased an item that cost over $10,
and a 0 if not.
HINT: the calculation will follow the same form as the purchased_from_vendor_x flags
*/

-- The original final query
/*
WITH customer_markets_attended AS 
(
	SELECT
		customer_id,
		market_date,
		ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS market_count
	FROM farmers_market.customer_purchases
	GROUP BY customer_id, market_date 
	ORDER BY customer_id, market_date 
)

SELECT  
	cp.customer_id,
	cp.market_date,
	EXTRACT(MONTH FROM cp.market_date) as market_month,
	SUM(cp.quantity * cp.cost_to_customer_per_qty) AS purchase_total,
	COUNT(DISTINCT cp.vendor_id) AS vendors_patronized,
	MAX(CASE WHEN cp.vendor_id = 7 THEN 1 ELSE 0 END) AS purchased_from_vendor_7,
	MAX(CASE WHEN cp.vendor_id = 8 THEN 1 ELSE 0 END) AS purchased_from_vendor_8,
	COUNT(DISTINCT cp.product_id) AS different_products_purchased,
	DATEDIFF(cp.market_date, 
		(SELECT MAX(cma.market_date)
		FROM customer_markets_attended AS cma
		WHERE cma.customer_id = cp.customer_id
			AND cma.market_date < cp.market_date 
		GROUP BY cma.customer_id)
		) AS days_since_last_customer_market_date,
	(SELECT MAX(market_count)
		FROM customer_markets_attended AS cma
		WHERE cma.customer_id = cp.customer_id
			AND cma.market_date <= cp.market_date
		) AS customer_markets_attended_count,
	(SELECT COUNT(market_date)
		FROM customer_markets_attended as cma
		WHERE cma.customer_id = cp.customer_id 
			AND cma.market_date < cp.market_date
			AND DATEDIFF(cp.market_date, cma.market_date) <= 30
		) AS customer_markets_attended_30days_count,
	CASE WHEN 
		DATEDIFF(
			(SELECT MIN(cma.market_date)
			FROM customer_markets_attended AS cma 
			WHERE cma.customer_id = cp.customer_id 
				AND cma.market_date > cp.market_date
			GROUP BY cma.customer_id),
			cp.market_date
		) <= 30
		THEN 1
		ELSE 0
		END AS purchased_again_within_30_days
FROM farmers_market.customer_purchases cp 
GROUP BY cp.customer_id, cp.market_date 
ORDER BY cp.customer_id, cp.market_date;
*/
-- Now we add the column

WITH customer_markets_attended AS 
(
	SELECT
		customer_id,
		market_date,
		ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS market_count
	FROM farmers_market.customer_purchases
	GROUP BY customer_id, market_date 
	ORDER BY customer_id, market_date 
)

SELECT  
	cp.customer_id,
	cp.market_date,
	EXTRACT(MONTH FROM cp.market_date) as market_month,
	SUM(cp.quantity * cp.cost_to_customer_per_qty) AS purchase_total,
	COUNT(DISTINCT cp.vendor_id) AS vendors_patronized,
	MAX(CASE WHEN cp.vendor_id = 7 THEN 1 ELSE 0 END) AS purchased_from_vendor_7,
	MAX(CASE WHEN cp.vendor_id = 8 THEN 1 ELSE 0 END) AS purchased_from_vendor_8,
	MAX(CASE WHEN cp.quantity * cp.cost_to_customer_per_qty > 10 THEN 1 ELSE 0 END) 
		AS purchased_item_over_10d, -- this is the added column
	COUNT(DISTINCT cp.product_id) AS different_products_purchased,
	DATEDIFF(cp.market_date, 
		(SELECT MAX(cma.market_date)
		FROM customer_markets_attended AS cma
		WHERE cma.customer_id = cp.customer_id
			AND cma.market_date < cp.market_date 
		GROUP BY cma.customer_id)
		) AS days_since_last_customer_market_date,
	(SELECT MAX(market_count)
		FROM customer_markets_attended AS cma
		WHERE cma.customer_id = cp.customer_id
			AND cma.market_date <= cp.market_date
		) AS customer_markets_attended_count,
	(SELECT COUNT(market_date)
		FROM customer_markets_attended as cma
		WHERE cma.customer_id = cp.customer_id 
			AND cma.market_date < cp.market_date
			AND DATEDIFF(cp.market_date, cma.market_date) <= 30
		) AS customer_markets_attended_30days_count,
	CASE WHEN 
		DATEDIFF(
			(SELECT MIN(cma.market_date)
			FROM customer_markets_attended AS cma 
			WHERE cma.customer_id = cp.customer_id 
				AND cma.market_date > cp.market_date
			GROUP BY cma.customer_id),
			cp.market_date
		) <= 30
		THEN 1
		ELSE 0
		END AS purchased_again_within_30_days
FROM farmers_market.customer_purchases cp 
GROUP BY cp.customer_id, cp.market_date 
ORDER BY cp.customer_id, cp.market_date;