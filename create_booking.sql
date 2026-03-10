CREATE PROCEDURE CreateBooking
@customer_id INT,
@room_id INT,
@check_in DATE,
@check_out DATE
AS
BEGIN

IF EXISTS (
SELECT *
FROM Bookings
WHERE room_id=@room_id
AND @check_in < check_out
AND @check_out > check_in
)

PRINT 'Room already booked in this period'

ELSE

INSERT INTO Bookings(customer_id,room_id,check_in,check_out)
VALUES(@customer_id,@room_id,@check_in,@check_out)

END;

EXEC CreateBooking 1,2,'2026-05-01','2026-05-05';
