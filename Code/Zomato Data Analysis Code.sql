/**********     Analysis Part     **********/


--Fetch the records from Zomato_info.

SELECT *
FROM ZOMATO_INFO;

--Count the records from Zomato_info table.

SELECT COUNT(*)
FROM ZOMATO_INFO;

--Find the Hotel names information that are located in 'Indiranagar'.

SELECT *
FROM ZOMATO_INFO
WHERE AREA_NAME = 'Indiranagar';

--Find the Hotel Name that are located in Indiranagar and Home_Delivery is available.

SELECT HOTEL_NAMES,
	   AREA_NAME,
	   HOME_DELIVERY
FROM ZOMATO_INFO
WHERE AREA_NAME = 'Indiranagar'
	AND HOME_DELIVERY = 'Yes';

--Find the Hotel name that are belong to south Indian cuisines.

SELECT HOTEL_NAMESa,
	   CUISINES
FROM ZOMATO_INFO
WHERE CUISINES = 'South Indian';

--Fetch the hotel name that are belong to North Indian cuisines.

SELECT HOTEL_NAMES,
	   CUISINES
FROM ZOMATO_INFO
WHERE CUISINES like 'B%';

--Find the top 5 hotel names,cuisines,area_name by Dinner Ratings.

SELECT HOTEL_NAMES,
	   CUISINES,
	   AREA_NAME,
	   DINNER_RATINGS
FROM ZOMATO_INFO
WHERE DINNER_RATINGS > 4.8
ORDER BY DINNER_RATINGS DESC;

--Count the hotel names that are belong to area.

SELECT COUNT(HOTEL_NAMES),
	         AREA_NAME
FROM ZOMATO_INFO
GROUP BY AREA_NAME;

--Fetch the records of hotel names that are belongs to area.

SELECT HOTEL_NAMES,
	   AREA_NAME,
	COUNT(HOTEL_NAMES) OVER (PARTITION BY AREA_NAME)
FROM ZOMATO_INFO;

--Find the hotel names that are vegetarian.

SELECT HOTEL_NAMES,
	   "VEG NON - VEG"
FROM ZOMATO_INFO
WHERE "VEG NON - VEG" = 'Veg';

--Find the hotel names that are non vegetarian.

SELECT HOTEL_NAMES,
	   "VEG NON - VEG"
FROM ZOMATO_INFO
WHERE "VEG NON - VEG" = 'Non Veg';

--Find the hotel names that allows to get parcel.

SELECT HOTEL_NAMES,
	   TAKE_AWAY
FROM ZOMATO_INFO
WHERE TAKE_AWAY = 'Yes';

--Which hotel names are not allows to take parcel.

SELECT HOTEL_NAMES,
	   TAKE_AWAY
FROM ZOMATO_INFO
WHERE TAKE_AWAY = 'No';

--Find the top hotel names by dinner reviews.

SELECT HOTEL_NAMES,
	   DINNER_REVIEWS
FROM ZOMATO_INFO
WHERE DINNER_REVIEWS >= 10000
ORDER BY DINNER_REVIEWS DESC;

--Find the top delivery ratings by area.

SELECT DELIVERY_RATINGS,
	   AREA_NAME
FROM ZOMATO_INFO
WHERE DELIVERY_RATINGS >= 4.5
ORDER BY DELIVERY_RATINGS DESC;

--Find the top delivery reviews by area.

SELECT DELIVERY_REVIEWS,
	   AREA_NAME
FROM ZOMATO_INFO
WHERE DELIVERY_REVIEWS >= 50000;

--Find the hotel names that belongs to Authentic food.

SELECT HOTEL_NAMES,
	   KNOWN_FOR_FOOD
FROM ZOMATO_INFO
WHERE KNOWN_FOR_FOOD like '%Authentic%';

--Find the hotel names that belongs to Spicy food.

SELECT HOTEL_NAMES,
	   KNOWN_FOR_FOOD
FROM ZOMATO_INFO
WHERE KNOWN_FOR_FOOD like '%Spicy%';

--Find the top 10 hotel information by dinner ratings.

SELECT *
FROM ZOMATO_INFO
WHERE DINNER_RATINGS > 4.5
ORDER BY DINNER_RATINGS DESC
LIMIT 10;

/* Find the hotel names,area_name that belongs to 
IceCream,Beverages cuisines. */

SELECT HOTEL_NAMES,
	   AREA_NAME,
	   CUISINES
FROM ZOMATO_INFO
WHERE CUISINES = 'Ice cream, Beverages'
	OR CUISINES like 'Ice%';

--Find the hotel names that have popular dishes.

SELECT HOTEL_NAMES,
	   POPULAR_DISHES
FROM ZOMATO_INFO;

/* Arrange the view of hotel names,
cuisines,area name,veg & non-veg. */

CREATE VIEW HOTEL_INFO AS
SELECT HOTEL_NAMES,
	   CUISINES,
	   AREA_NAME,
	   "Veg Non-veg"
FROM ZOMATO_INFO;

--Count the hotel names that are belong to veg & non veg.

SELECT "VEG NON - VEG",
	   COUNT("VEG NON - VEG")
FROM ZOMATO_INFO
GROUP BY "VEG NON - VEG";

/* Find the hotel names,area name that are between
average cost of 50 to 500 Rs. */

SELECT HOTEL_NAMES,
	   AREA_NAME,
	   AVERAGE_COST
FROM ZOMATO_INFO
WHERE AVERAGE_COST BETWEEN 50 AND 500
ORDER BY AVERAGE_COST ASC;

--Fetch the feedback of hotel.

SELECT HOTEL_NAMES,
	   CUSTOMER_FEEDBACK
FROM ZOMATO_INFO;

--Arrange the view of hotel names,area name,average cost.

CREATE VIEW AVERAGE_COST_INFO
AS
SELECT HOTEL_NAMES,
	   AREA_NAME,
	   AVERAGE_COST
FROM ZOMATO_INFO;

--Find the Hotel name that have greater than average dinner ratings.

SELECT HOTEL_NAMES,
	   DINNER_RATINGS
FROM ZOMATO_INFO
WHERE DINNER_RATINGS >
		(SELECT AVG(DINNER_RATINGS)
			FROM ZOMATO_INFO);

/* Print the hotel name. 
which hotel have top dinner ratings by area name. */ 

SELECT HOTEL_NAMES,
	AREA_NAME,
	DINNER_RATINGS,
	FIRST_VALUE(HOTEL_NAMES) OVER (PARTITION BY AREA_NAME
	ORDER BY DINNER_RATINGS DESC) AS TOP_HOTEL_BY_DINNER_RATING
FROM ZOMATO_INFO;

-- Rank the top 5 hotel names and area name by delivery review.

SELECT HOTEL_NAMES,AREA_NAME,
	DELIVERY_REVIEWS,
	RANK() OVER
	(ORDER BY DELIVERY_REVIEWS DESC)
	AS TOP_HOTELS
FROM ZOMATO_INFO
LIMIT 5;