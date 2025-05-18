SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  u.user_id,
  u.first_name,
  u.last_name
FROM
  booking AS b
  INNER JOIN users AS u
    ON b.user_id = u.user_id;


SELECT
  p.property_id,
  p.name,
  r.review_id,
  r.rating
FROM
  property AS p
  LEFT JOIN review AS r
    ON p.property_id = r.property_id
	ORDER BY p.property_id, r.review_id;


SELECT u.user_id, u.first_name, b.booking_id
FROM users AS u
FULL OUTER JOIN booking AS b
  ON u.user_id = b.user_id;

-- Something I learnt today: MySQL does not implement FULL OUTER JOIN directly and you may likely see an error.
-- Instead, you can achieve the same result using a combination of LEFT JOIN and RIGHT JOIN with UNION.
-- This is a workaround to simulate FULL OUTER JOIN in MySQL.
-- The following query combines the results of both LEFT JOIN and RIGHT JOIN to get all records from both tables.

-- Part 1: all users, plus matching bookings
SELECT *
FROM (
  -- full outer union
  SELECT 
    u.user_id,
    u.first_name,
    b.booking_id
  FROM 
    users AS u
  LEFT JOIN 
    booking AS b
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
      ON u.user_id = b.user_id
) AS full_outer
LIMIT 100;
