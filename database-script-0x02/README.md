# Sample Data Insertion – Airbnb Clone

This directory contains SQL scripts to populate the database schema with realistic test data for the Airbnb Clone project.

## Files

- `seed.sql`: Contains `INSERT` statements for tables: `User`, `Property`, `Booking`, `Payment`, `Review`, and `Message`.

## Usage

To seed the database, run:

```bash
mysql -u root -p < seed.sql
