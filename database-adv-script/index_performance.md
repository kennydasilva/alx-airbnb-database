-- ==========================================================
-- DATABASE INDEX OPTIMIZATION
-- ==========================================================

-- Index on Booking.user_id for frequent JOINs and WHERE clauses
CREATE INDEX idx_booking_user_id ON Booking (user_id);

-- Index on Property.location for faster filtering by city/area
CREATE INDEX idx_property_location ON Property (location);

-- Index on Review.property_id for quick lookup of reviews
CREATE INDEX idx_review_property_id ON Review (property_id);
# Index Performance Analysis

## Before Indexing
Queries involving `JOIN` between `Booking` and `users` or filters by `Property.location`
took longer due to full table scans.

## After Indexing
Using `EXPLAIN ANALYZE`, the execution plans showed that indexes reduced scan times
and improved query performance significantly.

### Key Improvements
- **Booking.user_id** → Faster user-to-booking lookups  
- **Property.location** → Efficient geographic filtering  
- **Review.property_id** → Improved property-review retrieval

Indexes are essential for optimizing large datasets where JOIN and WHERE conditions are frequent.

