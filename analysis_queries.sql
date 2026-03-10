-- AVAILABLE ROOMS IN HOTEL

SELECT room_number, price_per_night
FROM Rooms
WHERE hotel_id = 1
AND room_id NOT IN
(
SELECT room_id
FROM Bookings
WHERE '2026-05-01'
BETWEEN check_in AND check_out
);

-- NUMBER OF ROOMS PER HOTEL

SELECT 
Hotels.hotel_name,
COUNT(Rooms.room_id) AS total_rooms
FROM Hotels
LEFT JOIN Rooms
ON Hotels.hotel_id = Rooms.hotel_id
GROUP BY Hotels.hotel_name;

-- MOST EXPENSIVE ROOM PER HOTEL

SELECT
Hotels.hotel_name,
MAX(Rooms.price_per_night) AS most_expensive_room
FROM Hotels
JOIN Rooms
ON Hotels.hotel_id = Rooms.hotel_id
GROUP BY Hotels.hotel_name;

-- HOTEL REVENUE

SELECT
Hotels.hotel_name,
SUM(Rooms.price_per_night *
DATEDIFF(day, check_in, check_out)) AS revenue
FROM Bookings
JOIN Rooms ON Bookings.room_id = Rooms.room_id
JOIN Hotels ON Rooms.hotel_id = Hotels.hotel_id
GROUP BY Hotels.hotel_name;

-- TOP CLIENTS

SELECT
Customers.name,
COUNT(Bookings.booking_id) AS total_bookings
FROM Customers
JOIN Bookings ON Customers.customer_id = Bookings.customer_id
GROUP BY Customers.name
ORDER BY total_bookings DESC;
