CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY IDENTITY,
    hotel_name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY IDENTITY,
    hotel_id INT,
    room_number INT,
    price_per_night INT,
    capacity INT
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY IDENTITY,
    customer_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE
);
