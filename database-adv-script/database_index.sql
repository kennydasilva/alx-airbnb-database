-- ==========================================================
-- DATABASE INDEX OPTIMIZATION
-- ==========================================================

-- ==========================================================
-- Measure query performance BEFORE indexing
-- ==========================================================

-- Query 1: User bookings analysis (uses Booking.user_id)
EXPLAIN ANALYZE
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id
ORDER BY total_bookings DESC;

-- Query 2: Property search by location (uses Property.location)  
EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location
FROM Property p
WHERE p.location LIKE '%New York%'
ORDER BY p.name;

-- Query 3: Property reviews analysis (uses Review.property_id)
EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(r.review_id) AS total_reviews,
    AVG(r.rating) AS average_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
ORDER BY average_rating DESC;

-- ==========================================================
-- CREATE INDEX commands
-- ==========================================================

-- Index on Booking.user_id for frequent JOINs and WHERE clauses
CREATE INDEX idx_booking_user_id ON Booking (user_id);

-- Index on Property.location for faster filtering by city/area
CREATE INDEX idx_property_location ON Property (location);

-- Index on Review.property_id for quick lookup of reviews
CREATE INDEX idx_review_property_id ON Review (property_id);

-- ==========================================================
-- Measure query performance AFTER indexing
-- ==========================================================

-- Query 1: User bookings analysis (should show improved performance)
EXPLAIN ANALYZE
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id
ORDER BY total_bookings DESC;

-- Query 2: Property search by location (should show improved performance)
EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location
FROM Property p
WHERE p.location LIKE '%New York%'
ORDER BY p.name;

-- Query 3: Property reviews analysis (should show improved performance)
EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(r.review_id) AS total_reviews,
    AVG(r.rating) AS average_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
ORDER BY average_rating DESC;

-- ==========================================================
-- Additional useful indexes for common query patterns
-- ==========================================================

-- Composite index for booking date range queries
CREATE INDEX idx_booking_dates ON Booking (check_in_date, check_out_date);

-- Index for user authentication and lookups
CREATE INDEX idx_user_email ON users (email);

-- Index for review ratings filtering
CREATE INDEX idx_review_rating ON Review (rating);

-- ==========================================================
-- Verify indexes were created
-- ==========================================================

-- Check existing indexes
SELECT 
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename IN ('booking', 'property', 'review', 'users')
ORDER BY tablename, indexname;
