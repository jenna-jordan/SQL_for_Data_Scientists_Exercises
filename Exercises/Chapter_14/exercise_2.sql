/*
Chapter 14, Exercise 2

Write a query to determine what the data from the vendor_booth_assignment table
looked like on October 3, 2020 by querying the vendor_booth_log table created
in this chapter. (Assume that the records have been inserted into the log table
any time changes were made to the vendor_booth_assignment table)
*/

select * from farmers_market.vendor_booth_assignments vba;

create table farmers_market.vendor_booth_log as (
select vba.*,
	b.booth_type ,
	v.vendor_name ,
	CURRENT_TIMESTAMP() as snapshot_timestamp 
from farmers_market.vendor_booth_assignments vba 
	inner join farmers_market.vendor v 
		on vba.vendor_id = v.vendor_id 
	inner join farmers_market.booth b 
		on vba.booth_number = b.booth_number 
WHERE market_date >= '2020-10-01'
);

select * from farmers_market.vendor_booth_log;

update farmers_market.vendor_booth_assignments 
set booth_number = 9
where vendor_id = 8 and market_date = '2020-10-10';

INSERT INTO farmers_market.vendor_booth_log 
select vba.*,
	b.booth_type ,
	v.vendor_name ,
	CURRENT_TIMESTAMP() as snapshot_timestamp 
from farmers_market.vendor_booth_assignments vba 
	inner join farmers_market.vendor v 
		on vba.vendor_id = v.vendor_id 
	inner join farmers_market.booth b 
		on vba.booth_number = b.booth_number 
WHERE market_date >= '2020-10-01';

SELECT * 
FROM farmers_market.vendor_booth_log
WHERE snapshot_timestamp = '2022-03-06 15:59:48';



