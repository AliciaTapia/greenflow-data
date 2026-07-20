-- ============================================================
-- TENANT SCHEMA: contacts
-- Individual people associated with accounts.
-- Employees are NOT contacts — they are managed separately.
-- ============================================================

CREATE TABLE IF NOT EXISTS contacts (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name          VARCHAR(100) NOT NULL,
    last_name           VARCHAR(100) NOT NULL,
    email               VARCHAR(255),
    phone               VARCHAR(30),
    mobile              VARCHAR(30),
    contact_type        VARCHAR(50) NOT NULL DEFAULT 'other',
                        -- homeowner | manager | decision_maker | billing | operations | legal | other
    title               VARCHAR(100),                           -- e.g. "Property Manager", "HOA President"
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    preferred_contact   VARCHAR(50) DEFAULT 'email',           -- email | phone | text
    notes               TEXT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_contacts_type ON contacts(contact_type);
CREATE INDEX idx_contacts_email ON contacts(email);

COMMENT ON TABLE contacts IS 'Individual people linked to accounts. Completely separate from employees.';
COMMENT ON COLUMN contacts.contact_type IS 'Role of this person in the business relationship';

-- Now that contacts exists, add the FK constraint on accounts when present
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = current_schema()
          AND table_name = 'accounts'
    ) AND NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE constraint_schema = current_schema()
          AND table_name = 'accounts'
          AND constraint_name = 'fk_accounts_primary_contact'
    ) THEN
        ALTER TABLE accounts
            ADD CONSTRAINT fk_accounts_primary_contact
            FOREIGN KEY (primary_contact_id) REFERENCES contacts(id) ON DELETE SET NULL;
    END IF;
END $$;
