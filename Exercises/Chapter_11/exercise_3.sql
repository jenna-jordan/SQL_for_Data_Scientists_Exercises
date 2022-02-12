/*
Chapter 11, Exercise 3

Using a UNION, write a query that displays the market dates
with the highest and lowest total sales
*/

WITH sales_per_market_date AS 
(
SELECT market_date, ROUND(SUM(quantity * cost_to_customer_per_qty), 2) AS sales 
FROM farmers_market.customer_purchases
GROUP BY market_date 
ORDER BY market_date 
)

SELECT *, "Highest" as Record
FROM sales_per_market_date
WHERE sales = (SELECT max(sales) FROM sales_per_market_date)
UNION
SELECT *, "Lowest" as Record
FROM sales_per_market_date
WHERE sales = (SELECT min(sales) FROM sales_per_market_date);