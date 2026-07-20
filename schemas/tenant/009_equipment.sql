-- ============================================================
-- TENANT SCHEMA: equipment
-- Physical equipment tracked per tenant and optionally assigned to employees.
-- ============================================================

CREATE TABLE IF NOT EXISTS equipment (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                VARCHAR(255) NOT NULL,
    equipment_type      VARCHAR(100),
    serial_number       VARCHAR(100),
    status              VARCHAR(50) NOT NULL DEFAULT 'available',
                        -- available | assigned | maintenance | retired
    assigned_to         UUID REFERENCES employees(id) ON DELETE SET NULL,
    notes               TEXT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_equipment_status ON equipment(status);
CREATE INDEX idx_equipment_assigned_to ON equipment(assigned_to);

COMMENT ON TABLE equipment IS 'Equipment inventory for the tenant. Employees remain separate from contacts.';
