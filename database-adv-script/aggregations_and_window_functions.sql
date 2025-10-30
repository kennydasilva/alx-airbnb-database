-- ==========================================================
--  AGGREGATION: Total number of bookings per user
-- ==========================================================
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id
ORDER BY total_bookings DESC;

-- ==========================================================
--  WINDOW FUNCTION: Rank properties by total bookings
-- ==========================================================
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_position,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_num_position
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name;
