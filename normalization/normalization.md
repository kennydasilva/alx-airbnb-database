#  Database Normalization — ALX Airbnb Database

##  Overview
This document explains the normalization process applied to the **Airbnb Database Project**, following the principles of **First (1NF)**, **Second (2NF)**, and **Third Normal Form (3NF)**.

The goal is to eliminate data redundancy, maintain data integrity, and ensure scalability for an Airbnb-like platform.

---

## Initial Observation (Unnormalized Data)
Before normalization, data might be represented in a single, flat table:

| user_name | email | property_name | location | booking_start | booking_end | payment_amount |
|------------|--------|----------------|------------|----------------|--------------|----------------|
| Kenny | kenny@example.com | Cozy Apartment | Maputo | 2025-11-10 | 2025-11-15 | 225.00 |
| Maria | maria@example.com | Beachfront Villa | Ponta do Ouro | 2025-12-20 | 2025-12-25 | 600.00 |

This structure has **redundant data** (e.g., repeating user and property info) and no clear relationships between entities.

---

##  First Normal Form (1NF)
**Rule:** Each column contains atomic values, and each row is unique.

### Changes made:
- Split data into separate entities:
  - **User**
  - **Property**
  - **Booking**
  - **Payment**
- Ensured that every field contains only one value per cell.
- Introduced **Primary Keys** for uniqueness (e.g., `user_id`, `property_id`).

 Result: No repeating groups, all data atomic.

---

##  Second Normal Form (2NF)
**Rule:** Must be in 1NF, and all non-key attributes must depend on the whole primary key.

### Changes made:
- Separated data into logically independent tables:
  - **Booking** references both `user_id` and `property_id` (many-to-many resolved).
  - **Payment** now depends only on `booking_id`.
- Removed partial dependencies by linking each table with **foreign keys**.

 Result: Eliminated partial dependencies — each attribute depends on the entire key.

---

##  Third Normal Form (3NF)
**Rule:** Must be in 2NF, and all fields must depend only on the primary key (no transitive dependency).

### Changes made:
- Removed transitive dependencies:
  - **User** no longer stores property data.
  - **Property** only references its **host** (`host_id`).
  - **Booking** references both **User** and **Property**.
  - **Payment**, **Review**, and **Message** reference **Booking** or **User** directly.
- Each table has a clear, single responsibility.

Result: No transitive dependencies — data integrity and scalability ensured.

---

## Final Normalized Tables
| Table | Primary Key | References | Purpose |
|--------|--------------|-------------|----------|
| `User` | user_id | — | Stores guest, host, and admin information |
| `Property` | property_id | user_id (host_id) | Stores details of each listed property |
| `Booking` | booking_id | user_id, property_id | Links users and properties with reservation info |
| `Payment` | payment_id | booking_id | Stores payment details for each booking |
| `Review` | review_id | property_id, user_id | Stores user reviews and ratings |
| `Message` | message_id | sender_id, recipient_id | Enables communication between users |

---

##  Benefits of Normalization
-  Reduces data redundancy 
- Increases data consistency and integrity 
- Simplifies maintenance and updates 
-  Enhances performance for queries and joins 
- Makes future scaling (e.g., new tables or relationships) easier 

---

## Summary
The **Airbnb database** follows the **3rd Normal Form (3NF)**, ensuring:
- Each table represents a single concept.
- All relationships are properly defined through **foreign keys**.
- The schema supports real-world Airbnb operations (bookings, payments, reviews, messages).

>  Result: A clean, consistent, and efficient relational database design ready for production use.

