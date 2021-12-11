-- Chapter 6, Exercise 2
--
-- In Chapter 5, "SQL Joins", exercise 3, we asked "When is each type of fresh fruit or vegetable
-- in season, locally?" Write a query that displays the product category name, product name, 
-- earliest date available, and latest date available for every product in the
-- "Fresh Fuits & Vegetables" product category

SELECT pc.product_category_name, p.product_name, min(vi.market_date), max(vi.market_date)
FROM farmers_market.product p
	JOIN farmers_market.product_category pc ON p.product_category_id = pc.product_category_id
    JOIN farmers_market.vendor_inventory vi ON p.product_id = vi.product_id
WHERE pc.product_category_name = "Fresh Fruits & Vegetables"
GROUP BY pc.product_category_name, p.product_name;
