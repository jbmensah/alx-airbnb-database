# Task 5: Partitioning Large Tables

## Partitioning Scheme
- **Key:** `start_date`  
- **Method:** RANGE COLUMNS on `start_date` (monthly partitions: `p202501`…`p202507`, `p_max`)

## Query Tested

```sql
SELECT *
FROM booking
WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';
```

| Run    | Actual Time | Scan Type                               |
|--------|-------------|-----------------------------------------|
| Before | 45.5 ms     | Full table scan on `booking_unpartitioned` |
| After  | 1.71 ms     | Partition prune to `p202506` (single-partition scan) |

- Improvement: 96% reduction in execution time