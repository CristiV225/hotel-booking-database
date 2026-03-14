SELECT
Customers.name,
COUNT(Bookings.booking_id) AS total_bookings
FROM Customers
JOIN Bookings ON Customers.customer_id = Bookings.customer_id
GROUP BY Customers.name
ORDER BY total_bookings DESC;
