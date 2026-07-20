-- ============================================================
-- TENANT SCHEMA: job_assignments
-- Links jobs to employees assigned to perform them.
-- ============================================================

CREATE TABLE IF NOT EXISTS job_assignments (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    job_id              UUID NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
    employee_id         UUID NOT NULL REFERENCES employees(id) ON DELETE CASCADE,
    assignment_role     VARCHAR(50) DEFAULT 'technician',
    is_primary          BOOLEAN NOT NULL DEFAULT FALSE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(job_id, employee_id)
);

CREATE INDEX idx_job_assignments_job_id ON job_assignments(job_id);
CREATE INDEX idx_job_assignments_employee_id ON job_assignments(employee_id);

COMMENT ON TABLE job_assignments IS 'Bridge table between jobs and employees.';
