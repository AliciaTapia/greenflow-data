-- ============================================================
-- MIGRATION 001 — Platform Schema Bootstrap
-- ============================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE SCHEMA IF NOT EXISTS platform;

\i schemas/platform/001_tenants.sql
\i schemas/platform/002_subscription_plans.sql
\i schemas/platform/003_audit_log.sql

INSERT INTO platform.subscription_plans (name, display_name, price_monthly, price_yearly, max_employees, max_jobs_per_month, max_customers, features)
VALUES
    ('starter',    'Starter',    49.00,  470.00,  5,    100,  200,  '{"custom_branding": false, "api_access": false, "recurring_jobs": false}'),
    ('pro',        'Pro',        99.00,  950.00,  25,   NULL, NULL, '{"custom_branding": false, "api_access": false, "recurring_jobs": true}'),
    ('enterprise', 'Enterprise', 249.00, 2390.00, NULL, NULL, NULL, '{"custom_branding": true,  "api_access": true,  "recurring_jobs": true}')
ON CONFLICT (name) DO NOTHING;
