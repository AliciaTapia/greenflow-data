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
    └── converted_to ──> customers

customers
    └──< jobs (one customer → many jobs)
            │
            ├── service_id ──> services_catalog
            ├──< job_assignments (one job → many employees)
            │       └── employee_id ──> employees
            └── parent_job_id ──> jobs (self-ref for recurring)

employees
    └──< equipment (one employee → assigned equipment)
```

## Key Design Decisions

| Decision | Rationale |
|---|---|
| UUID primary keys | Safe for distributed systems, no sequence conflicts across tenants |
| Separate tenant schemas | Data isolation without separate DB cost |
| `leads` → `customers` conversion | Full funnel tracking from first contact |
| `job_assignments` bridge table | Flexible many-to-many employee rotation |
| `parent_job_id` self-reference | Recurring jobs linked without duplicating data |
| JSONB for features/certifications | Flexible without schema migrations for every new flag |
