-- ============================================================
-- SEED: Integral Exterior — Tenant #1 (Spring, TX)
-- Pilot tenant migrated from the prototype
-- ============================================================

INSERT INTO platform.tenants (name, slug, schema_name, email, phone, city, state, subscription_plan)
VALUES (
    'Integral Exterior',
    'integral-exterior',
    'tenant_integral_exterior',
    'integralexteriorservices@gmail.com',
    '(281) 677-1544',
    'Spring',
    'TX',
    'pro'
) ON CONFLICT (slug) DO NOTHING;

SET search_path TO tenant_integral_exterior;

INSERT INTO services_catalog (name, category, service_type, recurrence_interval, base_price, unit, applicable_to)
VALUES
    ('Lawn Mowing',          'maintenance', 'recurring', 'weekly',   65.00,  'per_visit', 'all'),
    ('Lawn Mowing Biweekly', 'maintenance', 'recurring', 'biweekly', 85.00,  'per_visit', 'all'),
    ('Landscape Design',     'design',      'one_time',  NULL,       500.00, 'flat',      'all'),
    ('Hardscaping',          'hardscaping', 'one_time',  NULL,       NULL,   'per_sqft',  'all'),
    ('Irrigation Install',   'irrigation',  'one_time',  NULL,       NULL,   'flat',      'all'),
    ('Irrigation Repair',    'irrigation',  'one_time',  NULL,       150.00, 'flat',      'all'),
    ('Tree Trimming',        'tree',        'one_time',  NULL,       200.00, 'per_visit', 'all'),
    ('Tree Removal',         'tree',        'one_time',  NULL,       NULL,   'flat',      'all'),
    ('Plant Installation',   'design',      'one_time',  NULL,       NULL,   'flat',      'all'),
    ('Seasonal Cleanup',     'maintenance', 'one_time',  NULL,       150.00, 'flat',      'all')
ON CONFLICT DO NOTHING;
