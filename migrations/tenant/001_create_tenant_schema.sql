-- ============================================================
-- MIGRATION 001 — Tenant Schema Bootstrap
-- Run once per new tenant onboarding
-- Replace :tenant_schema with actual schema name e.g. tenant_abc123
-- ============================================================

CREATE SCHEMA IF NOT EXISTS :tenant_schema;
SET search_path TO :tenant_schema;

\i schemas/tenant/001_employees.sql
\i schemas/tenant/002_accounts.sql
\i schemas/tenant/003_contacts.sql
\i schemas/tenant/004_account_contacts.sql
\i schemas/tenant/005_services_catalog.sql
\i schemas/tenant/006_jobs.sql
\i schemas/tenant/007_job_assignments.sql
\i schemas/tenant/008_leads.sql
\i schemas/tenant/009_equipment.sql
