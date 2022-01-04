-- Chapter 7, Exercise 3
--
-- In the last query associated with Figure 7.14 from the chapter,
-- we used LAG and sorted by market_date. Can you think of a way to 
-- use LEAD in place of LAG, but get the exact same output

-- ORIGINAL QUERY

SELECT
	market_date,
    SUM(quantity * cost_to_customer_per_qty) as market_date_total_sales,
    LAG(SUM(quantity * cost_to_customer_per_qty), 1) OVER 
		(ORDER BY market_date) as previous_market_date_total_sales
FROM farmers_market.customer_purchases
GROUP BY market_date
ORDER BY market_date;

-- with LEAD

SELECT
	market_date,
    SUM(quantity * cost_to_customer_per_qty) as market_date_total_sales,
    LEAD(SUM(quantity * cost_to_customer_per_qty), 1) OVER 
		(ORDER BY market_date DESC) as previous_market_date_total_sales
FROM farmers_market.customer_purchases
GROUP BY market_date
ORDER BY market_date;