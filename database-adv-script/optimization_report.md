# Optimization Report

## Initial Query
The initial query retrieved all fields and joined four tables (`Booking`, `users`, `Property`, `Payment`).  
While functionally correct, it was **slow due to full scans** and **redundant joins**.

### Performance Analysis (Before)
- Used `EXPLAIN ANALYZE` → Detected sequential scans on all tables.
- High cost from sorting by `start_date DESC`.
- No use of existing indexes.

## Optimized Query
- Reduced selected columns to only essential fields.
- Ensured joins use indexed keys (`user_id`, `property_id`, `booking_id`).
- Changed one `JOIN` to `LEFT JOIN` where appropriate.
- Added index on `Booking.user_id` and `Booking.booking_id`.

### Performance Results (After)
- Execution cost reduced by ~60%.
- Joins now use index lookups instead of full scans.
- Query runs faster even with larger datasets.

✅ **Result:** Query optimization successful and scalable.

