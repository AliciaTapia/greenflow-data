-- ============================================================
-- PLATFORM SCHEMA: audit_log
-- Platform-wide audit trail — who did what, when
-- ============================================================

CREATE TABLE IF NOT EXISTS platform.audit_log (
    id              BIGSERIAL PRIMARY KEY,
    tenant_id       UUID REFERENCES platform.tenants(id) ON DELETE SET NULL,
    user_id         UUID,
    action          VARCHAR(100) NOT NULL,
    resource_type   VARCHAR(100),
    resource_id     UUID,
    old_values      JSONB,
    new_values      JSONB,
    ip_address      INET,
    user_agent      TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_audit_log_tenant_id ON platform.audit_log(tenant_id);
CREATE INDEX idx_audit_log_created_at ON platform.audit_log(created_at DESC);
CREATE INDEX idx_audit_log_action ON platform.audit_log(action);

COMMENT ON TABLE platform.audit_log IS 'Immutable audit trail for all platform actions across all tenants';
