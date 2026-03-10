CREATE FUNCTION CalculateBookingCost (@booking_id INT)
RETURNS INT
AS
BEGIN

DECLARE @cost INT

SELECT 
@cost = Rooms.price_per_night *
DATEDIFF(day, check_in, check_out)

FROM Bookings
JOIN Rooms
ON Bookings.room_id = Rooms.room_id

WHERE booking_id = @booking_id

RETURN @cost

END;

-- test function
SELECT dbo.CalculateBookingCost(1) AS BookingCost;
-- adding the payments for bookings
INSERT INTO Payments (booking_id, amount, payment_date)
VALUES
(1, dbo.CalculateBookingCost(1), '2026-04-01'),  
(2, dbo.CalculateBookingCost(2), '2026-04-10');  
