# 🗺️ Greenflow Data — Entity Relationship Overview

## Platform Layer

```
platform.tenants
    │
    ├──< platform.subscription_plans (many tenants → one plan)
    └──< platform.audit_log (one tenant → many log entries)
```

## Tenant Layer (per-tenant schema)

```
leads
    ├── converted_to_account_id ──> accounts
    └── converted_to_contact_id ──> contacts

accounts (parent)
    └──< accounts (children, self-ref for multi-location)
            │
            ├── primary_contact_id ──> contacts
            ├──< account_contacts ──> contacts (many-to-many)
            └──< jobs
                    │
                    ├── account_id         ──> accounts
                    ├── primary_contact_id ──> contacts
                    ├── service_id         ──> services_catalog
                    ├──< job_assignments   ──> employees
                    └── parent_job_id      ──> jobs (self-ref, recurring)

employees (independent — HR data only)
    ├──< job_assignments
    └──< equipment (assigned_to)
```

## Example Queries

### All jobs for an account in a given year

```sql
SELECT a.name, j.title, j.job_type, j.status, j.scheduled_date, j.final_price
FROM jobs j
JOIN accounts a ON j.account_id = a.id
WHERE a.name = 'Greenview HOA'
  AND EXTRACT(YEAR FROM j.scheduled_date) = 2027
ORDER BY j.scheduled_date;
```

### All child accounts under a parent

```sql
SELECT id, name, account_type, service_city
FROM accounts
WHERE parent_account_id = '11111111-1111-1111-1111-111111111111';
```

### Contacts for an account

```sql
SELECT a.name,
       c.first_name,
       c.last_name,
       ac.role_on_account,
       c.email,
       c.phone
FROM account_contacts ac
JOIN accounts a ON ac.account_id = a.id
JOIN contacts c ON ac.contact_id = c.id
WHERE a.name = 'Greenview HOA'
ORDER BY c.last_name, c.first_name;
```
