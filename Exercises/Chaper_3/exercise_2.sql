-- Chapter 3, Exercise 2
--
-- Refer to the data in Table 3.1. 
-- Write two queries, one using two conditions with an AND operator,
-- and one using the BETWEEN operator,
-- that will return all customer purchases made from vendors with vendor IDs between 8 and 10 (inclusive).

SELECT * FROM farmers_market.customer_purchases WHERE vendor_id >= 8 AND vendor_id <= 10;

SELECT * FROM farmers_market.customer_purchases WHERE vendor_id BETWEEN 8 AND 10;
