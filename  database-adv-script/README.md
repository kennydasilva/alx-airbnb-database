# ALX Airbnb Database - Advanced SQL Joins

## About
This project is part of the **ALX Airbnb Database Module**, focused on mastering SQL joins and database optimization techniques.

The database schema contains the following tables:
- `users`
- `properties`
- `bookings`
- `reviews`

## Objective
Write SQL queries that retrieve meaningful insights by combining data from multiple related tables.

---

### 1️⃣ INNER JOIN
Retrieve all bookings and their respective users.

**File:** `joins_queries.sql`
```sql
SELECT 
    b.id AS booking_id, 
    u.first_name, 
    u.last_name, 
    u.email, 
    b.start_date, 
    b.end_date, 
    b.status
FROM bookings b
INNER JOIN users u 
    ON b.user_id = u.id;

SELECT 
    p.id AS property_id, 
    p.name AS property_name, 
    r.id AS review_id, 
    r.comment, 
    r.rating
FROM properties p
LEFT JOIN reviews r 
    ON p.id = r.property_id;
SELECT 
    u.id AS user_id, 
    u.first_name, 
    u.last_name, 
    b.id AS booking_id, 
    b.start_date, 
    b.end_date
FROM users u
LEFT JOIN bookings b 
    ON u.id = b.user_id

UNION

SELECT 
    u.id AS user_id, 
    u.first_name, 
    u.last_name, 
    b.id AS booking_id, 
    b.start_date, 
    b.end_date
FROM users u
RIGHT JOIN bookings b 
    ON u.id = b.user_id;

---

### ⚙️ Passos a seguir

1. Substitui o conteúdo do teu ficheiro `README.md` por este acima.  
2. Garante que o ficheiro **não está vazio nem contém erros de sintaxe Markdown**.  
3. Faz o commit e o push:
   ```bash
   git add README.md
   git commit -m "fix: complete README with all join queries"
   git push

