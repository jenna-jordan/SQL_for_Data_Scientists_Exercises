-- Chapter 10, Exercise 3
--
-- If you were asked to build a report of total and average market sales
-- by vendor booth type, how might you modify the query associated with
-- Figure 10.3 to include the information needed for your report?

-- Original query 

SELECT
	cp.market_date,
	mdi.market_day,
	mdi.market_week,
	mdi.market_year,
	cp.vendor_id,
	v.vendor_name,
	v.vendor_type,
	ROUND(SUM(cp.quantity * cp.cost_to_customer_per_qty), 2) AS sales
FROM
	farmers_market.customer_purchases cp
LEFT JOIN farmers_market.market_date_info mdi 
		ON
	cp.market_date = mdi.market_date
LEFT JOIN farmers_market.vendor v 
		ON
	cp.vendor_id = v.vendor_id
GROUP BY cp.market_date, cp.vendor_id 
ORDER BY cp.market_date, cp.vendor_id;

-- need to include booth assignment and booth type
WITH booth_sales AS (
SELECT
	cp.market_date,
	mdi.market_day,
	mdi.market_week,
	mdi.market_year,
	cp.vendor_id,
	v.vendor_name,
	v.vendor_type,
	ROUND(SUM(cp.quantity * cp.cost_to_customer_per_qty), 2) AS sales,
	b.booth_number, b.booth_price_level, b.booth_type 
FROM
	farmers_market.customer_purchases cp
LEFT JOIN farmers_market.market_date_info mdi 
		ON
	cp.market_date = mdi.market_date
LEFT JOIN farmers_market.vendor v 
		ON
	cp.vendor_id = v.vendor_id
LEFT JOIN farmers_market.vendor_booth_assignments vba 
	ON cp.market_date = vba.market_date AND cp.vendor_id = vba.vendor_id 
LEFT JOIN farmers_market.booth b
	ON vba.booth_number = b.booth_number 
GROUP BY cp.market_date, cp.vendor_id, b.booth_number
ORDER BY cp.market_date, cp.vendor_id)

SELECT booth_type, booth_price_level, SUM(sales), AVG(sales)
FROM booth_sales
GROUP BY booth_type, booth_price_level;
