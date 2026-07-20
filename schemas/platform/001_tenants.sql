-- ============================================================
-- PLATFORM SCHEMA: tenants
-- Stores all landscaping companies using the Greenflow platform
-- ============================================================

CREATE SCHEMA IF NOT EXISTS platform;

CREATE TABLE IF NOT EXISTS platform.tenants (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                VARCHAR(255) NOT NULL,
    slug                VARCHAR(100) UNIQUE NOT NULL,
    schema_name         VARCHAR(100) UNIQUE NOT NULL,
    email               VARCHAR(255) UNIQUE NOT NULL,
    phone               VARCHAR(30),
    address             TEXT,
    city                VARCHAR(100),
    state               VARCHAR(50),
    zip                 VARCHAR(20),
    country             VARCHAR(50) DEFAULT 'US',
    website             VARCHAR(255),
    logo_url            VARCHAR(500),
    subscription_plan   VARCHAR(50) NOT NULL DEFAULT 'starter',
    subscription_status VARCHAR(50) NOT NULL DEFAULT 'active',
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    trial_ends_at       TIMESTAMPTZ,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE platform.tenants IS 'Each row is a landscaping company (tenant) on the Greenflow platform';
COMMENT ON COLUMN platform.tenants.slug IS 'Used in tenant-specific URLs e.g. app.greenflow.io/integral-exterior';
COMMENT ON COLUMN platform.tenants.schema_name IS 'PostgreSQL schema name for this tenants isolated data';
