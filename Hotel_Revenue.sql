SELECT
Hotels.hotel_name,
SUM(Rooms.price_per_night *
DATEDIFF(day, check_in, check_out)) AS revenue
FROM Bookings
JOIN Rooms ON Bookings.room_id = Rooms.room_id
JOIN Hotels ON Rooms.hotel_id = Hotels.hotel_id
GROUP BY Hotels.hotel_name;
