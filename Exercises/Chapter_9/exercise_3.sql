-- Chapter 9, Exercise 3
--
-- What other questions haven't we yet asked about the data
-- in these tables that you would be curious about?
-- Write two more queries further exploring or summarizing
-- the data in the product, vendor_inventory, or customer_purchases tables.

-- Let's take a look at the tables
SELECT *
FROM product;

SELECT *
FROM vendor_inventory;

SELECT *
FROM customer_purchases;

-- CURIOSITY QUESTION #1
-- I wonder how often the original price differs from the sold price 

-- First, let's see if the original price can change depending on the date 
SELECT vendor_id, product_id, COUNT(DISTINCT original_price) as price_count
FROM vendor_inventory vi
GROUP BY vendor_id, product_id
HAVING price_count > 1;
-- Nope! this simplifies things

-- Now for the final query - when is the cost to the customer different from 
-- the original price, and if so, is it a discount?
SELECT DISTINCT cp.vendor_id, cp.product_id, cp.customer_id, 
	vi.original_price, cp.cost_to_customer_per_qty,
	CASE WHEN vi.original_price > cp.cost_to_customer_per_qty
		THEN TRUE
		ELSE FALSE
	END AS is_discount
FROM vendor_inventory vi 
	JOIN customer_purchases cp ON vi.vendor_id = cp.vendor_id AND vi.product_id = cp.product_id
WHERE vi.original_price != cp.cost_to_customer_per_qty;

-- CURIOSITY QUESTION #2

-- from @Matty_TwoShoes on Twitch:
-- it looks like sales and products from a farmers market. 
-- i would be curious if purchases include more than 1 item or not and if they do, 
-- are the multi-item purchases cheap or expensive items?

-- Can we identify multi-item purchases based on the transaction_time

SELECT pc.*, p.product_name 
FROM(
	SELECT *, COUNT(product_id) OVER 
		(PARTITION BY market_date, transaction_time, vendor_id, customer_id 
		ORDER BY market_date, transaction_time, vendor_id, customer_id) as product_count_per_purchase
	FROM customer_purchases cp
) pc JOIN product p ON pc.product_id = p.product_id
WHERE pc.product_count_per_purchase > 1
ORDER BY market_date, transaction_time, vendor_id, customer_id;

