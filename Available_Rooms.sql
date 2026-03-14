
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


