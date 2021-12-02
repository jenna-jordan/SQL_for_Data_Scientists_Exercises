-- Chapter 3, Exercise 3
--
-- Can you think of two different ways to change the final query in the chapter
-- so it would return purchases from days when it wasn't raining

-- ORIGINAL QUERY

SELECT 
    market_date,
    customer_id,
    vendor_id,
    quantity * cost_to_customer_per_qty price
FROM
    farmers_market.customer_purchases
WHERE
    market_date IN (SELECT 
            market_date
        FROM
            farmers_market.market_date_info
        WHERE
            market_rain_flag = 1)
LIMIT 5;

-- Alternative 1
-- change market_rain_flag = 1 to = 0

SELECT 
    market_date,
    customer_id,
    vendor_id,
    quantity * cost_to_customer_per_qty price
FROM
    farmers_market.customer_purchases
WHERE
    market_date IN (SELECT 
            market_date
        FROM
            farmers_market.market_date_info
        WHERE
            market_rain_flag = 0)
LIMIT 5;

-- Alternative 2
-- change market_rain_flag = 1 to != 1

SELECT 
    market_date,
    customer_id,
    vendor_id,
    quantity * cost_to_customer_per_qty price
FROM
    farmers_market.customer_purchases
WHERE
    market_date IN (SELECT 
            market_date
        FROM
            farmers_market.market_date_info
        WHERE
            market_rain_flag != 1)
LIMIT 5;