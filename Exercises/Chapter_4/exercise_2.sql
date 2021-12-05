-- Chapter 4, Exercise 2
--
-- We want to flag all of the different types of pepper products that are sold at the market.
-- Add a column to the previous query called pepper_flag that outputs a 1 if the product_name contains
-- the word "pepper" (regardless of capitalization) and otherwise outputs 0

SELECT product_id, product_name,
	CASE WHEN product_qty_type = "unit" THEN "unit" ELSE "bulk" END prod_qty_type_condensed,
    CASE WHEN lower(product_name) LIKE "%pepper%" THEN 1 ELSE 0 END pepper_flag
FROM farmers_market.product;