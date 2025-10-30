-- ==========================================================
--  NON-CORRELATED SUBQUERY: Properties with average rating > 4.0
-- ==========================================================
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night
FROM Property p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM Review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);
-- ==========================================================
--  CORRELATED SUBQUERY: Users with more than 3 bookings
-- ==========================================================
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3;

