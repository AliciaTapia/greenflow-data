-- ============================================================
-- TENANT SCHEMA: accounts
-- The top-level CRM entity. Replaces the customers table.
-- Represents any entity we do business with or track.
-- ============================================================

CREATE TABLE IF NOT EXISTS accounts (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                VARCHAR(255) NOT NULL,
    account_type        VARCHAR(50) NOT NULL DEFAULT 'household',
                        -- household | commercial | hoa | property_mgmt | government | other
    status              VARCHAR(50) NOT NULL DEFAULT 'active',
                        -- prospect | active | inactive | suspended
    parent_account_id   UUID REFERENCES accounts(id) ON DELETE SET NULL,
                        -- self-reference for multi-location / parent company
    primary_contact_id  UUID,
                        -- FK to contacts(id) added after contacts table is created
    industry            VARCHAR(100),
    website             VARCHAR(255),
    billing_address     TEXT,
    billing_city        VARCHAR(100),
    billing_state       VARCHAR(50),
    billing_zip         VARCHAR(20),
    service_address     TEXT,
    service_city        VARCHAR(100),
    service_state       VARCHAR(50),
    service_zip         VARCHAR(20),
    lead_source         VARCHAR(100),
                        -- website | referral | nextdoor | social | cold_call | other
    notes               TEXT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_accounts_type ON accounts(account_type);
CREATE INDEX idx_accounts_status ON accounts(status);
CREATE INDEX idx_accounts_parent ON accounts(parent_account_id);

COMMENT ON TABLE accounts IS 'Top-level CRM entity. Replaces customers. One account can have many contacts and many jobs.';
COMMENT ON COLUMN accounts.parent_account_id IS 'Enables parent/child hierarchy e.g. franchise with multiple locations';
COMMENT ON COLUMN accounts.primary_contact_id IS 'The main point of contact for this account';
