-- ============================================================
-- TENANT SCHEMA: employees
-- Internal employee records. Kept separate from customer-facing contacts.
-- ============================================================

CREATE TABLE IF NOT EXISTS employees (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name          VARCHAR(100) NOT NULL,
    last_name           VARCHAR(100) NOT NULL,
    email               VARCHAR(255) UNIQUE,
    phone               VARCHAR(30),
    job_title           VARCHAR(100),
    employment_status   VARCHAR(50) NOT NULL DEFAULT 'active',
                        -- active | inactive | terminated
    hire_date           DATE,
    notes               TEXT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_employees_status ON employees(employment_status);
CREATE INDEX idx_employees_last_name ON employees(last_name);

COMMENT ON TABLE employees IS 'Internal employee records. Completely separate from contacts.';
