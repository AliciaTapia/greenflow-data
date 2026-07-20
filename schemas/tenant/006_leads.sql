-- ============================================================
-- TENANT SCHEMA: leads
-- Inbound leads from the tenant lead capture form
-- Migrated and extended from Integral Exterior prototype
-- ============================================================

CREATE TABLE IF NOT EXISTS leads (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name          VARCHAR(100),
    last_name           VARCHAR(100),
    full_name           VARCHAR(255),
    email               VARCHAR(255) NOT NULL,
    phone               VARCHAR(30),
    service_interest    VARCHAR(100),
    budget_range        VARCHAR(50),
    customer_type       VARCHAR(50) DEFAULT 'residential',
    message             TEXT,
    source              VARCHAR(100) DEFAULT 'website_form',
    status              VARCHAR(50) NOT NULL DEFAULT 'new',
    converted_to        UUID REFERENCES customers(id),
    assigned_to         UUID REFERENCES employees(id),
    notes               TEXT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_leads_status ON leads(status);
CREATE INDEX idx_leads_email ON leads(email);
CREATE INDEX idx_leads_created_at ON leads(created_at DESC);

COMMENT ON TABLE leads IS 'Inbound leads per tenant. Lead becomes a customer when converted_to is populated.';
