/* After a database named "Mentorness" had been created, I created a table named "Hotel Reservation" 
which exists in the "Mentorness" database*/

CREATE TABLE Hotel_Reservation ( 
    Booking_ID varchar(100),
    no_of_adults int,
    no_of_children int,
    no_of_weekend_nights int,
    no_of_week_nights int,
    type_of_meal_plan varchar(100),
    room_typed_reserved varchar(100),
    lead_time int,
    arrival_date date,
    market_segment_type text,
    avg_price_per_room numeric,
    booking_status varchar(100)
);

---Then I viewed the content of the table
SELECT * 
FROM Hotel_Reservation

---I renamed "room_typed_reserved" to "room_type_reserved"
ALTER TABLE Hotel_Reservation
RENAME COLUMN room_typed_reserved TO room_type_reserved;

---Then I proceeded to answering 15 specific questions about the dataset.

---1. What is the total number of reservations in the dataset?
SELECT COUNT(*) AS Total_Reservations
FROM Hotel_Reservation

	
---2. Which meal plan is the most popular among guests?
SELECT type_of_meal_plan AS meal_plan, COUNT(type_of_meal_plan) 
AS meal_plan_count
FROM Hotel_Reservation
GROUP BY meal_plan
ORDER BY  meal_plan_count DESC
LIMIT 1 

	
---3. What is the average price per room for reservations involving children?
SELECT Booking_ID, no_of_children, avg_price_per_room
FROM Hotel_Reservation 
WHERE no_of_children > 0;


---4. How many reservations were made for the year 20XX (replace XX with the desired year)?
SELECT EXTRACT(YEAR FROM arrival_date) AS year, COUNT(*) AS total_reservations
FROM Hotel_Reservation
WHERE EXTRACT(YEAR FROM arrival_date) = 2018
GROUP BY year;


---5. What is the most commonly booked room type?
SELECT room_type_reserved, COUNT(*) AS total_reservations
FROM Hotel_Reservation
GROUP BY room_type_reserved
ORDER BY total_reservations DESC
LIMIT 1;


---6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?
SELECT COUNT(*) AS weekend_reservations
FROM Hotel_Reservation
WHERE no_of_weekend_nights > 0;


---7. What is the highest and lowest lead time for reservations?
SELECT MAX(lead_time) AS highest_lead_time, MIN(lead_time) AS lowest_lead_time
FROM Hotel_Reservation
	
	
---8. What is the most common market segment type for reservations?
SELECT market_segment_type, COUNT(market_segment_type) AS market_segment_count
FROM Hotel_Reservation
GROUP BY market_segment_type
ORDER BY  market_segment_count DESC
LIMIT 1;


---9. How many reservations have a booking status of "Confirmed"?
SELECT booking_status, COUNT(*) AS booking_status_count
FROM Hotel_Reservation
GROUP BY booking_status
HAVING booking_status = 'Not_Canceled';


---10. What is the total number of adults and children across all reservations?
SELECT SUM(no_of_adults) AS total_adults, SUM(no_of_children) AS total_children
FROM Hotel_Reservation;


---11. What is the average number of weekend nights for reservations involving children?
SELECT ROUND(AVG(no_of_weekend_nights), 2) AS average_weekend_reservations
FROM Hotel_Reservation
WHERE no_of_children > 0;


---12. How many reservations were made in each month of the year?
SELECT EXTRACT(MONTH FROM arrival_date) AS Reservation_Month, COUNT(*) Reservation_Count
FROM Hotel_Reservation
GROUP BY Reservation_Month
ORDER BY  Reservation_Count DESC; 


---13. What is the average number of nights (both weekend and weekday) spent by guests for each room type?
SELECT room_type_reserved, ROUND(AVG(no_of_week_nights), 4) AS Average_weekday, 
    ROUND(AVG(no_of_weekend_nights), 4) AS Average_weekend
FROM Hotel_Reservation
GROUP BY room_type_reserved
ORDER BY room_type_reserved;
	

/* 14. For reservations involving children, what is the most common room type, and what is the 
average price for that room type? */

SELECT room_type_reserved, Count(room_type_reserved) AS room_type_count, 
	AVG(avg_price_per_room) AS Avg_price_per_room_type_count
FROM Hotel_Reservation
WHERE no_of_children > 0
GROUP BY room_type_reserved
ORDER BY room_type_count DESC
LIMIT 1;


---15. Find the market segment type that generates the highest average price per room.
SELECT market_segment_type, AVG(avg_price_per_room) AS Avg_price_per_market_segment
FROM Hotel_Reservation
GROUP BY market_segment_type
ORDER BY Avg_price_per_market_segment DESC
LIMIT 1;




