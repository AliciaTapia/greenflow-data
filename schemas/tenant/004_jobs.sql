-- ============================================================
-- TENANT SCHEMA: jobs
-- Core fact table
-- ============================================================

CREATE TABLE IF NOT EXISTS jobs (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id         UUID NOT NULL REFERENCES customers(id) ON DELETE RESTRICT,
    service_id          UUID REFERENCES services_catalog(id) ON DELETE SET NULL,
    job_type            VARCHAR(50) NOT NULL DEFAULT 'residential',
    status              VARCHAR(50) NOT NULL DEFAULT 'new',
    title               VARCHAR(255),
    description         TEXT,
    scheduled_date      DATE,
    scheduled_time_start TIME,
    scheduled_time_end  TIME,
    actual_start        TIMESTAMPTZ,
    actual_end          TIMESTAMPTZ,
    is_recurring        BOOLEAN DEFAULT FALSE,
    recurrence_interval VARCHAR(50),
    parent_job_id       UUID REFERENCES jobs(id),
    quoted_price        NUMERIC(10,2),
    final_price         NUMERIC(10,2),
    notes               TEXT,
    internal_notes      TEXT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_jobs_customer_id ON jobs(customer_id);
CREATE INDEX idx_jobs_status ON jobs(status);
CREATE INDEX idx_jobs_scheduled_date ON jobs(scheduled_date);
CREATE INDEX idx_jobs_job_type ON jobs(job_type);

COMMENT ON TABLE jobs IS 'Core fact table. Each row is a job/service visit.';
COMMENT ON COLUMN jobs.status IS 'Workflow: new > scheduled > in_progress > completed > invoiced';
