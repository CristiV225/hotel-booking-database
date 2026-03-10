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
