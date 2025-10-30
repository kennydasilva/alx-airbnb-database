-- ==========================================================
-- 4️⃣ PERFORMANCE OPTIMIZATION - COMPLEX QUERY REFACTORING
-- Author: Kenny DaSilva
-- ==========================================================

-- STEP 1: Initial Query (before optimization)
-- Retrieves all bookings with user, property, and payment details
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location,
    py.amount,
    py.payment_method,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM Booking b
JOIN users u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN Payment py ON py.booking_id = b.booking_id
ORDER BY b.start_date DESC;

-- STEP 2: Analyze query performance
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    py.amount
FROM Booking b
JOIN users u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN Payment py ON py.booking_id = b.booking_id;

-- STEP 3: Optimized version (reduced columns, indexed joins)
-- Uses only necessary fields and relies on indexed columns
SELECT 
    b.booking_id,
    u.first_name,
    u.email,
    p.name AS property_name,
    py.amount
FROM Booking b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment py ON py.booking_id = b.booking_id
ORDER BY b.booking_id;

