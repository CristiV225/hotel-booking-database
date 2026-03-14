CREATE DATABASE HotelBookingDB;
GO

USE HotelBookingDB;
GO

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),

    CONSTRAINT chk_email
    CHECK (email LIKE '%@gmail.com' OR email LIKE '%@yahoo.com'),

    CONSTRAINT chk_phone
    CHECK (phone LIKE '07________')
);

SELECT * FROM Customers;

CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY IDENTITY,
    hotel_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

SELECT * FROM Hotels;

CREATE TABLE RoomTypes (
    type_id INT PRIMARY KEY IDENTITY,
    type_name VARCHAR(50) NOT NULL,
    description VARCHAR(200)
);

SELECT * FROM RoomTypes;

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY IDENTITY,
    hotel_id INT,
    type_id INT,
    room_number INT,
    price_per_night INT,
    capacity INT,

    CONSTRAINT chk_price
    CHECK (price_per_night > 0),

    CONSTRAINT chk_capacity
    CHECK (capacity > 0),

    CONSTRAINT chk_room_number
    CHECK (room_number > 0),

    CONSTRAINT unique_room_per_hotel
    UNIQUE (hotel_id, room_number),

    FOREIGN KEY (hotel_id)
    REFERENCES Hotels(hotel_id),

    FOREIGN KEY (type_id)
    REFERENCES RoomTypes(type_id)
);

SELECT * FROM Rooms;

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY IDENTITY,
    customer_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,

    CONSTRAINT chk_dates
    CHECK (check_in < check_out),

    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id),

    FOREIGN KEY (room_id)
    REFERENCES Rooms(room_id)
);

SELECT * FROM Bookings;

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY,
    booking_id INT,
    amount INT,
    payment_date DATE,

    CONSTRAINT chk_payment_amount
    CHECK (amount > 0),

    FOREIGN KEY (booking_id)
    REFERENCES Bookings(booking_id)
);

SELECT * FROM Payments;

INSERT INTO Customers (name,email,phone)
VALUES
('Cristian Vultur','vulturcristianmarcel@gmail.com','0712345678'),
('Ana Popescu','anap1@gmail.com','0747825943'),
('Denisa Marcu','marcud3@gmail.com','0785302573');

INSERT INTO Hotels (hotel_name,city)
VALUES
('Grand Hotel','Cluj-Napoca'),
('City Hotel','Bucharest');

INSERT INTO RoomTypes (type_name,description)
VALUES
('Single','1 person'),
('Double','2 persons'),
('Family','4 persons'),
('Suite','Luxury room');

INSERT INTO Rooms (hotel_id,type_id,room_number,price_per_night,capacity)
VALUES
(1,1,101,200,1),
(1,2,102,250,2),
(1,3,103,350,4),
(2,2,201,300,2),
(2,4,202,500,2);

INSERT INTO Bookings (customer_id,room_id,check_in,check_out)
VALUES
(1,1,'2026-04-01','2026-04-05'),
(2,4,'2026-04-10','2026-04-12');


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

SELECT dbo.CalculateBookingCost(1) AS BookingCost;

INSERT INTO Payments (booking_id, amount, payment_date)
VALUES
(1, dbo.CalculateBookingCost(1), '2026-04-01'),  
(2, dbo.CalculateBookingCost(2), '2026-04-10');  

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

SELECT 
Hotels.hotel_name,
COUNT(Rooms.room_id) AS total_rooms
FROM Hotels
LEFT JOIN Rooms
ON Hotels.hotel_id = Rooms.hotel_id
GROUP BY Hotels.hotel_name;

SELECT
Hotels.hotel_name,
MAX(Rooms.price_per_night) AS most_expensive_room
FROM Hotels
JOIN Rooms
ON Hotels.hotel_id = Rooms.hotel_id
GROUP BY Hotels.hotel_name;

SELECT
Hotels.hotel_name,
SUM(Rooms.price_per_night *
DATEDIFF(day, check_in, check_out)) AS revenue
FROM Bookings
JOIN Rooms ON Bookings.room_id = Rooms.room_id
JOIN Hotels ON Rooms.hotel_id = Hotels.hotel_id
GROUP BY Hotels.hotel_name;

-- TOP CLIENTS

SELECT
Customers.name,
COUNT(Bookings.booking_id) AS total_bookings
FROM Customers
JOIN Bookings ON Customers.customer_id = Bookings.customer_id
GROUP BY Customers.name
ORDER BY total_bookings DESC;
