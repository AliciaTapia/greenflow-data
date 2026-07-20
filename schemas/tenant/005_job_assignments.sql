-- ============================================================
-- TENANT SCHEMA: job_assignments
-- Employee rotation fact table
-- ============================================================

CREATE TABLE IF NOT EXISTS job_assignments (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    job_id          UUID NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
    employee_id     UUID NOT NULL REFERENCES employees(id) ON DELETE RESTRICT,
    role_on_job     VARCHAR(50) DEFAULT 'crew',
    assigned_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    accepted_at     TIMESTAMPTZ,
    completed_at    TIMESTAMPTZ,
    hours_worked    NUMERIC(5,2),
    notes           TEXT,
    UNIQUE(job_id, employee_id)
);

CREATE INDEX idx_job_assignments_job_id ON job_assignments(job_id);
CREATE INDEX idx_job_assignments_employee_id ON job_assignments(employee_id);

COMMENT ON TABLE job_assignments IS 'Employee rotation bridge table. Links employees to jobs.';
