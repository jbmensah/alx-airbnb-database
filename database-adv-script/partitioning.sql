-- 0) Ensure a clean start
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS booking_unpartitioned;

-- 1) Rename your live table to keep a backup
RENAME TABLE booking TO booking_unpartitioned;

-- 2) Recreate `booking` as partitioned WITHOUT FKs to property/users
CREATE TABLE booking (
  booking_id    CHAR(36)      NOT NULL DEFAULT (UUID()),
  start_date    DATE          NOT NULL,
  property_id   CHAR(36)      NOT NULL,
  user_id       CHAR(36)      NOT NULL,
  end_date      DATE          NOT NULL,
  total_price   DECIMAL(10,2) NOT NULL,
  `status`        ENUM('pending','confirmed','canceled') NOT NULL,
  created_at    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- composite PK must include the partition column
  PRIMARY KEY (booking_id, start_date),
  -- keep indexes for join performance
  INDEX idx_booking_property (property_id),
  INDEX idx_booking_user     (user_id)
  -- NO FOREIGN KEY clauses here!
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci
PARTITION BY RANGE COLUMNS(start_date) (
  PARTITION p202501 VALUES LESS THAN ('2025-02-01'),
  PARTITION p202502 VALUES LESS THAN ('2025-03-01'),
  PARTITION p202503 VALUES LESS THAN ('2025-04-01'),
  PARTITION p202504 VALUES LESS THAN ('2025-05-01'),
  PARTITION p202505 VALUES LESS THAN ('2025-06-01'),
  PARTITION p202506 VALUES LESS THAN ('2025-07-01'),
  PARTITION p202507 VALUES LESS THAN ('2025-08-01'),
  PARTITION p_max   VALUES LESS THAN (MAXVALUE)
);

-- 3) Migrate all rows into the new partitioned table
INSERT INTO booking
  (booking_id,
   start_date,
   property_id,
   user_id,
   end_date,
   total_price,
   status,
   created_at)
SELECT
  booking_id,
  start_date,
  property_id,
  user_id,
  end_date,
  total_price,
  status,
  created_at
FROM booking_unpartitioned;

-- 4) Drop the old copy
DROP TABLE booking_unpartitioned;

-- 5) Re-enable foreign key enforcement
SET FOREIGN_KEY_CHECKS = 1;

EXPLAIN ANALYZE 
SELECT * 
FROM booking_unpartitioned
WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';


EXPLAIN ANALYZE 
SELECT * 
FROM booking
WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';