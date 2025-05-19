# Task 3: Index Performance

## Query 1: Full-Outer UNION (Users ↔ Bookings)

| Run    | Actual Time | Scan Type                               |
|--------|-------------|-----------------------------------------|
| Before | 0.656 ms    | Table scan on `booking` (forced via IGNORE INDEX) |
| After  | 0.177 ms    | Covering index lookup on `idx_booking_user`      |

## Query 2: Property Ranking (ROW_NUMBER() & RANK())

| Run    | Actual Time | Scan Type                                                                   |
|--------|-------------|-----------------------------------------------------------------------------|
| Before | 62.5 ms     | Full table scan on `property_stats` (hash join on `booking.property_id`)    |
| After  | 3.92 ms     | Index-assisted hash join via `idx_booking_property` (covering index lookup) |
