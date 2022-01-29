-- Chapter 9, Exercise 1
--
-- In this chapter, it was suggested that we should see if the 
-- customer_purchases data was collected for the same time frame as the
-- vendor_inventory table. Write a query that gets the earliest
-- and latest dates in the customer_purchases table 

SELECT min(market_date) as earliest_date,
	max(market_date) as latest_date
FROM customer_purchases;

-- But let's answer the original question!

SELECT "customer_purchases",
	min(market_date) as earliest_date,
	max(market_date) as latest_date
FROM customer_purchases
UNION
SELECT "vendor_inventory",
	min(market_date) as earliest_date,
	max(market_date) as latest_date
FROM vendor_inventory vi;