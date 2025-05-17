-- Insert Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES 
  (1, 'Kwame', 'Mensah', 'kwame@airbnb.com', 'hashedpass1', '0240000001', 'host'),
  (2, 'Akosua', 'Boateng', 'akosua@airbnb.com', 'hashedpass2', '0240000002', 'guest'),
  (3, 'Yaw', 'Owusu', 'yaw@airbnb.com', 'hashedpass3', '0240000003', 'admin');

-- Insert Properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES 
  (1, 1, 'Cozy Studio in Osu', 'A modern studio in the heart of Accra.', 'Osu, Accra', 300.00),
  (2, 1, 'Beachfront Getaway', '2-bedroom with ocean view.', 'Kokrobite, Accra', 500.00);

-- Insert Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES 
  (1, 1, 2, '2025-06-01', '2025-06-05', 1200.00, 'confirmed'),
  (2, 2, 2, '2025-07-10', '2025-07-12', 1000.00, 'pending');

-- Insert Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES 
  (1, 1, 1200.00, 'credit_card'),
  (2, 2, 1000.00, 'paypal');

-- Insert Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES 
  (1, 1, 2, 5, 'Excellent place! Clean and central.'),
  (2, 2, 2, 4, 'Nice view, but far from shops.');

-- Insert Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES 
  (1, 2, 1, 'Hi, is the Osu studio available in June?'),
  (2, 1, 2, 'Yes, it is available from June 1st to 5th.');
