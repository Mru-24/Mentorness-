-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2024 at 06:46 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel reservation system`
--

-- --------------------------------------------------------

--
-- Table structure for table `hotel_reservations`
--

CREATE TABLE `hotel_reservations` (
  `Booking_ID` varchar(8) DEFAULT NULL,
  `no_of_adults` int(1) DEFAULT NULL,
  `no_of_children` int(1) DEFAULT NULL,
  `no_of_weekend_nights` int(1) DEFAULT NULL,
  `no_of_week_nights` int(2) DEFAULT NULL,
  `type_of_meal_plan` varchar(12) DEFAULT NULL,
  `room_type_reserved` varchar(11) DEFAULT NULL,
  `lead_time` int(3) DEFAULT NULL,
  `arrival_date` varchar(10) DEFAULT NULL,
  `market_segment_type` varchar(13) DEFAULT NULL,
  `avg_price_per_room` decimal(5,2) DEFAULT NULL,
  `booking_status` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

COPY hotel_reservations 
FROM 'D:/DA/Hotel Reservation Dataset.csv' 
DELIMITER ',' 
CSV HEADER;

select * from hotel_reservations


  /* another method to import the dataset for phpmyadmin sql platform*/
/* first create database with the name you want*/
/* second go to the database and then clivk on import option on the top*/
/* in that select the file you want to import and click import*/


1. What is the total number of reservations in the dataset?
SELECT COUNT(Booking_ID) AS total_reservations
FROM hotel_reservations ;


2. Which meal plan is the most popular among guests?
SELECT type_of_meal_plan, COUNT(type_of_meal_plan) AS most_popular_meal
FROM hotel_reservations 
GROUP BY type_of_meal_plan
ORDER BY most_popular_meal DESC;


3. What is the average price per room for reservations involving children?
SELECT AVG(avg_price_per_room) AS price_per_room
FROM hotel_reservations
WHERE no_of_children >=1;


4. How many reservations were made for the year 20XX (replace XX with the desired year)?
SELECT COUNT(*) AS reservations_count
FROM hotel_reservations
WHERE arrival_year= '2018';


5. What is the most commonly booked room type?
SELECT room_type_reserved, COUNT(room_type_reserved) AS most_common_room_type
FROM hotel_reservations
GROUP BY room_type_reserved
ORDER BY most_common_room_type DESC
LIMIT 1;


6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?
SELECT COUNT(*) AS no_of_weekend_night
FROM hotel_reservations
WHERE no_of_weekend_nights > 0;


7. What is the highest and lowest lead time for reservations?
SELECT 
    MAX(lead_time) AS highest_lead_time,
    MIN(lead_time) AS lowest_lead_time
FROM hotel_reservations;


8. What is the most common market segment type for reservations?
SELECT market_segment_type, COUNT(*) AS segment_count
FROM hotel_reservations
GROUP BY market_segment_type
ORDER BY segment_count DESC
LIMIT 1;


9. How many reservations have a booking status of "Confirmed"?
SELECT COUNT(*) AS confirmed_count
FROM hotel_reservations
WHERE booking_status = 'Not_Canceled';


10. What is the total number of adults and children across all reservations?
SELECT 
    SUM(no_of_adults) AS total_adults,
    SUM(no_of_children) AS total_children
FROM hotel_reservations;


11. What is the average number of weekend nights for reservations involving children?
SELECT AVG(no_of_weekend_nights) AS average
FROM hotel_reservations
WHERE no_of_children > 0;


12. How many reservations were made in each month of the year?
SELECT 
    EXTRACT(MONTH FROM arrival_date) AS month,
    COUNT(*) AS reservations_count
FROM hotel_reservations
GROUP BY month
ORDER BY month;


13. What is the average number of nights (both weekend and weekday) spent by guests for each room
type?
SELECT 
    room_type_reserved,
    AVG(total_nights) AS average_nights
FROM (
    SELECT 
        room_type_reserved,
        (no_of_weekend_nights + no_of_week_nights) AS total_nights
    FROM hotel_reservations
) AS subquery
GROUP BY room_type_reserved;


14. For reservations involving children, what is the most common room type, and what is the average 
price for that room type?
SELECT 
    room_type_reserved,
    AVG(avg_price_per_room) AS average_price
FROM hotel_reservations
WHERE no_of_children > 0
GROUP BY room_type_reserved
ORDER BY COUNT(*) DESC



15. Find the market segment type that generates the highest average price per room.
SELECT 
    market_segment_type,
    AVG(avg_price_per_room) AS average_price
FROM hotel_reservations
GROUP BY market_segment_type
ORDER BY average_price DESC

