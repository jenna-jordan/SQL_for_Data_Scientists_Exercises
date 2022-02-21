/*
Chapter 12, Exercise 3

Let's say that the farmer's market started a customer reward program
that gave customers a market goods gift basket and branded reusable
market bag when they had spent at least $200 total.
Create a flag field (with a 1 or 0) that indicates whether the customer
has received this loyal customer status.
HINT: One way to accomplish this involves modifying the CTE
to include purchase totals, and adding a column to the
main query with a similar struture to the one that calculates 
customer_markets_attended_count, to calculate a running total spent.
*/

-- Approach 1: modifying the final ML dataset

WITH customer_markets_attended AS 
(
	SELECT
		customer_id,
		market_date,
		ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS market_count,
		SUM(cost_to_customer_per_qty * quantity) AS total_spent -- added column to CTE
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
	(SELECT SUM(total_spent) -- new column in main query for running total
		FROM customer_markets_attended AS cma
		WHERE cma.customer_id = cp.customer_id
			AND cma.market_date <= cp.market_date
		) AS customer_running_total_spent,
	CASE WHEN
		(SELECT SUM(total_spent) -- new column in main query for $200 flag
		FROM customer_markets_attended AS cma
		WHERE cma.customer_id = cp.customer_id
			AND cma.market_date <= cp.market_date
		) >= 200
		THEN 1
		ELSE 0
		END AS is_loyal_customer,
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


-- Approach 2: just get the loyalty info

WITH customer_running_totals AS (
SELECT
	customer_id,
	market_date,
	ROW_NUMBER() 
		OVER (PARTITION BY customer_id ORDER BY market_date) AS market_count,
	SUM(SUM(cost_to_customer_per_qty * quantity)) 
		OVER (PARTITION BY customer_id ORDER BY market_date) AS running_total
FROM farmers_market.customer_purchases
GROUP BY customer_id, market_date
ORDER BY customer_id, market_date)

SELECT *,
	CASE WHEN running_total > 200 THEN 1 ELSE 0 END AS spent_over_200
FROM customer_running_totals;