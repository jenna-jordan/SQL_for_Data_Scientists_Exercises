-- Chapter 5, Exercise 1
--
-- Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table 
-- on the vendor_id field they both have in common, and sorts the result by vendor_name, then market_date.

SELECT *
FROM farmers_market.vendor v
	INNER JOIN farmers_market.vendor_booth_assignments vba ON v.vendor_id = vba.vendor_id
ORDER BY v.vendor_name, vba.market_date;