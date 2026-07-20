-- ============================================================
-- TENANT SCHEMA: services_catalog
-- ============================================================

CREATE TABLE IF NOT EXISTS services_catalog (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                VARCHAR(255) NOT NULL,
    description         TEXT,
    category            VARCHAR(100),
    service_type        VARCHAR(50) NOT NULL DEFAULT 'one_time',
    recurrence_interval VARCHAR(50),
    base_price          NUMERIC(10,2),
    unit                VARCHAR(50),
    applicable_to       VARCHAR(50) DEFAULT 'all',
    seasonal            BOOLEAN DEFAULT FALSE,
    season              VARCHAR(50),
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE services_catalog IS 'Tenant-specific service catalog.';
