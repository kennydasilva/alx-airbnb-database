-- ==========================================================
-- 5️⃣ PARTITIONING BOOKING TABLE BY DATE
-- Author: Kenny DaSilva
-- ==========================================================

-- STEP 1: Create partitioned Booking table by year of start_date
CREATE TABLE Booking_partitioned (
    booking_id UUID PRIMARY KEY,
    property_id UUID,
    user_id UUID,
    start_date DATE,
    end_date DATE,
    total_price DECIMAL(10,2),
    status VARCHAR(20)
)
PARTITION BY RANGE (start_date);

-- STEP 2: Create yearly partitions
CREATE TABLE booking_2024 PARTITION OF Booking_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-12-31');

CREATE TABLE booking_2025 PARTITION OF Booking_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-12-31');

-- STEP 3: Querying partitioned data
EXPLAIN ANALYZE
SELECT * FROM Booking_partitioned
WHERE start_date BETWEEN '2025-01-01' AND '2025-06-30';

