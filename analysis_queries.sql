-- Venitul hotelurilor
SELECT 
    Hotels.hotel_name,
    SUM(Rooms.price_per_night) AS total_revenue
FROM Bookings
JOIN Rooms
ON Bookings.room_id = Rooms.room_id
JOIN Hotels
ON Rooms.hotel_id = Hotels.hotel_id
GROUP BY Hotels.hotel_name;

-- Clienti de top
SELECT 
    Customers.name,
    COUNT(Bookings.booking_id) AS total_bookings
FROM Customers
JOIN Bookings
ON Customers.customer_id = Bookings.customer_id
GROUP BY Customers.name
ORDER BY total_bookings DESC;
