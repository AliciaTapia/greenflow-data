-- ============================================================
-- PLATFORM SCHEMA: subscription_plans
-- ============================================================

CREATE TABLE IF NOT EXISTS platform.subscription_plans (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                VARCHAR(50) UNIQUE NOT NULL,
    display_name        VARCHAR(100) NOT NULL,
    price_monthly       NUMERIC(10,2) NOT NULL,
    price_yearly        NUMERIC(10,2),
    max_employees       INTEGER,
    max_jobs_per_month  INTEGER,
    max_customers       INTEGER,
    features            JSONB NOT NULL DEFAULT '{}',
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE platform.subscription_plans IS 'Platform subscription tiers: starter, pro, enterprise';
COMMENT ON COLUMN platform.subscription_plans.features IS 'JSON feature flags e.g. {"custom_branding": true, "api_access": false}';
