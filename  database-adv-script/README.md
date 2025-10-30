# ALX Airbnb Database - Advanced SQL Joins

## About
This project is part of the **ALX Airbnb Database Module**, focused on mastering SQL joins and database optimization techniques.

In this task, we demonstrate the use of **INNER JOIN**, **LEFT JOIN**, and **FULL OUTER JOIN** (simulated using UNION in MySQL) on an Airbnb-like database schema containing tables such as:
- `users`
- `Property`
- `Booking`
- `Review`

## Objective
Write SQL queries that retrieve meaningful insights by combining data from multiple related tables.

## Tasks

### 1️⃣ INNER JOIN
Retrieve all bookings and their respective users.

**File:** `joins_queries.sql`
```sql
SELECT b.booking_id, u.first_name, u.last_name, u.email, b.start_date, b.end_date, b.status
FROM Booking b
INNER JOIN users u ON b.user_id = u.user_id;

