SELECT
Hotels.hotel_name,
MAX(Rooms.price_per_night) AS most_expensive_room
FROM Hotels
JOIN Rooms
ON Hotels.hotel_id = Rooms.hotel_id
GROUP BY Hotels.hotel_name;
