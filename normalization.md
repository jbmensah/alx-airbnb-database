# Normalization Analysis for Airbnb Database Schema

## Objective:
To analyze and ensure the database schema adheres to the principles of the Third Normal Form (3NF).

---

## 1. First Normal Form (1NF)

- All attributes are atomic (no multi-valued fields).
- Each table has a primary key.
- [x] Achieved.

---

## 2. Second Normal Form (2NF)

- All non-key attributes are fully dependent on the entire primary key.
- No partial dependencies exist.
- [x] Achieved. All tables have simple primary keys (i.e, `user_id`,`property_id`, `booking_id`, etc).

---

## 3. Third Normal Form (3NF)

- There are no transitive dependencies.
- Every non-key attribute is only dependent on the primary key.
- All foreign key relationships (e.g., user to booking) are normalized across separate tables.

[x] All tables were reviewed and confirmed to be in 3NF:
- **User**: User details linked by user ID.
- **Property**: Hosted by a user, no redundant user data.
- **Booking**: References both user (guest) and property; no duplication.
- **Payment**: Linked to one booking only.
- **Review**: Linked to user and property.
- **Message**: Sender and receiver normalized through user ID.

---

## Conclusion

The Airbnb database schema adheres to the principles of 3NF. No structural changes were required during this phase.

