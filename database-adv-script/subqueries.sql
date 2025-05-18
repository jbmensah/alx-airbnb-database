-- 1a) Non-Correlated: “High-Rated” Properties
SELECT
  p.property_id,
  p.name,
  p.location
FROM
  property AS p
WHERE
  p.property_id IN (
    SELECT
      r.property_id
    FROM
      review AS r
    GROUP BY
      r.property_id
    HAVING
      AVG(r.rating) > 4.0
  );


-- subqueries.sql

-- 1b) Correlated: “Frequent” Bookers
SELECT
  u.user_id,
  u.first_name,
  u.last_name
FROM
  users AS u
WHERE
  (
    SELECT
      COUNT(*)
    FROM
      booking AS b
    WHERE
      b.user_id = u.user_id
  ) > 3;
