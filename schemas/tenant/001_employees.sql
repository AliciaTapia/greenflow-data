-- ============================================================
-- TENANT SCHEMA: employees
-- ============================================================

CREATE TABLE IF NOT EXISTS employees (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(255) UNIQUE,
    phone           VARCHAR(30),
    role            VARCHAR(50) NOT NULL DEFAULT 'crew',
    status          VARCHAR(50) NOT NULL DEFAULT 'active',
    hire_date       DATE,
    hourly_rate     NUMERIC(8,2),
    certifications  JSONB DEFAULT '[]',
    notes           TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE employees IS 'Tenant employee roster.';
COMMENT ON COLUMN employees.role IS 'crew = field worker, crew_lead = team lead, supervisor = manager, admin = office';
