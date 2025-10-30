-- ==========================================================
-- ALX AIRBNB DATABASE MODULE - ADVANCED SQL JOINS
-- Author: Kenny DaSilva
-- File: joins_queries.sql
-- Description:
--   Complex queries using INNER JOIN, LEFT JOIN, and FULL OUTER JOIN
--   for the Airbnb-like database schema.
-- ==========================================================

-- ==========================================================
-- 1️⃣ INNER JOIN: Retrieve all bookings and the respective users
-- ==========================================================
-- This query combines Booking and Users tables to display
-- all confirmed or pending bookings along with the user’s name and email.

SELECT 
    b.booking_id,
    b.property_id,
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.email,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM Booking b
INNER JOIN users u ON b.user_id = u.user_id
ORDER BY b.start_date DESC;

-- ==========================================================
-- 2️⃣ LEFT JOIN: Retrieve all properties and their reviews
-- ==========================================================
-- This query returns every property, including those without reviews.
-- If a property has no review, the rating/comment fields will be NULL.

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
ORDER BY p.name;

-- ==========================================================
-- 3️⃣ FULL OUTER JOIN: Retrieve all users and all bookings
-- ==========================================================
-- MySQL does not support FULL OUTER JOIN directly.
-- To simulate it, we use a UNION of LEFT JOIN and RIGHT JOIN.
-- This ensures all users and all bookings are included,
-- even when there’s no relationship between them.

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM users u
LEFT JOIN Booking b ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM users u
RIGHT JOIN Booking b ON u.user_id = b.user_id
ORDER BY full_name;

-- ==========================================================
-- END OF FILE
-- ==========================================================

