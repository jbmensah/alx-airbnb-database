-- Speed up JOINs on booking → users
CREATE INDEX idx_booking_user
  ON booking(user_id);

-- Speed up JOINs on booking → property
CREATE INDEX idx_booking_property
  ON booking(property_id);

-- Index date filters on bookings
CREATE INDEX idx_booking_startdate
  ON booking(start_date);

-- Speed up joins on reviews → property
CREATE INDEX idx_review_property
  ON review(property_id);
