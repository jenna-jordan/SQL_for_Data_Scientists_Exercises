-- Chapter 4, Exercise 1
--
-- Products can be sold by the individual unit or by bulk measures like lbs or oz
-- Write a query that output the product_id and product_name columns from the product table,
-- and add a column called prod_qty_type_condensed that displays the word "unit" if the
-- product_qty_type is "unit" and otherwise displays the word "bulk"

SELECT product_id, product_name,
	CASE WHEN product_qty_type = "unit" THEN "unit" ELSE "bulk" END prod_qty_type_condensed
FROM farmers_market.product;