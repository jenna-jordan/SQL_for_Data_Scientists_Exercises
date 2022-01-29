-- Chapter 9, Exercise 2
--
-- There is a MySQL function DAYNAME() that returns the name of the day
-- of the week for a date. Using the DAYNAME and EXTRACT functions on the 
-- customer_purchases table, select and group by the weekday and hour
-- of the day, and count the distinct numbers of customers during
-- each hour of the Wednesday and Saturday markets. See Chapter 6,
-- "Aggregating Results for Analysis", and 8, "Date and Time Functions",
-- for information on the COUNT DISTINCT and EXTRACT functions.

SELECT market_weekday, market_hour, COUNT(DISTINCT customer_id) as num_customers
FROM(
	SELECT *,
		DAYNAME(market_date) as market_weekday, 
		EXTRACT(HOUR FROM transaction_time) as market_hour
	FROM customer_purchases cp
) market_datetime
GROUP BY market_weekday, market_hour;