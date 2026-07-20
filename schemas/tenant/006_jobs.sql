-- ============================================================
-- TENANT SCHEMA: jobs
-- Core fact table — each row is one job/service visit.
-- Links to accounts (replaces customer_id).
-- ============================================================

CREATE TABLE IF NOT EXISTS jobs (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id              UUID NOT NULL REFERENCES accounts(id) ON DELETE RESTRICT,
    primary_contact_id      UUID REFERENCES contacts(id) ON DELETE SET NULL,
                            -- the specific contact person for this job
    service_id              UUID REFERENCES services_catalog(id) ON DELETE SET NULL,
    job_type                VARCHAR(50) NOT NULL DEFAULT 'household',
                            -- household | commercial | hoa
    status                  VARCHAR(50) NOT NULL DEFAULT 'new',
                            -- new | scheduled | in_progress | completed | invoiced | cancelled
    title                   VARCHAR(255),
    description             TEXT,
    scheduled_date          DATE,
    scheduled_time_start    TIME,
    scheduled_time_end      TIME,
    actual_start            TIMESTAMPTZ,
    actual_end              TIMESTAMPTZ,
    is_recurring            BOOLEAN DEFAULT FALSE,
    recurrence_interval     VARCHAR(50),                        -- weekly | biweekly | monthly
    parent_job_id           UUID REFERENCES jobs(id),           -- recurring job chain
    quoted_price            NUMERIC(10,2),
    final_price             NUMERIC(10,2),
    notes                   TEXT,
    internal_notes          TEXT,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_jobs_account_id ON jobs(account_id);
CREATE INDEX idx_jobs_status ON jobs(status);
CREATE INDEX idx_jobs_scheduled_date ON jobs(scheduled_date);
CREATE INDEX idx_jobs_job_type ON jobs(job_type);

COMMENT ON TABLE jobs IS 'Core fact table. Each row is a job/visit. Links to account (not customer).';
COMMENT ON COLUMN jobs.status IS 'Workflow: new > scheduled > in_progress > completed > invoiced';
COMMENT ON COLUMN jobs.parent_job_id IS 'Self-reference to chain recurring jobs together';
