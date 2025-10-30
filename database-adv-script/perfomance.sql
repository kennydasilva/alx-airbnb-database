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

-- STEP 1b: Initial Query with WHERE and AND clauses (more realistic scenario)
-- Retrieves filtered bookings with specific criteria
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
WHERE b.status = 'confirmed'
    AND b.start_date >= '2024-01-01'
    AND py.amount > 100
    AND p.location LIKE '%New York%'
ORDER BY b.start_date DESC;

-- STEP 2: Analyze query performance for both versions
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

-- STEP 2b: Analyze filtered query performance
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
JOIN Payment py ON py.booking_id = b.booking_id
WHERE b.status = 'confirmed'
    AND b.start_date >= '2024-01-01'
    AND py.amount > 100;

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

-- STEP 3b: Optimized version with WHERE and AND clauses
-- Filtered query with performance optimizations
SELECT 
    b.booking_id,
    u.first_name,
    u.email,
    p.name AS property_name,
    p.location,
    py.amount,
    b.start_date,
    b.status
FROM Booking b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment py ON py.booking_id = b.booking_id
WHERE b.status IN ('confirmed', 'completed')
    AND b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (py.amount > 50 OR py.amount IS NULL)
    AND p.location IS NOT NULL
ORDER BY b.start_date DESC, py.amount DESC;

-- STEP 4: Create supporting indexes for WHERE clause optimization
CREATE INDEX IF NOT EXISTS idx_booking_status_date ON Booking (status, start_date);
CREATE INDEX IF NOT EXISTS idx_booking_dates ON Booking (start_date, end_date);
CREATE INDEX IF NOT EXISTS idx_payment_amount ON Payment (amount);
CREATE INDEX IF NOT EXISTS idx_property_location ON Property (location);

-- STEP 5: Analyze optimized query performance
EXPLAIN ANALYZE
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
WHERE b.status = 'confirmed'
    AND b.start_date >= '2024-01-01'
    AND (py.amount > 100 OR py.amount IS NULL);
