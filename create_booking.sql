CREATE PROCEDURE CreateBooking
    @customer_id INT,
    @room_id INT,
    @check_in DATE,
    @check_out DATE
AS
BEGIN
    INSERT INTO Bookings (customer_id, room_id, check_in, check_out)
    VALUES (@customer_id, @room_id, @check_in, @check_out);
END;
