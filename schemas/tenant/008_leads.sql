-- ============================================================
-- TENANT SCHEMA: leads
-- Inbound leads from the tenant lead capture form.
-- Migrated and extended from Integral Exterior prototype.
-- ============================================================

CREATE TABLE IF NOT EXISTS leads (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name              VARCHAR(100),
    last_name               VARCHAR(100),
    full_name               VARCHAR(255),                       -- fallback for single-field forms
    email                   VARCHAR(255) NOT NULL,
    phone                   VARCHAR(30),
    service_interest        VARCHAR(100),
    budget_range            VARCHAR(50),
    account_type            VARCHAR(50) DEFAULT 'household',    -- household | commercial | hoa
    message                 TEXT,
    source                  VARCHAR(100) DEFAULT 'website_form',
                            -- website_form | phone | referral | social | nextdoor
    status                  VARCHAR(50) NOT NULL DEFAULT 'new',
                            -- new | contacted | qualified | converted | lost
    converted_to_account_id UUID REFERENCES accounts(id) ON DELETE SET NULL,
    converted_to_contact_id UUID REFERENCES contacts(id) ON DELETE SET NULL,
    assigned_to             UUID REFERENCES employees(id) ON DELETE SET NULL,
    notes                   TEXT,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_leads_status ON leads(status);
CREATE INDEX idx_leads_email ON leads(email);
CREATE INDEX idx_leads_created_at ON leads(created_at DESC);

COMMENT ON TABLE leads IS 'Inbound leads per tenant. Converted when converted_to_account_id and converted_to_contact_id are populated.';
