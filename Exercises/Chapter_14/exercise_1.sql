/*
Chapter 14, Exercise 1

If you include a CURRENT_TIMESTAMP column when you create a view,
what would you expect the values of that column to be when you query the view?
*/

-- Expectation: it will have the current time, when the view was queried

create view farmers_market.customer_purchases_display_vw as(
select
	p.product_name, 
	v.vendor_name, 
	concat(c.customer_first_name, ' ', c.customer_last_name) as customer_name,
	cp.quantity * cp.cost_to_customer_per_qty as price_paid,
	str_to_date(concat(cp.market_date, ' ', cp.transaction_time),
	'%Y-%m-%d %H:%i:%S') as purchase_datetime,
	current_timestamp
from
	customer_purchases cp
join product p on
	cp.product_id = p.product_id
join vendor v on
	cp.vendor_id = v.vendor_id
join customer c on
	cp.customer_id = c.customer_id) ;
	
SELECT * FROM customer_purchases_display_vw;

-- I was right! Expectation was correct.