-- 4a) Initial complex query (corrected payment fields)
EXPLAIN ANALYZE
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  u.user_id,
  u.first_name,
  u.last_name,
  p.property_id,
  p.name            AS property_name,
  p.location        AS property_location,
  pay.payment_id,
  pay.amount        AS payment_amount,
  pay.payment_date  AS payment_date,
  pay.payment_method AS payment_method
FROM
  booking    AS b
  INNER JOIN users    AS u   ON b.user_id     = u.user_id
  INNER JOIN property AS p   ON b.property_id = p.property_id
  LEFT  JOIN payment  AS pay ON b.booking_id  = pay.booking_id;


-- 4b) Refactored: filter + CTE for index-friendly joins
EXPLAIN ANALYZE
WITH recent_bookings AS (
  SELECT
    booking_id,
    user_id,
    property_id,
    start_date,
    end_date
  FROM
    booking
  WHERE
    start_date >= CURRENT_DATE - INTERVAL '6' MONTH
    AND status = 'confirmed'
)
SELECT
  rb.booking_id,
  rb.start_date,
  rb.end_date,
  u.first_name,
  u.last_name,
  p.name          AS property_name,
  p.location      AS property_location,
  pay.payment_id,
  pay.amount      AS payment_amount,
  pay.payment_date
FROM
  recent_bookings AS rb
  JOIN property AS p
    ON rb.property_id = p.property_id
  JOIN users    AS u
    ON rb.user_id     = u.user_id
  LEFT JOIN payment  AS pay
    ON rb.booking_id  = pay.booking_id;

