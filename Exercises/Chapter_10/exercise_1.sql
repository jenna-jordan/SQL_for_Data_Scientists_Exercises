-- Chapter 10, Exercise 1
--
-- Using the view created in this chapter called 
-- farmers_market.vw_sales_by_day_vendor, referring to Figure 10.3
-- for a preview of the data in the dataset, write a query
-- to build a report that summarizes the sales per vendor per market week

-- First, let's recreate the view 
DROP VIEW farmers_market.vw_sales_by_day_vendor;
CREATE VIEW farmers_market.vw_sales_by_day_vendor AS
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

-- Now for the report 

SELECT sdv.vendor_name, sdv.market_year, sdv.market_week, SUM(sdv.sales) as weekly_sales
FROM farmers_market.vw_sales_by_day_vendor as sdv
GROUP BY sdv.vendor_id, sdv.market_year, sdv.market_week
ORDER BY sdv.market_year, sdv.market_week, sdv.vendor_name;


