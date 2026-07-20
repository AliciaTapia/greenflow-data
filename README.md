# 🌿 greenflow-data

> **Greenflow Platform** — Database schemas, migrations, seed data, and data models.

This repository is the **single source of truth** for all data layer concerns across the Greenflow multi-tenant SaaS platform.

---

## 📁 Repository Structure

```
greenflow-data/
├── schemas/          # SQL schema definitions (DDL)
│   ├── platform/     # Platform-level tables (tenants, subscriptions, billing)
│   └── tenant/       # Tenant-level tables (jobs, employees, customers, leads)
├── migrations/       # Ordered migration scripts
│   ├── platform/
│   └── tenant/
├── seeds/            # Seed data for dev/staging environments
│   ├── platform/
│   └── tenant/
├── docs/             # ERDs, data dictionary, architecture decisions
└── .github/
    └── workflows/    # CI: migration validation and linting
```

---

## 🌿 Branch Strategy

| Branch | Purpose | Direct Push? |
|---|---|---|
| `main` | Production-ready, protected | ❌ PR required + 1 review |
| `staging` | Pre-production validation | ❌ PR required + CI must pass |
| `feature/*` | Individual feature work | ✅ Open, auto-deleted on merge |

---

## 👥 Team Ownership (CODEOWNERS)

| Path | Owner |
|---|---|
| `schemas/**` | @data-team |
| `migrations/**` | @data-team |
| `seeds/**` | @data-team |
| `docs/**` | @data-team |
| `.github/**` | @devops-team |

---

## 🏗️ Multi-Tenancy Model

Greenflow uses **Model B: Shared DB, separate schemas**.

- One PostgreSQL database
- Each tenant gets their own schema namespace: `tenant_<id>`
- Platform-level tables live in the `platform` schema
- This allows clean data isolation without the cost of separate databases

---

## 🚀 Getting Started

```bash
# Clone the repo
git clone https://github.com/AliciaTapia/greenflow-data.git
cd greenflow-data

# Run migrations (requires PostgreSQL)
psql $DATABASE_URL -f migrations/platform/001_create_platform_schema.sql
```

---

## 📋 Related Repositories

| Repo | Purpose |
|---|---|
| `greenflow-platform` | Platform core (tenant mgmt, auth, billing) |
| `greenflow-services` | Business logic (jobs, employees, scheduling, CRM) |
| `greenflow-web` | Frontend (tenant dashboard + lead capture forms) |
| `greenflow-infra` | IaC, reusable workflows, secrets management |

---

> ⚠️ **Never commit secrets or connection strings.** Use GitHub Secrets or environment variables only.
