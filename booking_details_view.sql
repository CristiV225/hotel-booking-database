CREATE VIEW BookingDetails AS
SELECT 
Customers.name AS Customer,
Hotels.hotel_name AS Hotel,
RoomTypes.type_name AS RoomType,
Rooms.room_number,
Bookings.check_in,
Bookings.check_out
FROM Bookings
JOIN Customers ON Bookings.customer_id = Customers.customer_id
JOIN Rooms ON Bookings.room_id = Rooms.room_id
JOIN Hotels ON Rooms.hotel_id = Hotels.hotel_id
JOIN RoomTypes ON Rooms.type_id = RoomTypes.type_id;

SELECT * FROM BookingDetails;

