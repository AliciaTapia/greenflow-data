-- ============================================================
-- MIGRATION 001 — Tenant Schema Bootstrap
-- Replace :tenant_schema with actual schema name e.g. tenant_abc123
-- ============================================================

CREATE SCHEMA IF NOT EXISTS :tenant_schema;
SET search_path TO :tenant_schema;

\i schemas/tenant/001_employees.sql
\i schemas/tenant/002_customers.sql
\i schemas/tenant/003_services_catalog.sql
\i schemas/tenant/004_jobs.sql
\i schemas/tenant/005_job_assignments.sql
\i schemas/tenant/006_leads.sql
\i schemas/tenant/007_equipment.sql
