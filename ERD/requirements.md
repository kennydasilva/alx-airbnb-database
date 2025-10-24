# Airbnb Database ER Diagram

## Entities
- User
- Property
- Booking
- Payment
- Review
- Message

## Relationships
- User (host) 1 → N Property
- User 1 → N Booking
- Property 1 → N Booking
- Booking 1 → 1 Payment
- Property 1 → N Review
- User 1 → N Review
- User (sender) 1 → N Message (recipient)

## Design Notes
- UUIDs used as primary keys for scalability.
- ENUMs used for controlled fields like role, status, payment_method.
- Foreign keys ensure referential integrity.
- Indexes applied on email, property_id, and booking_id for performance.

https://drive.google.com/file/d/1sVZoO64oMiTKUg4DQc_WITxOjBOl2QaK/view?usp=sharing

