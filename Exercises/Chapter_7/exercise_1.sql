-- Chapter 7, Exercise 1
--
-- Part 1
-- Write a query that selects from the customer_purchases table and numbers
-- each customer's visits to the farmer's market (labeling each market date with a
-- different number). Each customer's 1st visit is labeled 1, 2nd visit is labeled 2, etc.
-- (We are of course not counting visits where no purchases are made, because we
-- have no record of those.) You can either display all rows in the customer_purchases
-- table, with the counter changing on each new market date for each customer,
-- or select only the unique market dates per customer (without purchase details)
-- and number those visits
-- HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK()

-- Approach 1 - ROW_NUMBER()

SELECT cp.customer_id, cp.market_date,
	ROW_NUMBER() OVER (PARTITION BY cp.customer_id ORDER BY cp.market_date ASC) AS customer_visit
FROM farmers_market.customer_purchases as cp
GROUP BY cp.customer_id, cp.market_date
ORDER BY cp.customer_id, cp.market_date;

-- Approach 2 - DENSE_RANK()

SELECT DISTINCT cp.customer_id, cp.market_date,
	DENSE_RANK() OVER (PARTITION BY cp.customer_id ORDER BY cp.market_date ASC) AS customer_visit
FROM farmers_market.customer_purchases as cp
ORDER BY cp.customer_id, cp.market_date;

-- Part 2
-- Reverse the numbering of the query from part 1 so each customer's most recent
-- visit is labeled 1, then write another query that uses this one as a subquery
-- and filters the results to only the customer's most recent visit

SELECT * FROM 
(
SELECT DISTINCT cp.customer_id, cp.market_date,
	DENSE_RANK() OVER (PARTITION BY cp.customer_id ORDER BY cp.market_date DESC) AS customer_visit
FROM farmers_market.customer_purchases as cp
ORDER BY cp.customer_id, cp.market_date DESC
) x
WHERE x.customer_visit = 1;
