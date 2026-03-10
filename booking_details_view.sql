CREATE VIEW BookingDetails AS
SELECT 
    Customers.name,
    Hotels.hotel_name,
    Rooms.room_number,
    Bookings.check_in,
    Bookings.check_out
FROM Bookings
JOIN Customers
ON Bookings.customer_id = Customers.customer_id
JOIN Rooms
ON Bookings.room_id = Rooms.room_id
JOIN Hotels
ON Rooms.hotel_id = Hotels.hotel_id;
