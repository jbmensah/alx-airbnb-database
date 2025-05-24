# Task 6: Monitor and Refine Database Performance

In this task, we continuously monitor three key queries, identify any remaining bottlenecks, apply refinements, and measure improvements.

---

## Queries Monitored

1. **Total Bookings per User**  
2. **CTE Multi-Join Query (Recent Bookings)**  
3. **Partitioned Date-Range Query**

---

### Query 1: Total Bookings per User

```sql
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
```

**Baseline (before any additional tuning)**  
- **Actual Time:** ___ ms  
- **Plan Highlights:**  
  - Scan type on `booking`: ___  
  - Index used on `users.user_id`: ___

**Refinement Applied**  
- e.g., Added composite index `(user_id, booking_id)` on `booking` to make this a covering index.  

**Optimized**  
- **Actual Time:** ___ ms  
- **Plan Highlights:**  
  - Covering index scan on `booking(idx_booking_user_bookingid)`  
  - No temporary tables or file sorts

**Improvement:** ___% reduction

---

### Query 2: CTE Multi-Join Query (Recent Bookings)

```sql
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
  JOIN property AS p   ON rb.property_id = p.property_id
  JOIN users    AS u   ON rb.user_id     = u.user_id
  LEFT JOIN payment  AS pay ON rb.booking_id  = pay.booking_id;
```

**Baseline**  
- **Actual Time:** 1.83 ms  
- **Plan Highlights:**  
  - Index lookup on `booking(idx_booking_property)` and `booking(idx_booking_user)`  
  - Table scan on `payment` (small subset)

**Refinement Applied**  
- e.g., Created covering index on `payment(booking_id, payment_date)` to avoid full scan.  

**Optimized**  
- **Actual Time:** ___ ms  
- **Plan Highlights:**  
  - Covering index scan on `payment(idx_payment_bookingid_date)`  
  - No hash joins, all index-driven

**Improvement:** ___% reduction

---

### Query 3: Partitioned Date-Range Query

```sql
SELECT *
FROM booking
WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';
```

**Baseline (unpartitioned table)**  
- **Actual Time:** 45.5 ms  
- **Plan Highlights:**  
  - Full table scan on `booking_unpartitioned`

**Partitioned**  
- **Actual Time:** 1.71 ms  
- **Plan Highlights:**  
  - Partition prune to `p202506` only (single-partition scan)

**Improvement:** 96% reduction

---

## Summary of Findings

- **Total Bookings per User:** _Placeholder_  
- **CTE Multi-Join:** _Placeholder_  
- **Partitioned Date-Range:** 45.5 ms → 1.71 ms (↓96%)

Continuous monitoring and targeted refinements (covering indexes, query rewrites, partition pruning) keep these critical queries running at peak performance.
