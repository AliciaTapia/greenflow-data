-- ============================================================
-- TENANT SCHEMA: services_catalog
-- Catalog of services offered by the tenant.
-- ============================================================

CREATE TABLE IF NOT EXISTS services_catalog (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                VARCHAR(255) NOT NULL,
    service_code        VARCHAR(50),
    category            VARCHAR(100),
    description         TEXT,
    default_price       NUMERIC(10,2),
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_services_catalog_name ON services_catalog(name);
CREATE INDEX idx_services_catalog_active ON services_catalog(is_active);

COMMENT ON TABLE services_catalog IS 'Catalog of services available for jobs.';
