SELECT 
Hotels.hotel_name,
COUNT(Rooms.room_id) AS total_rooms
FROM Hotels
LEFT JOIN Rooms
ON Hotels.hotel_id = Rooms.hotel_id
GROUP BY Hotels.hotel_name;
