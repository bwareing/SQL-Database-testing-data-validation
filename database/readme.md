

# Database

This folder contains the SQL scripts used to create and populate the database for the Customer Migration Data Validation project.

The database simulates a customer data migration from an older system to a newer system. It includes source customer records, migrated customer records, and customer orders.

## Folder Structure

```text
database/
├── schema/
│   ├── create_database.sql
│   ├── create_tables.sql
│   └── create_constraints.sql
│
└── sample-data/
    ├── customers_old.sql
    ├── customers_new.sql
    └── orders.sql
```

## Schema

The `schema` folder contains scripts for creating and configuring the database.

- **create_database.sql** – Creates the CustomerMigration database.
- **create_tables.sql** – Creates the customer_old, customer_new, and orders tables.
