# Partitioning Performance Report

## Before Partitioning
Queries filtering bookings by date range scanned the entire `Booking` table.  
Execution was slow as dataset size increased.

## After Partitioning
The `Booking` table was partitioned by `start_date` (yearly).

### Performance Improvements
- Queries limited to specific date ranges now scan only relevant partitions.
- Reduced I/O and memory usage.
- Faster analytical queries on recent bookings.

### Example:

