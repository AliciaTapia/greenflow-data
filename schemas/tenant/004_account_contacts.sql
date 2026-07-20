-- ============================================================
-- TENANT SCHEMA: account_contacts
-- Bridge table: many-to-many between accounts and contacts.
-- One contact can be associated with multiple accounts.
-- ============================================================

CREATE TABLE IF NOT EXISTS account_contacts (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id          UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
    contact_id          UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
    role_on_account     VARCHAR(50) DEFAULT 'general',
                        -- primary | billing | operations | legal | general
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(account_id, contact_id)
);

CREATE INDEX idx_account_contacts_account ON account_contacts(account_id);
CREATE INDEX idx_account_contacts_contact ON account_contacts(contact_id);

COMMENT ON TABLE account_contacts IS 'Many-to-many bridge between accounts and contacts. One contact can belong to multiple accounts.';
