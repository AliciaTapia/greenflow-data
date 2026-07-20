-- ============================================================
-- TENANT SCHEMA: equipment
-- ============================================================

CREATE TABLE IF NOT EXISTS equipment (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name            VARCHAR(255) NOT NULL,
    type            VARCHAR(100),
    serial_number   VARCHAR(100),
    purchase_date   DATE,
    status          VARCHAR(50) DEFAULT 'available',
    assigned_to     UUID REFERENCES employees(id),
    notes           TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE equipment IS 'Company equipment inventory.';
