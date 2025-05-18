-- 2a) Aggregation: Total Bookings by User
SELECT
	u.user_id,
	u.first_name,
	u.last_name,
	COUNT(b.booking_id) AS total_bookings
FROM
	users AS u
LEFT JOIN
	booking AS b
	ON u.user_id = b.user_id
GROUP BY
	u.user_id,
	u.first_name,
	u.last_name
ORDER BY
	total_bookings DESC;

-- 2b) Window Function: Rank Properties by Popularity
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
	ON p.property_id = b.property_id
GROUP BY
	p.property_id,
	p.name
) AS property_stats
ORDER BY
rank_by_bookings;
