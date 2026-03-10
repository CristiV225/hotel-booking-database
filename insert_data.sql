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
