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

EXPLAIN ANALYZE
SELECT *
FROM (
  -- full outer union, ignoring booking→user index and booking→property index
  SELECT 
    u.user_id,
    u.first_name,
    b.booking_id
  FROM 
    users AS u
  LEFT JOIN 
    booking AS b
    IGNORE INDEX (idx_booking_user, idx_booking_property, idx_booking_startdate)
      ON u.user_id = b.user_id

  UNION

  SELECT 
    u.user_id,
    u.first_name,
    b.booking_id
  FROM 
    users AS u
  RIGHT JOIN 
    booking AS b
    IGNORE INDEX (idx_booking_user, idx_booking_property, idx_booking_startdate)
      ON u.user_id = b.user_id
) AS full_outer
LIMIT 100;

EXPLAIN ANALYZE
SELECT
	property_id,
	name,
	bookings_count,
ROW_NUMBER() OVER (
	ORDER BY bookings_count DESC
	) AS rank_by_bookings, 
RANK() OVER (
	ORDER BY bookings_count DESC
) AS rank_by_bookings
FROM (
SELECT
	p.property_id,
	p.name,
	COUNT(b.booking_id) AS bookings_count
FROM
	property AS p
LEFT JOIN
	booking AS b
  IGNORE INDEX (idx_booking_property, idx_booking_startdate)
	ON p.property_id = b.property_id
GROUP BY
	p.property_id,
	p.name
) AS property_stats
ORDER BY
rank_by_bookings;


-- DROP INDEX idx_booking_user    ON booking;
-- DROP INDEX idx_booking_property ON booking;
-- DROP INDEX idx_booking_startdate ON booking;
-- DROP INDEX idx_review_property ON review;