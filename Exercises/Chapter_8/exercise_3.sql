-- Chapter 8, Exercise 3
--
-- In MySQL, there is a DAYNAME() function that returns the full name of the 
-- day of the week on which a date occurs. Query the Farmer's Market database
-- market_date_info table, return the market_date, the market_day,
-- and your calculated day of the week name that each market_date occurred on.
-- Create a calculated column using a CASE statement that indicates whether the
-- recorded day in the database differs from your calculated day of the week.
-- This is an example of a quality control query that could be used to 
-- check manually entered data for correctness. 

SELECT market_date, market_day, 
	DAYNAME(market_date) as calc_market_day,
    CASE 
		WHEN DAYNAME(market_date) != market_day
			THEN TRUE
		ELSE FAlSE
	END as day_name_differs
FROM farmers_market.market_date_info;