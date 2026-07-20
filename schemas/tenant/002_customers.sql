-- ============================================================
-- TENANT SCHEMA: customers
-- ============================================================

CREATE TABLE IF NOT EXISTS customers (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name          VARCHAR(100) NOT NULL,
    last_name           VARCHAR(100) NOT NULL,
    email               VARCHAR(255),
    phone               VARCHAR(30),
    customer_type       VARCHAR(50) NOT NULL DEFAULT 'residential',
    company_name        VARCHAR(255),
    billing_address     TEXT,
    service_address     TEXT,
    city                VARCHAR(100),
    state               VARCHAR(50),
    zip                 VARCHAR(20),
    preferred_contact   VARCHAR(50) DEFAULT 'email',
    lead_source         VARCHAR(100),
    status              VARCHAR(50) NOT NULL DEFAULT 'active',
    notes               TEXT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_customers_type ON customers(customer_type);
CREATE INDEX idx_customers_status ON customers(status);

COMMENT ON TABLE customers IS 'CRM customer dimension. Covers residential, commercial, and HOA clients.';
