# Task 0: Complex Joins Queries

Welcome to Task 0 of the **Unleashing Advanced Querying Power** project. This directory contains SQL scripts and instructions to practice writing and executing complex JOIN queries against your Airbnb clone schema.

## Objective

Master SQL JOINs by writing three types of JOIN queries:

1. **INNER JOIN** – retrieve all bookings along with the user who made each booking.  
2. **LEFT JOIN** – retrieve all properties and their reviews, including properties without reviews.  
3. **FULL OUTER JOIN** – retrieve all users and all bookings, matched where possible, showing users with no bookings and bookings with no user.

## File Structure

- `joins_queries.sql` – SQL script containing your JOIN queries.  
- `README.md`        – This file, outlining task details and usage.

## Prerequisites

1. **MySQL or PostgreSQL server** installed and running (via WSL, Docker, or native).  
2. A database named `airbnbclone` with the following tables created and populated:  
   - `User`     (fields: `user_id`, `first_name`, `last_name`, `email`, etc.)  
   - `Property` (fields: `property_id`, `host_id`, `name`, `location`, etc.)  
   - `Booking`  (fields: `booking_id`, `user_id`, `property_id`, `start_date`, `end_date`, etc.)  
   - `Review`   (fields: `review_id`, `user_id`, `property_id`, `rating`, `comment`, etc.)  
3. Sample data inserted into each table to test JOIN behavior.

## How to Run

1. Launch your SQL client (e.g., `mysql -u <user> -p airbnbclone` or `psql -U <user> -d airbnbclone`).  
2. Open and execute the commands in `joins_queries.sql`:
   ```sql
   SOURCE path/to/joins_queries.sql;
