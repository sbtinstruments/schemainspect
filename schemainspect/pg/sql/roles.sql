WITH membership AS (
    SELECT 
        r.rolname,
        array_agg(r1.rolname) as memberships
    FROM
        pg_catalog.pg_roles r
        JOIN pg_catalog.pg_auth_members m
        ON m.member = r.oid
        JOIN pg_roles r1
        ON m.roleid = r1.oid
    GROUP BY
        r.rolname
),
schemas AS (
    select nspname as schema from pg_catalog.pg_namespace
),
roles AS (
    SELECT
        rolname,
        oid
    FROM pg_roles
),
usage_priv AS (
    SELECT 
        r.rolname,
        array_agg(s.schema) as usage
    FROM
        schemas s
        CROSS JOIN roles r
    WHERE pg_catalog.has_schema_privilege(r.oid, s.schema, 'USAGE')
    GROUP BY r.rolname
),
create_priv AS (
    SELECT 
        r.rolname,
        array_agg(s.schema) as creatage
    FROM
        schemas s
        CROSS JOIN roles r
    WHERE pg_catalog.has_schema_privilege(r.oid, s.schema, 'CREATE')
    GROUP BY r.rolname
)
SELECT
    r.rolname,
    r.rolsuper,
    r.rolinherit,
    r.rolcanlogin,
    m.memberships,
    u.usage,
    c.creatage as create
FROM
    pg_roles r
    LEFT JOIN membership m ON r.rolname = m.rolname
    LEFT JOIN usage_priv u ON r.rolname = u.rolname
    LEFT JOIN create_priv c ON r.rolname = c.rolname;
