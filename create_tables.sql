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

ALTER TABLE Rooms
ADD CONSTRAINT fk_hotel
FOREIGN KEY (hotel_id)
REFERENCES Hotels(hotel_id);

ALTER TABLE Bookings
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES Customers(customer_id);

ALTER TABLE Bookings
ADD CONSTRAINT fk_room
FOREIGN KEY (room_id)
REFERENCES Rooms(room_id);
