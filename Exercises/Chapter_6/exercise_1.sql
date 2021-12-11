-- Chapter 6, Exercise 1
--
-- Write a query that determines how many times each vendor has rented a booth at the farmer's market.
-- In other words, count the vendor booth assignments per vendor_id

SELECT vendor_id, count(booth_number) as booth_count
FROM farmers_market.vendor_booth_assignments
GROUP BY vendor_id;