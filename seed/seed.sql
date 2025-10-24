-- ==========================================================
-- ALX AIRBNB DATABASE SEED DATA
-- ==========================================================
-- Author: Kenny DaSilva
-- Description: Populating the Airbnb-like database with
-- realistic sample data for testing and development.
-- ==========================================================

-- Enable pgcrypto for UUID generation (PostgreSQL only)
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ==========================================================
-- INSERT USERS
-- ==========================================================
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (gen_random_uuid(), 'Kenny', 'Dasilva', 'kenny@example.com', 'hashed_password_1', '+258841112233', 'host'),
    (gen_random_uuid(), 'Maria', 'Joaquina', 'maria@example.com', 'hashed_password_2', '+258841145678', 'guest'),
    (gen_random_uuid(), 'Carlos', 'Matos', 'carlos@example.com', 'hashed_password_3', '+258841167890', 'guest'),
    (gen_random_uuid(), 'Ana', 'Silva', 'ana@example.com', 'hashed_password_4', '+258841178945', 'host'),
    (gen_random_uuid(), 'Admin', 'Root', 'admin@example.com', 'hashed_password_5', NULL, 'admin');

-- ==========================================================
--  INSERT PROPERTIES
-- ==========================================================
-- Get host IDs dynamically (you can replace with fixed UUIDs if needed)
-- For simplicity in some DBs, assume manual UUIDs

INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
    (gen_random_uuid(), (SELECT user_id FROM User WHERE email='kenny@example.com'),
     'Cozy Apartment in Maputo', 'A modern one-bedroom apartment near the city center.', 'Maputo City, Mozambique', 45.00),

    (gen_random_uuid(), (SELECT user_id FROM User WHERE email='ana@example.com'),
     'Beachfront Villa', 'Beautiful villa facing the ocean with private pool and terrace.', 'Ponta do Ouro, Mozambique', 120.00);

-- ==========================================================
--  INSERT BOOKINGS
-- ==========================================================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
    (gen_random_uuid(),
     (SELECT property_id FROM Property WHERE name='Cozy Apartment in Maputo'),
     (SELECT user_id FROM User WHERE email='maria@example.com'),
     '2025-11-10', '2025-11-15', 225.00, 'confirmed'),

    (gen_random_uuid(),
     (SELECT property_id FROM Property WHERE name='Beachfront Villa'),
     (SELECT user_id FROM User WHERE email='carlos@example.com'),
     '2025-12-20', '2025-12-25', 600.00, 'pending');

-- ==========================================================
--  INSERT PAYMENTS
-- ==========================================================
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
    (gen_random_uuid(),
     (SELECT booking_id FROM Booking WHERE total_price=225.00),
     225.00, 'credit_card'),

    (gen_random_uuid(),
     (SELECT booking_id FROM Booking WHERE total_price=600.00),
     600.00, 'paypal');

-- ==========================================================
--  INSERT REVIEWS
-- ==========================================================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
    (gen_random_uuid(),
     (SELECT property_id FROM Property WHERE name='Cozy Apartment in Maputo'),
     (SELECT user_id FROM User WHERE email='maria@example.com'),
     5, 'The apartment was clean, cozy, and close to everything. Highly recommended!'),

    (gen_random_uuid(),
     (SELECT property_id FROM Property WHERE name='Beachfront Villa'),
     (SELECT user_id FROM User WHERE email='carlos@example.com'),
     4, 'Amazing view and great location, but Wi-Fi could be better.');

-- ==========================================================
--  INSERT MESSAGES
-- ==========================================================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
    (gen_random_uuid(),
     (SELECT user_id FROM User WHERE email='maria@example.com'),
     (SELECT user_id FROM User WHERE email='kenny@example.com'),
     'Hi Kenny! Is your apartment available for next month?'),

    (gen_random_uuid(),
     (SELECT user_id FROM User WHERE email='kenny@example.com'),
     (SELECT user_id FROM User WHERE email='maria@example.com'),
     'Hi Maria! Yes, it will be available. You can book directly through the platform.');

-- ==========================================================
--  SEEDING COMPLETE
-- ==========================================================

