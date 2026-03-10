INSERT INTO Customers (name, email, phone)
VALUES
('Cristian Vultur','vulturcristianmarcel@gmail.com','0712345678'),
('Ana Popescu','anap1@gmail.com','0747825943'),
('Denisa Marcu','marcud3@gmail.com','0785302573');

INSERT INTO Hotels (hotel_name, city)
VALUES
('Grand Hotel','Cluj-Napoca'),
('City Hotel','Bucharest');

INSERT INTO Rooms (hotel_id, room_number, price_per_night, capacity)
VALUES
(1,101,200,2),
(1,102,250,3),
(2,201,300,2);

INSERT INTO Bookings (customer_id, room_id, check_in, check_out)
VALUES
(1,1,'2026-04-01','2026-04-05'),
(2,3,'2026-04-10','2026-04-12');
