# Performance Monitoring and Refinement

## Objective
Monitor query execution and refine schema and indexing strategies using `EXPLAIN ANALYZE` and `SHOW PROFILE`.

## Step 1: Monitoring Queries
Example monitored query:
```sql
EXPLAIN ANALYZE
SELECT u.first_name, COUNT(b.booking_id)
FROM users u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.first_name;

